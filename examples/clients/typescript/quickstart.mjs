import {AgentTrunkClient} from '@agenttrunk/sdk';
import {main, required, collectPages} from '../../shared.mjs';
main(import.meta.url, async () => {
  required(process.env, 'AGENTTRUNK_ACCESS_TOKEN');
  const client = new AgentTrunkClient({accessToken: () => required(process.env, 'AGENTTRUNK_ACCESS_TOKEN')});
  const workspace = process.env.AGENTTRUNK_WORKSPACE_ID;
  if (!workspace) return collectPages(cursor => client.workspaces.list({cursor}));
  return collectPages(cursor => client.contexts.discover({trunkId: workspace, channel:'production', cursor}));
});
