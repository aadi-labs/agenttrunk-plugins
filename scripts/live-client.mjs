import {AgentTrunkClient,AgentTrunkWorkflows} from '../dist/sdk/index.js';
try {
 const values=['AGENTTRUNK_ACCESS_TOKEN','AGENTTRUNK_WORKSPACE_ID','AGENTTRUNK_CONTEXT_KEY','AGENTTRUNK_REVISION_ID','AGENTTRUNK_RESOURCE_PATH'].map(key=>{if(!process.env[key])throw Error('Missing protected environment configuration');return process.env[key];});
 const [token,workspace,key,revision,path]=values;
 const client=new AgentTrunkClient({accessToken:token,maxRetries:0});
 await new AgentTrunkWorkflows(client).readVerifiedFile(workspace,key,revision,path);
 console.log('Authenticated immutable read and SHA-256 verification passed.');
} catch {console.error('Hosted acceptance failed. Check protected environment configuration, authorization and the selected pin.');process.exitCode=1;}
