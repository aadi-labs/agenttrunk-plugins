import assert from 'node:assert/strict';
import { readFile, readdir, access } from 'node:fs/promises';
import { resolve, dirname, relative } from 'node:path';
import { fileURLToPath } from 'node:url';
import { execFileSync } from 'node:child_process';

const root = fileURLToPath(new URL('../', import.meta.url));
const json = async path => JSON.parse(await readFile(resolve(root, path), 'utf8'));
const pkg = await json('package.json');
const catalog = await json('catalog.json');
const targets = [
  ...catalog.documentation,
  ...Object.values(catalog.integrations??{}),
  ...(catalog.sdks ?? []).flatMap(sdk => [sdk.readme, sdk.reference]),
  ...catalog.skills.map(skill => skill.path),
  ...Object.values(catalog.plugins),
  ...catalog.examples.flatMap(example => [example.readme, ...(example.entrypoint ? [example.entrypoint] : [])]),
];
for (const path of targets) {
  assert.ok(!relative(root, resolve(root, path)).startsWith('..'), `Catalog escapes package: ${path}`);
  await access(resolve(root, path));
}
for (const path of Object.values(catalog.plugins)) {
  const plugin = await json(path);
  assert.equal(plugin.version, pkg.version);
  const skillRoot = resolve(root, dirname(path), '..', plugin.skills);
  for (const skill of catalog.skills) {
    assert.equal(resolve(skillRoot, skill.name, 'SKILL.md'), resolve(root, skill.path));
  }
  assert.equal(plugin.mcpServers, undefined);
}

async function walk(path) {
  const found = [];
  for (const entry of await readdir(path, {withFileTypes: true})) {
    if (['node_modules', '.git', 'dist', '.venv', 'target', '.build', '.bundle', 'vendor', '__pycache__'].includes(entry.name)) continue;
    const full = resolve(path, entry.name);
    if (entry.isDirectory()) found.push(...await walk(full));
    else found.push(full);
  }
  return found;
}
const files = await walk(root);
let linkCount = 0;
for (const path of files.filter(path => path.endsWith('.md') || path.endsWith('llms.txt'))) {
  const content = await readFile(path, 'utf8');
  // Authored README templates resolve their links at the generated destination.
  const template = relative(root, path).match(/^client-extensions\/(typescript|python|go|rust|ruby|swift)\/README\.md$/);
  const linkSource = template ? resolve(root, 'sdk', template[1], 'README.md') : path;
  for (const match of content.matchAll(/\[[^\]]*\]\(([^)]+)\)/g)) {
    const target = match[1];
    if (/^(https?:|mailto:|#)/.test(target)) continue;
    const destination = decodeURIComponent(target.split('#')[0]);
    if (!destination) continue;
    await access(resolve(dirname(linkSource), destination)).catch(() => {throw new Error(`Broken link in ${relative(root, path)}: ${target}`);});
    linkCount++;
  }
}
for (const example of catalog.examples) {
  if (example.entrypoint) execFileSync(process.execPath, ['--check', resolve(root, example.entrypoint)], {stdio: 'pipe'});
}
// prepack builds first. This only lists the archive; no publish or live requests.
const packed = JSON.parse(execFileSync('npm', ['pack', '--dry-run', '--json'], {cwd: root, encoding: 'utf8', stdio: ['ignore', 'pipe', 'pipe']}))[0];
const included = new Set(packed.files.map(file => file.path));
for (const path of [...targets, 'dist/sdk/index.js', 'dist/sdk/index.d.ts', 'dist/cli/index.js', 'examples/shared.mjs', ...files.filter(path => path.includes('/skills/')).map(path => relative(root, path))]) {
  assert.ok(included.has(path), `Missing from npm package: ${path}`);
}
console.log(`Validated ${targets.length} catalog targets, ${linkCount} local links, examples, shared skill manifests and ${included.size} packaged files.`);
