import {test} from 'node:test';
import assert from 'node:assert/strict';
import {AgentTrunkClient} from '../dist/sdk/index.js';
import {createServer} from 'node:http';
import {once} from 'node:events';
const token = 'test-only';
const revision = 'a'.repeat(64);

test('Fern TypeScript exposes scoped discovery with contextKey and token callback per request', async () => {
  let calls = 0;
  const client = new AgentTrunkClient({accessToken: () => `token-${++calls}`, fetch: async (url, init) => {
    const request = new URL(url);
    assert.equal(request.searchParams.get('trunkId'), 'trunk_1');
    assert.equal(init.redirect, 'error');
    assert.equal(new Headers(init.headers).get('authorization'), `Bearer token-${calls}`);
    return Response.json({data: [{trunkId: 'trunk_1', contextKey: 'support', revisionId: revision}], nextCursor: 'continue'});
  }});
  const page = await client.contexts.discover({trunkId: 'trunk_1', channel: 'production'});
  assert.equal(page.data[0].contextKey, 'support'); assert.equal(page.nextCursor, 'continue');
  await client.contexts.discover({trunkId: 'trunk_1'}); assert.equal(calls, 2);
});

test('Fern TypeScript mutations never retry, even when read retries are configured; errors omit bodies', async () => {
  for (const status of [401,403,409,429,503]) {
    let calls = 0;
    const client = new AgentTrunkClient({accessToken: token, maxRetries: 3, fetch: async () => {
      calls++; return new Response('SENSITIVE_RESPONSE', {status, headers: {'x-request-id': 'request_123'}});
    }});
    await assert.rejects(client.workspaces.create({name: 'Support'}), error => {
      assert.equal(error.statusCode, status); assert.ok(!String(error).includes('SENSITIVE')); return true;
    });
    assert.equal(calls, 1);
  }
});

test('Fern TypeScript rejects unpinned reads and bounds streamed bytes', async () => {
  let calls = 0;
  const client = new AgentTrunkClient({accessToken: token, fetch: async () => {calls++; return new Response(new Uint8Array(1_000_001));}});
  await assert.rejects(client.contexts.readFile('trunk_1', 'support', 'SKILL.md', {ref: 'production'}));
  assert.equal(calls, 0);
  await assert.rejects(async () => {
    const response = await client.contexts.readFile('trunk_1', 'support', 'SKILL.md', {ref: revision});
    return response.arrayBuffer();
  });
});

test('Fern TypeScript rejects actual HTTP redirects without forwarding credentials', async () => {
  let requests = 0;
  const server = createServer((req, res) => {requests++; res.writeHead(302, {location:'/target'});res.end();});
  server.listen(0,'127.0.0.1'); await once(server,'listening');
  try {
    const client = new AgentTrunkClient({accessToken: token, baseUrl:`http://127.0.0.1:${server.address().port}`});
    await assert.rejects(client.workspaces.list()); assert.equal(requests,1);
  } finally {await new Promise(resolve => server.close(resolve));}
});
