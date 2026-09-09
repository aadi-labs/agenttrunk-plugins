import {test} from 'node:test';
import assert from 'node:assert/strict';
import {spawnSync} from 'node:child_process';
import {createServer} from 'node:http';
import {once} from 'node:events';
import {mkdtemp, writeFile, symlink, rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {run} from '../dist/cli/index.js';

test('help works without credentials and unknown commands fail', async () => {
  let output = ''; await run(['--help'], {}, v => output += v);
  assert.match(output, /workspace-create/);
  await assert.rejects(run(['login'], {}), /Unknown command/);
});
test('rejects production merge without explicit acknowledgement', async () => {
  await assert.rejects(run(['release-merge', '--workspace', 'trunk_1', '--promotion', 'pr_1'], {}), /--yes/);
});
test('unknown options, invalid channel and moving file refs fail', async () => {
  await assert.rejects(run(['discover', '--channel', 'prod'], {}), /channel/);
  await assert.rejects(run(['discover', '--token', 'secret'], {}));
  await assert.rejects(run(['read', '--workspace', 'trunk_1', '--key', 'x', '--ref', 'latest', '--path', 'x'], {}), /immutable/);
});
test('CLI does not echo secrets from invalid arguments', () => {
  const result = spawnSync(process.execPath, ['dist/cli/index.js', 'discover', '--token', 'NEVER_PRINT_THIS'], {encoding: 'utf8'});
  assert.equal(result.status, 1);
  assert.ok(!`${result.stdout}${result.stderr}`.includes('NEVER_PRINT_THIS'));
});
test('explicit file upload reaches HTTP API; symlink and large files never upload', async () => {
  const folder = await mkdtemp(join(tmpdir(), 'agenttrunk-client-test-'));
  let requests = 0;
  const server = createServer(async (req, res) => {
    requests++;
    let body = ''; for await (const chunk of req) body += chunk;
    const input = JSON.parse(body);
    assert.equal(req.url, '/v1/trunks/trunk_1/publications');
    assert.equal(input.scopeId, 'scope_1');
    assert.equal(Buffer.from(input.files[0].contentBase64, 'base64').toString(), 'hello');
    res.setHeader('content-type', 'application/json'); res.end('{"revision":{"id":"pinned"}}');
  });
  server.listen(0, '127.0.0.1'); await once(server, 'listening');
  const env = {AGENTTRUNK_ACCESS_TOKEN: 'test-only', AGENTTRUNK_API_URL: `http://127.0.0.1:${server.address().port}`};
  const args = file => ['upload', '--workspace', 'trunk_1', '--scope', 'scope_1', '--key', 'support', '--kind', 'prompt', '--title', 'Support', '--file', file, '--path', 'prompt.md'];
  try {
    const file = join(folder, 'prompt.md'); await writeFile(file, 'hello');
    let output = ''; await run(args(file), env, v => output += v);
    assert.equal(JSON.parse(output).revision.id, 'pinned');
    const link = join(folder, 'link.md'); await symlink(file, link);
    await assert.rejects(run(args(link), env));
    const large = join(folder, 'large.md'); await writeFile(large, Buffer.alloc(1_000_001));
    await assert.rejects(run(args(large), env), /1 MB/);
    assert.equal(requests, 1);
  } finally {
    await new Promise(resolve => server.close(resolve));
    await rm(folder, {recursive: true, force: true}); // Only the test-created temporary directory.
  }
});

test('scope setup and release review CLI reach the scoped API without merging', async () => {
  const requests = [];
  const server = createServer(async (req, res) => {
    let body = ''; for await (const chunk of req) body += chunk;
    requests.push({method: req.method, url: req.url, body});
    res.setHeader('content-type', 'application/json');
    res.end(JSON.stringify(req.method === 'POST' ? {id: 'scope_2'} : {data: [], nextCursor: 'next'}));
  });
  server.listen(0, '127.0.0.1'); await once(server, 'listening');
  const env = {AGENTTRUNK_ACCESS_TOKEN: 'test-only', AGENTTRUNK_API_URL: `http://127.0.0.1:${server.address().port}`};
  try {
    await run(['scope-create', '--workspace', 'trunk_1', '--name', 'Support', '--slug', 'support'], env, () => {});
    let output = '';
    await run(['releases', '--workspace', 'trunk_1', '--scope', 'scope_2', '--status', 'open', '--cursor', 'current'], env, value => output += value);
    assert.equal(JSON.parse(output).nextCursor, 'next');
    assert.deepEqual(requests, [
      {method: 'POST', url: '/v1/trunks/trunk_1/scopes', body: '{"name":"Support","slug":"support"}'},
      {method: 'GET', url: '/v1/trunks/trunk_1/promotion-requests?scopeId=scope_2&status=open&cursor=current', body: ''},
    ]);
    await assert.rejects(run(['releases', '--workspace', 'trunk_1', '--status', 'pending'], env), /status/);
    assert.equal(requests.length, 2);
  } finally { await new Promise(resolve => server.close(resolve)); }
});

test('CLI executes through the symlink used by npm bin installations', async () => {
  const folder = await mkdtemp(join(tmpdir(), 'agenttrunk-bin-test-'));
  try {
    const executable = join(folder, 'agenttrunk');
    await symlink(join(process.cwd(), 'dist/cli/index.js'), executable);
    const result = spawnSync(process.execPath, [executable, '--help'], {encoding: 'utf8'});
    assert.equal(result.status, 0);
    assert.match(result.stdout, /scope-create/);
    assert.match(result.stdout, /releases/);
  } finally { await rm(folder, {recursive: true, force: true}); }
});

test('importing CLI and example modules from stdin does not invoke their entrypoints', () => {
  const result = spawnSync(process.execPath, ['--input-type=module', '-'], {
    encoding: 'utf8', input: "await import('./dist/cli/index.js'); await import('./examples/quickstart/index.mjs'); console.log('imported');",
  });
  assert.equal(result.status, 0, result.stderr);
  assert.equal(result.stdout.trim(), 'imported');
});
