import {AgentTrunkClient} from './Client.js';
import {createHash} from 'node:crypto';
export class AgentTrunkWorkflows {
 constructor(readonly client:AgentTrunkClient) {}
 async readVerifiedFile(workspace:string,key:string,revision:string,path:string):Promise<Uint8Array> {
  if(!workspace||!key||!/^([a-f0-9]{64})$/.test(revision)||!path||Buffer.byteLength(path)>512||/[\\\x00-\x1f\x7f]/.test(path)||path.split('/').some(p=>!p||p==='.'||p==='..'))throw Error('Invalid immutable read');
  const pin=await this.client.contexts.inspect(workspace,key,{ref:revision});
  if(pin.revision.id!==revision)throw Error('Revision mismatch');
  const file=pin.revision.files.find(f=>f.path===path);
  if(!file||file.size<0||file.size>1_000_000||!Number.isInteger(file.size)||!/^[a-f0-9]{64}$/.test(file.sha256))throw Error('Invalid file manifest');
  const response=await this.client.contexts.readFile(workspace,key,path,{ref:revision});
  const data=new Uint8Array(await response.arrayBuffer());
  if(data.byteLength!==file.size||createHash('sha256').update(data).digest('hex')!==file.sha256)throw Error('Integrity check failed');
  return data;
 }
 async pin(workspace:string,key:string,ref='production') {
  if(!workspace||!key)throw Error('Workspace and context key required');
  const inspected=await this.client.contexts.inspect(workspace,key,{ref});
  if(!/^[a-f0-9]{64}$/.test(inspected.revision.id))throw Error('Invalid revision');
  return {workspaceId:workspace,contextKey:key,revisionId:inspected.revision.id,packageDigest:inspected.revision.packageDigest,files:inspected.revision.files};
 }
}
