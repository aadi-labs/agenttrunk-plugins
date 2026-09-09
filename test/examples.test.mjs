import { test } from 'node:test';
import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { AgentTrunk } from '@agenttrunk/sdk';
import { collectPages } from '../examples/shared.mjs';
import { quickstart } from '../examples/quickstart/index.mjs';
import { loadContext } from '../examples/pinned-context/index.mjs';
import { publishSkill, skillPackage } from '../examples/publish-skill/index.mjs';
import { reviewReleases } from '../examples/release-review/index.mjs';

const revision = 'a'.repeat(64);
const hash = bytes => createHash('sha256').update(bytes).digest('hex');
const token = 'local-test-only';

test('pagination follows empty pages and exposes truncation, rejecting cursor loops', async () => {
  const cursors = [];
  const result = await collectPages(async cursor => {
    cursors.push(cursor);
    return cursor ? {data: ['found'], nextCursor: null} : {data: [], nextCursor: 'next'};
  });
  assert.deepEqual(cursors, [undefined, 'next']);
  assert.deepEqual(result.data, ['found']);
  assert.equal(result.truncated, false);
  assert.deepEqual(await collectPages(async () => ({data: [], nextCursor: 'next'}), 1), {data: [], nextCursor: 'next', truncated: true});
  await assert.rejects(collectPages(async () => ({data: [], nextCursor: 'loop'})), /repeated/);
});

test('quickstart lists choices without creating or selecting an arbitrary workspace', async () => {
  const client = new AgentTrunk({token, fetch: async (url, init) => {
    assert.equal(init.method, 'GET'); assert.equal(url.pathname, '/v1/trunks');
    return Response.json({data: [{id: 'workspace_1'}, {id: 'workspace_2'}]});
  }});
  const result = await quickstart(client);
  assert.equal(result.data.length, 2);
  assert.match(result.nextStep, /Choose/);
});

test('pinned context keeps discovery revision through verified reads and rejects corrupt bytes', async () => {
  for (const corrupt of [false, true]) {
    const bytes = Buffer.from('reviewed context');
    const manifest = {path: 'SKILL.md', size: bytes.length, sha256: hash(bytes)};
    const client = new AgentTrunk({token, fetch: async (url, init) => {
      assert.equal(init.method, 'GET');
      if (url.pathname === '/v1/contexts') {
        assert.equal(url.searchParams.get('trunkId'), 'workspace_1');
        assert.equal(url.searchParams.get('channel'), 'production');
        return Response.json({data: [{trunkId: 'workspace_1', contextKey: 'support', revisionId: revision}]});
      }
      assert.equal(url.searchParams.get('ref'), revision);
      if (url.pathname.endsWith('/files/SKILL.md')) return new Response(corrupt ? 'tampered' : bytes);
      return Response.json({context: {key: 'support'}, revision: {id: revision, packageDigest: 'b'.repeat(64), files: [manifest]}});
    }});
    if (corrupt) await assert.rejects(loadContext(client, {workspaceId: 'workspace_1'}), /integrity/);
    else {
      const result = await loadContext(client, {workspaceId: 'workspace_1'});
      assert.equal(result.pin.revisionId, revision);
      assert.deepEqual(Buffer.from(result.bytes), bytes);
    }
  }
});

test('skill preview has no network calls; explicit write stages and verifies every packaged file', async () => {
  const config = {workspaceId: 'workspace_1', scopeId: 'scope_1', contextKey: 'example'};
  assert.equal((await publishSkill(undefined, config)).mode, 'preview');
  const input = skillPackage(config.scopeId, config.contextKey);
  const manifest = input.files.map(file => {
    const bytes = Buffer.from(file.contentBase64, 'base64');
    return {path: file.path, size: bytes.length, sha256: hash(bytes)};
  });
  let writes = 0, reads = 0;
  const inspected = {context: {key: 'example'}, revision: {id: revision, packageDigest: 'b'.repeat(64), files: manifest}};
  const client = new AgentTrunk({token, fetch: async (url, init) => {
    if (init.method === 'POST') {
      assert.equal(url.pathname, '/v1/trunks/workspace_1/publications');
      assert.deepEqual(JSON.parse(init.body), input); writes++;
      return Response.json(inspected);
    }
    assert.equal(url.searchParams.get('ref'), revision);
    if (url.pathname.includes('/files/')) {
      const path = url.pathname.split('/files/')[1];
      const file = input.files.find(file => file.path === path);
      assert.ok(file); reads++;
      return new Response(Buffer.from(file.contentBase64, 'base64'));
    }
    return Response.json(inspected);
  }});
  const result = await publishSkill(client, {...config, write: true});
  assert.equal(writes, 1); assert.equal(reads, 2);
  assert.equal(result.productionChanged, false);
});

test('release review is read-only by default and never merges when opening a request', async () => {
  for (const open of [false, true]) {
    let writes = 0;
    const promotion = {id: 'pr_1', changes: [{contextKey: 'a'}, {contextKey: 'b'}]};
    const client = new AgentTrunk({token, fetch: async (url, init) => {
      assert.equal(url.pathname, '/v1/trunks/workspace_1/promotion-requests');
      if (init.method === 'POST') {writes++; return Response.json(promotion);}
      assert.equal(url.searchParams.get('scopeId'), 'scope_1');
      return Response.json({data: [promotion]});
    }});
    const result = await reviewReleases(client, {workspaceId: 'workspace_1', scopeId: 'scope_1', open, evidenceReference: 'review-report-1'});
    assert.equal(writes, open ? 1 : 0);
    assert.equal(result.data[0].changes.length, 2);
    assert.equal(result.productionChanged, false);
  }
  await assert.rejects(reviewReleases(undefined, {workspaceId: 'workspace_1', scopeId: 'scope_1', open: true}), /evidence/);
});
