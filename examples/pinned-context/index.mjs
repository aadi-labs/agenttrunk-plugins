import { clientFromEnvironment, collectPages, main, required } from '../shared.mjs';

export async function loadContext(client, {workspaceId, query = 'support', resourcePath = 'SKILL.md', maxPages = 10}) {
  if (!workspaceId) throw new Error('Workspace ID is required');
  const page = await collectPages(cursor => client.discover({trunkId: workspaceId, query, channel: 'production', limit: 20, cursor}), maxPages);
  const selected = page.data.find(item => item.trunkId === workspaceId);
  if (!selected) return {found: false, truncated: page.truncated, nextCursor: page.nextCursor};
  // This example chooses the first match in an explicitly selected workspace.
  // A real runtime can rank metadata or ask its user before selecting a package.
  const inspected = await client.inspect(workspaceId, selected.contextKey, selected.revisionId);
  if (inspected.revision.id !== selected.revisionId) throw new Error('Revision mismatch');
  const file = inspected.revision.files.find(item => item.path === resourcePath);
  if (!file) throw new Error('Requested file is not in the pinned manifest');
  const bytes = await client.readFile(workspaceId, selected.contextKey, selected.revisionId, file);
  return {
    found: true,
    pin: {workspaceId, contextKey: selected.contextKey, revisionId: selected.revisionId, packageDigest: inspected.revision.packageDigest},
    resourcePath, bytes, truncated: page.truncated, nextCursor: page.nextCursor,
  };
}
main(import.meta.url, async () => {
  const result = await loadContext(clientFromEnvironment(), {
    workspaceId: required(process.env, 'AGENTTRUNK_WORKSPACE_ID'),
    query: process.env.AGENTTRUNK_QUERY ?? 'support',
    resourcePath: process.env.AGENTTRUNK_RESOURCE_PATH ?? 'SKILL.md',
  });
  // Return a receipt, not the context body. The calling runtime may consume result.bytes.
  const {bytes, ...receipt} = result;
  return {...receipt, ...(bytes ? {verifiedBytes: bytes.length} : {})};
});
