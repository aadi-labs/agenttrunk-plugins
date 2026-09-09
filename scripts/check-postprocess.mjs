import {readFile, readdir} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {execFileSync} from 'node:child_process';
import assert from 'node:assert/strict';
async function snapshot(folder) {
  const hashes = {};
  for (const item of await readdir(folder, {withFileTypes:true})) {
    if (['dist','node_modules','__pycache__','.venv', 'target', '.build', '.bundle', 'vendor'].includes(item.name)) continue;
    const path = `${folder}/${item.name}`;
    if (item.isDirectory()) Object.assign(hashes, await snapshot(path));
    else hashes[path] = createHash('sha256').update(await readFile(path)).digest('hex');
  }
  return hashes;
}
const before = await snapshot('sdk');
execFileSync(process.execPath,['scripts/postprocess-sdks.mjs'],{stdio:'pipe'});
assert.deepEqual(await snapshot('sdk'), before, 'Postprocessing changed already-processed outputs');
console.log('Postprocessing is idempotent across all SDK outputs.');
