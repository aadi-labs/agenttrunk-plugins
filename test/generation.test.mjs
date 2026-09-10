import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import {AgentTrunkClient} from '../dist/sdk/index.js';

test('every normalized SDK operation is exposed by the generated TypeScript client', async () => {
  const spec = JSON.parse(await readFile('fern/openapi/openapi.json','utf8'));
  const client = new AgentTrunkClient({accessToken:'local-test'});
  let count = 0;
  for (const item of Object.values(spec.paths)) {
    for (const method of ['get','post','put','patch','delete']) {
      const operation = item[method]; if (!operation || operation['x-fern-ignore']) continue;
      assert.equal(typeof client[operation['x-fern-sdk-group-name']][operation['x-fern-sdk-method-name']], 'function');
      count++;
    }
  }
  assert.equal(count,38);
  const read = spec.paths['/v1/trunks/{trunkId}/contexts/{contextKey}/files/{resourcePath}'].get;
  assert.equal(read.parameters.find(p=>p.name==='ref').required,true);
  assert.ok(spec.components.schemas.DiscoveryResult.required.includes('contextKey'));
  assert.ok(!spec.components.schemas.DiscoveryResult.required.includes('key'));
  execFileSync(process.execPath,['scripts/sync-openapi.mjs','--check'],{stdio:'pipe'});
});
