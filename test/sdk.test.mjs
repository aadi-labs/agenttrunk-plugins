import {test} from 'node:test';
import assert from 'node:assert/strict';
import {createHash} from 'node:crypto';
import {AgentTrunk, AgentTrunkError, resourcePath} from '../dist/sdk/index.js';

const token = 'test-token-not-real';
const revision = 'a'.repeat(64);
const bytes = new TextEncoder().encode('hello');
const file = {path: 'prompts/system.md', size: bytes.length, sha256: createHash('sha256').update(bytes).digest('hex')};
const json = value => Response.json(value);
test('scoped discovery encodes filters and preserves empty continuation pages', async () => {
  const client = new AgentTrunk({token, fetch: async (url, init) => {
    assert.equal(url.origin, 'https://api.agenttrunk.ai');
    assert.equal(url.pathname, '/v1/contexts');
    assert.equal(url.searchParams.get('query'), 'a & b');
    assert.equal(url.searchParams.get('trunkId'), 'trunk_1');
    assert.equal(url.searchParams.get('cursor'), 'next');
    assert.equal(init.headers.authorization, `Bearer ${token}`);
    assert.equal(init.redirect, 'error');
    return json({data: [], nextCursor: 'continue'});
  }});
  assert.deepEqual(await client.discover({query: 'a & b', trunkId: 'trunk_1', cursor: 'next'}), {data: [], nextCursor: 'continue'});
});
test('token callback is evaluated for every request', async () => {
  let n = 0;
  const client = new AgentTrunk({token: async () => `token-${++n}`, fetch: async (_, init) => {
    assert.equal(init.headers.authorization, `Bearer token-${n}`); return json({data: []});
  }});
  await client.listWorkspaces(); await client.listScopes('trunk_1'); assert.equal(n, 2);
});
test('discovery contextKey feeds the pinned inspect contract', async () => {
  const client = new AgentTrunk({token, fetch: async url => {
    if (url.pathname === '/v1/contexts') return json({data: [{trunkId: 'trunk_1', contextKey: 'support', revisionId: revision}], nextCursor: null});
    assert.equal(url.pathname, '/v1/trunks/trunk_1/contexts/support');
    assert.equal(url.searchParams.get('ref'), revision);
    return json({context: {key: 'support'}, revision: {id: revision, files: [file]}});
  }});
  const {data} = await client.discover();
  const pinned = await client.inspect(data[0].trunkId, data[0].contextKey, data[0].revisionId);
  assert.equal(pinned.revision.id, revision);
});
test('rejects unsafe origins and resource paths', () => {
  for (const baseUrl of ['http://example.com', 'https://user:pass@example.com', 'https://example.com/v1', 'https://example.com/?token=x']) {
    assert.throws(() => new AgentTrunk({token, baseUrl}));
  }
  for (const path of ['/absolute', '../escape', 'a/../b', 'a//b', 'a\\b', 'a\0b']) assert.throws(() => resourcePath(path));
  assert.equal(resourcePath('prompts/a b.md'), 'prompts/a%20b.md');
});
test('invalid identifiers cannot escape API routes', async () => {
  const client = new AgentTrunk({token, fetch: async () => {throw Error('must not fetch');}});
  for (const id of ['..', '/', '%2e%2e', 'a/b']) assert.throws(() => client.getWorkspace(id), /identifier/);
});
test('API failures are structured, sanitized and never retried', async () => {
  for (const status of [401, 403, 409, 429, 503]) {
    let calls = 0;
    const client = new AgentTrunk({token, fetch: async () => {
      calls++; return new Response('private backend message', {status, headers: {'x-request-id': 'request_123'}});
    }});
    await assert.rejects(client.createWorkspace({name: 'Support'}), error => {
      assert.ok(error instanceof AgentTrunkError); assert.equal(error.status, status);
      assert.equal(error.requestId, 'request_123'); assert.ok(!error.message.includes('private')); return true;
    });
    assert.equal(calls, 1);
  }
});
test('lost mutation response is not retried', async () => {
  let calls = 0;
  const client = new AgentTrunk({token, fetch: async () => { calls++; throw new TypeError('fetch failed'); }});
  await assert.rejects(client.createWorkspace({name: 'Support'})); assert.equal(calls, 1);
});
test('publish uses the complete package and explicit scope', async () => {
  const input = {scopeId: 'scope_1', contextKey: 'support', kind: 'prompt', title: 'Support', files: [{path: 'prompt.md', contentBase64: 'aGk='}]};
  const client = new AgentTrunk({token, fetch: async (url, init) => {
    assert.equal(url.pathname, '/v1/trunks/trunk_1/publications');
    assert.equal(init.method, 'POST'); assert.deepEqual(JSON.parse(init.body), input);
    return json({context: {key: 'support'}, revision: {id: revision}});
  }});
  assert.equal((await client.publish('trunk_1', input)).revision.id, revision);
  assert.throws(() => client.publish('trunk_1', {...input, files: [...input.files, ...input.files]}), /Duplicate/);
});
test('pinned reads verify size and SHA256 before returning bytes', async () => {
  const client = new AgentTrunk({token, fetch: async url => {
    assert.equal(url.searchParams.get('ref'), revision);
    assert.equal(url.pathname, '/v1/trunks/trunk_1/contexts/support/files/prompts/system.md');
    return new Response(bytes);
  }});
  assert.deepEqual(await client.readFile('trunk_1', 'support', revision, file), bytes);
  await assert.rejects(client.readFile('trunk_1', 'support', 'production', file), /immutable/);
  await assert.rejects(client.readFile('trunk_1', 'support', revision, {...file, sha256: 'b'.repeat(64)}), /integrity/);
  await assert.rejects(client.readFile('trunk_1', 'support', revision, {...file, size: 99}), /integrity/);
});
test('oversized streamed files are rejected', async () => {
  const client = new AgentTrunk({token, fetch: async () => new Response(new Uint8Array(1_000_001))});
  await assert.rejects(client.readFile('trunk_1', 'support', revision, file), /size limit/);
});
test('missing credentials fail before network access', async () => {
  const client = new AgentTrunk({token: '', fetch: async () => {throw Error('network reached');}});
  await assert.rejects(client.listWorkspaces(), /token is required/);
});
test('release requests and merges use separate endpoints', async () => {
  const calls = [];
  const client = new AgentTrunk({token, fetch: async (url, init) => {
    calls.push([url.pathname, init.method, init.body]); return json({id: 'promotion_1'});
  }});
  await client.openPromotion('trunk_1', {scopeId: 'scope_1'});
  assert.equal(calls.length, 1);
  await client.mergePromotion('trunk_1', 'promotion_1');
  assert.deepEqual(calls, [
    ['/v1/trunks/trunk_1/promotion-requests', 'POST', '{"scopeId":"scope_1"}'],
    ['/v1/trunks/trunk_1/promotion-requests/promotion_1/merge', 'POST', undefined],
  ]);
});
