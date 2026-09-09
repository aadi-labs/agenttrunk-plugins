import { clientFromEnvironment, collectPages, main } from '../shared.mjs';

export async function quickstart(client, workspaceId) {
  if (!workspaceId) {
    const page = await collectPages(cursor => client.listWorkspaces({cursor}));
    return {...page, nextStep: 'Choose the intended workspace ID and rerun with AGENTTRUNK_WORKSPACE_ID.'};
  }
  const workspace = await client.getWorkspace(workspaceId);
  const scopes = await client.listScopes(workspaceId);
  const page = await client.discover({trunkId: workspaceId, channel: 'production', limit: 10});
  return {workspace, scopes: scopes.data, productionMatchesOnFirstPage: page.data.length, nextCursor: page.nextCursor ?? null};
}
main(import.meta.url, () => quickstart(clientFromEnvironment(), process.env.AGENTTRUNK_WORKSPACE_ID));
