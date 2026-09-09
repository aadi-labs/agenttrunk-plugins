import {parseArgs} from 'node:util';
import {open, constants} from 'node:fs/promises';
import {AgentTrunk, AgentTrunkClient} from '../sdk/index.js';
import {operations} from './operations.js';

export async function runApi(args:string[],env:NodeJS.ProcessEnv,write:(value:string|Uint8Array)=>void) {
 const [name,...rest]=args;
 if(!name || name==='--help' || name==='list') {write(JSON.stringify(operations.map(({name,verb,summary})=>({name,verb,summary})),null,2)+'\n');return;}
 const op=operations.find(op=>op.name===name);
 if(!op) throw new Error('Unknown API operation');
 const {values}=parseArgs({args:rest,options:{input:{type:'string'},execute:{type:'boolean'},yes:{type:'boolean'},help:{type:'boolean'}},strict:true,allowPositionals:false});
 if(values.help){write(JSON.stringify(op,null,2)+'\n');return;}
 let input:Record<string,unknown>={};
 if(values.input){
  const f=await open(values.input,constants.O_RDONLY|constants.O_NOFOLLOW|constants.O_NONBLOCK);
  try{const stat=await f.stat();if(!stat.isFile()||stat.size>24_000_000)throw new Error('Invalid JSON input file');
   const b=Buffer.alloc(24_000_001);let n=0;while(n<b.length){const r=await f.read(b,n,b.length-n,null);if(!r.bytesRead)break;n+=r.bytesRead;}if(n>24_000_000)throw new Error('Input too large');
   input=JSON.parse(b.subarray(0,n).toString('utf8'));
  }finally{await f.close();}
 }
 if(!input||Array.isArray(input)||typeof input!=='object')throw new Error('Input must be an object');
 const keys=op.parameters.map(p=>p.name as string);
 for(const key of Object.keys(input))if(!keys.includes(key))throw new Error('Unknown input parameter');
 for(const p of op.parameters){if(p.required&&input[p.name]===undefined)throw new Error(`Missing ${p.name}`);if(p.name!=='request'&&input[p.name]!==undefined&&(typeof input[p.name]!=='string'||!input[p.name]))throw new Error('Invalid path parameter');}
 if(input.request!==undefined&&(!input.request||typeof input.request!=='object'||Array.isArray(input.request)))throw new Error('request must be an object');
 if(['contexts.publish','releases.open'].includes(op.name)){const scope=(input.request as {scopeId?:unknown}|undefined)?.scopeId;if(typeof scope!=='string'||!scope)throw new Error('Explicit scopeId required for publication and release requests');}
 if(!values.execute){write(JSON.stringify({operation:op.name,method:op.verb,path:op.path,parameters:Object.keys(input),effect:op.verb==='GET'?'read':'write',ready:true,note:'Add --execute to send. Input content and credentials omitted.'})+'\n');return;}
 if(op.verb!=='GET'&&!values.yes)throw new Error('Writes require --yes after reviewing the input');
 if(!env.AGENTTRUNK_ACCESS_TOKEN&&op.group!=='health')throw new Error('Missing runtime token');
 // Binary reads always pass through manifest integrity verification.
 if(op.name==='contexts.readFile'){
  const request=input.request as {ref?:string};const ref=request?.ref;if(!ref||!/^([a-f0-9]{64})$/.test(ref))throw new Error('Immutable ref required');
  const c=new AgentTrunk({token:env.AGENTTRUNK_ACCESS_TOKEN??'',baseUrl:env.AGENTTRUNK_API_URL});
  const workspace=input.trunkId as string,key=input.contextKey as string,path=input.resourcePath as string;
  const inspected=await c.inspect(workspace,key,ref);if(inspected.revision.id!==ref)throw new Error('Revision mismatch');
  const file=inspected.revision.files.find(f=>f.path===path);if(!file)throw new Error('File not in manifest');
  write(await c.readFile(workspace,key,ref,file));return;
 }
 const client=new AgentTrunkClient({accessToken:()=>env.AGENTTRUNK_ACCESS_TOKEN??'',baseUrl:env.AGENTTRUNK_API_URL,maxRetries:0});
 const group=(client as unknown as Record<string,Record<string,(...args:unknown[])=>Promise<unknown>>>)[op.group]!;
 const result=await group[op.method]!.apply(group,op.parameters.map(p=>input[p.name]));
 write(JSON.stringify(result,null,2)+'\n');
}
