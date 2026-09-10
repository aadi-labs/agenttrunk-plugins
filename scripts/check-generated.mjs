import {readFile, readdir} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {execFileSync} from 'node:child_process';
import assert from 'node:assert/strict';

// Compare generated source before/after the real pinned Fern pipeline. Build
// artifacts and Fern's invocation metadata are not reproducible source inputs.
async function snapshot(folder) {
  const hashes = {};
  for (const item of await readdir(folder, {withFileTypes: true})) {
    if (['node_modules', 'dist', 'target', '.build', '.venv', '__pycache__', '.bundle', 'vendor'].includes(item.name)) continue;
    const path = `${folder}/${item.name}`;
    if (path.endsWith('/.fern/metadata.json') || path === 'sdk/rust/Cargo.lock') continue;
    if (item.isDirectory()) Object.assign(hashes, await snapshot(path));
    else hashes[path] = createHash('sha256').update(await readFile(path)).digest('hex');
  }
  return hashes;
}
const before = {...await snapshot('sdk'), ...await snapshot('cli')};
execFileSync('npm', ['run', 'sdk:generate'], {stdio: 'inherit'});
assert.deepEqual({...await snapshot('sdk'), ...await snapshot('cli')}, before,
  'Generated SDK/CLI sources drifted. Review regenerated files and include them with the contract change.');
console.log('All six SDKs and CLI reproduce from the reviewed contract and pinned generators.');
