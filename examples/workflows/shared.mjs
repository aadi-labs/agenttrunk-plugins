import {readFile} from 'node:fs/promises';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {AgentTrunkClient} from '@agenttrunk/sdk';
export function substitute(value,env=process.env){
 if(typeof value==='string')return value.replace(/\$\{(AGENTTRUNK_[A-Z_]+)\}/g,(_,key)=>{if(!env[key])throw Error(`Missing ${key}`);return env[key];});
 if(Array.isArray(value))return value.map(v=>substitute(v,env));
 if(value&&typeof value==='object')return Object.fromEntries(Object.entries(value).map(([k,v])=>[k,substitute(v,env)]));return value;
}
export async function run(url,operation,execute){
 if(process.argv[1]!==fileURLToPath(url))return;
 try{
  const flags=process.argv.slice(2);if(flags.some(f=>!['--execute','--yes'].includes(f)))throw Error('Invalid flags');
  const raw=await readFile(new URL('./request.json',url),'utf8');
  const mutation=['contexts.publish','releases.open'].includes(operation);
  if(!flags.includes('--execute')){console.log(JSON.stringify({operation,effect:mutation?'write':'read',inputSha256:createHash('sha256').update(raw).digest('hex'),requiredEnvironment:[...new Set(raw.match(/AGENTTRUNK_[A-Z_]+/g)??[])],preview:true}));return;}
  if(mutation&&!flags.includes('--yes'))throw Error('Write approval required');
  if(!process.env.AGENTTRUNK_ACCESS_TOKEN)throw Error('Missing runtime token');
  const client=new AgentTrunkClient({accessToken:()=>process.env.AGENTTRUNK_ACCESS_TOKEN,baseUrl:process.env.AGENTTRUNK_API_URL,maxRetries:0});
  console.log(JSON.stringify(await execute(client,substitute(JSON.parse(raw))),null,2));
 }catch{console.error('Workflow failed. Check configuration and permissions; reconcile an uncertain write before retrying.');process.exitCode=1;}
}
