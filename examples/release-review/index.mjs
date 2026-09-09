import { clientFromEnvironment, collectPages, main, required } from '../shared.mjs';

export async function reviewReleases(client, {workspaceId, scopeId, open = false, evidenceReference, maxPages = 10}) {
  if (!workspaceId || !scopeId) throw new Error('Workspace and scope are required');
  if (open && !evidenceReference) throw new Error('Supply staging test evidence before opening review');
  const opened = open ? await client.openPromotion(workspaceId, {scopeId, evidenceReference}) : undefined;
  const page = await collectPages(cursor => client.listPromotions(workspaceId, {scopeId, status: 'open', cursor}), maxPages);
  // Keep the whole scope's reviewed change list; do not reduce it to one package.
  return {opened, ...page, productionChanged: false};
}
main(import.meta.url, () => reviewReleases(clientFromEnvironment(), {
  workspaceId: required(process.env, 'AGENTTRUNK_WORKSPACE_ID'),
  scopeId: required(process.env, 'AGENTTRUNK_SCOPE_ID'),
  open: process.env.AGENTTRUNK_OPEN_RELEASE === '1',
  evidenceReference: process.env.AGENTTRUNK_EVIDENCE_REFERENCE,
}));
