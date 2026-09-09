import {readFile, readdir, mkdir, writeFile, rm} from 'node:fs/promises';
import {resolve, relative} from 'node:path';
import assert from 'node:assert/strict';
const source = resolve('plugins/agenttrunk/skills');
const target = resolve('skills');
async function files(root, prefix = '') {
  let result = [];
  for (const entry of await readdir(resolve(root, prefix), {withFileTypes:true})) {
    assert.ok(!entry.isSymbolicLink(), 'Skill exports must not contain symlinks');
    const path = [prefix, entry.name].filter(Boolean).join('/');
    if (entry.isDirectory()) result.push(...await files(root, path)); else result.push(path);
  }
  return result.sort();
}
const paths = await files(source);
if (process.argv.includes('--check')) {
  assert.deepEqual(await files(target), paths, 'Run npm run skills:build');
  for (const path of paths) assert.deepEqual(await readFile(resolve(source,path)), await readFile(resolve(target,path)), `Stale skill: ${path}`);
} else {
  // Only replace this deterministic export, never the authored skill or user installations.
  await rm(target, {recursive:true, force:true});
  for (const path of paths) { const dest=resolve(target,path); await mkdir(resolve(dest,'..'),{recursive:true}); await writeFile(dest,await readFile(resolve(source,path))); }
}
console.error('Shared skill export is current.');
