import {test} from 'node:test';
import assert from 'node:assert/strict';
import {mkdtemp, readFile, writeFile, rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {execFileSync} from 'node:child_process';
import {parse} from 'yaml';

test('source check catches upstream drift even when normalization overwrites that schema', async () => {
  const source = parse(await readFile('fern/openapi/upstream.yaml', 'utf8'));
  const folder = await mkdtemp(join(tmpdir(), 'agenttrunk-contract-'));
  const path = join(folder, 'openapi.json');
  try {
    await writeFile(path, JSON.stringify(source));
    execFileSync(process.execPath, ['scripts/sync-openapi.mjs', '--source', path, '--check']);
    source.components.schemas.DiscoveryResult.description = 'Unreviewed upstream change';
    await writeFile(path, JSON.stringify(source));
    assert.throws(() => execFileSync(process.execPath, ['scripts/sync-openapi.mjs', '--source', path, '--check'], {stdio: 'pipe'}),
      error => error.stderr.toString().includes('Reviewed upstream snapshot differs'));
  } finally { await rm(folder, {recursive: true, force: true}); }
});
