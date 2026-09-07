import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile, access} from 'node:fs/promises';
test('both plugins use the same existing skill and version', async () => {
  const root = new URL('../plugins/agenttrunk/', import.meta.url);
  const codex = JSON.parse(await readFile(new URL('.codex-plugin/plugin.json', root)));
  const claude = JSON.parse(await readFile(new URL('.claude-plugin/plugin.json', root)));
  const pkg = JSON.parse(await readFile(new URL('../package.json', import.meta.url)));
  assert.equal(codex.name, 'agenttrunk'); assert.equal(claude.name, codex.name);
  assert.equal(codex.version, pkg.version); assert.equal(claude.version, pkg.version);
  assert.equal(codex.skills, claude.skills);
  await access(new URL(`${codex.skills}agenttrunk/SKILL.md`, root));
  assert.equal(codex.mcpServers, undefined); assert.equal(claude.mcpServers, undefined);
  const marketplace = JSON.parse(await readFile(new URL('../.claude-plugin/marketplace.json', import.meta.url)));
  for (const plugin of marketplace.plugins) await access(new URL(`../${plugin.source}/.claude-plugin/plugin.json`, import.meta.url));
});
