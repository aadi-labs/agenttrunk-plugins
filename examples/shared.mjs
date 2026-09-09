import { AgentTrunk, AgentTrunkError } from '@agenttrunk/sdk';
import { pathToFileURL } from 'node:url';
import { existsSync, realpathSync } from 'node:fs';

export function required(env, name) {
  const value = env[name];
  if (!value) throw new Error(`Missing configuration: ${name}`);
  return value;
}
export function clientFromEnvironment(env = process.env) {
  required(env, 'AGENTTRUNK_ACCESS_TOKEN');
  return new AgentTrunk({
    token: () => required(env, 'AGENTTRUNK_ACCESS_TOKEN'),
    baseUrl: env.AGENTTRUNK_API_URL,
  });
}

// A task budget prevents accidental unbounded discovery. Empty pages still continue.
export async function collectPages(getPage, maxPages = 10) {
  if (!Number.isInteger(maxPages) || maxPages < 1 || maxPages > 100) throw new Error('Invalid page budget');
  const data = [];
  const seen = new Set();
  let cursor;
  for (let pageIndex = 0; pageIndex < maxPages; pageIndex++) {
    const page = await getPage(cursor);
    data.push(...page.data);
    if (!page.nextCursor) return { data, nextCursor: null, truncated: false };
    if (seen.has(page.nextCursor)) throw new Error('Pagination cursor repeated');
    seen.add(page.nextCursor);
    cursor = page.nextCursor;
  }
  return { data, nextCursor: cursor, truncated: true };
}

// No raw transport/provider errors: their messages can contain request details.
export function main(metaUrl, action) {
  if (!process.argv[1] || !existsSync(process.argv[1]) || metaUrl !== pathToFileURL(realpathSync(process.argv[1])).href) return;
  Promise.resolve().then(action).then(result => {
    process.stdout.write(JSON.stringify(result, null, 2) + '\n');
  }).catch(error => {
    const diagnostic = error instanceof AgentTrunkError
      ? { error: 'AgentTrunk HTTP failure', status: error.status, requestId: error.requestId }
      : { error: 'Example failed. Check required configuration, permissions and network. Reconcile any attempted write before retrying.' };
    process.stderr.write(JSON.stringify(diagnostic) + '\n');
    process.exitCode = 1;
  });
}
