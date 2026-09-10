import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import {run} from '../dist/cli/index.js';
import {AgentTrunkClient,AgentTrunkWorkflows} from '../dist/sdk/index.js';
import {createHash} from 'node:crypto';

test('API catalog covers all operations and doctor never exposes tokens',async()=>{
 let out='';await run(['api','list'],{},v=>out+=v);assert.equal(JSON.parse(out).length,38);
 out='';await run(['doctor'],{AGENTTRUNK_ACCESS_TOKEN:'SECRET'},v=>out+=v);assert.equal(JSON.parse(out).tokenConfigured,true);assert.ok(!out.includes('SECRET'));
 out='';await run(['api','workspaces.create','--help'],{},v=>out+=v);assert.equal(JSON.parse(out).verb,'POST');
});
test('API previews and write gates make no network request',async()=>{
 let calls=0;const original=globalThis.fetch;globalThis.fetch=async()=>{calls++;throw Error('network forbidden');};
 try{
  let out='';await run(['api','billing.createPortal'],{},v=>out+=v);assert.equal(JSON.parse(out).effect,'write');
  await assert.rejects(run(['api','billing.createPortal','--execute'],{AGENTTRUNK_ACCESS_TOKEN:'test'},()=>{}));assert.equal(calls,0);
 }finally{globalThis.fetch=original;}
});
test('incremental edits send PATCH with an expected revision and never retry conflicts',async()=>{
 for (const status of [200,409,503]) {
  let calls=0;
  const request={expectedRevisionId:'a'.repeat(64),changes:[{operation:'put',path:'a.md',contentBase64:'QQ=='},{operation:'delete',path:'old.md'}]};
  const client=new AgentTrunkClient({accessToken:'test',fetch:async(url,init)=>{
   calls++;assert.equal(new URL(url).pathname,'/v1/trunks/w/contexts/k');assert.equal(init.method,'PATCH');assert.deepEqual(JSON.parse(init.body),request);
   return Response.json(status===200?JSON.parse(await readFile('test/ruby/manifest.json','utf8')):{error:{code:'conflict'}},{status});
  }});
  if(status===200) await client.contexts.edit('w','k',request);
  else await assert.rejects(client.contexts.edit('w','k',request));
  assert.equal(calls,1);
 }
});
test('generated workflow helper rejects tampering and moving refs',async()=>{
 const revision='a'.repeat(64),data=Buffer.from('verified'),sha256=createHash('sha256').update(data).digest('hex');
 for(const corrupt of [false,true]){
  let calls=0;const c=new AgentTrunkClient({accessToken:'test',fetch:async url=>{calls++;return String(url).includes('/files/')?new Response(corrupt?'tampered':data):Response.json({revision:{id:revision,packageDigest:'b'.repeat(64),files:[{path:'SKILL.md',size:data.length,sha256}]}});}});
  const w=new AgentTrunkWorkflows(c);await assert.rejects(w.readVerifiedFile('w','k','production','SKILL.md'));assert.equal(calls,0);
  if(corrupt)await assert.rejects(w.readVerifiedFile('w','k',revision,'SKILL.md'));else assert.deepEqual(Buffer.from(await w.readVerifiedFile('w','k',revision,'SKILL.md')),data);
 }
});
test('all cookbook examples preview without credentials and dispatch to their generated method',async()=>{
 const recipes=JSON.parse(await readFile('examples/workflows/recipes.json','utf8'));
 for(const recipe of recipes){
  const path=`examples/workflows/${recipe.name}/index.mjs`;
  const env={...process.env};delete env.AGENTTRUNK_ACCESS_TOKEN;
  const preview=JSON.parse(execFileSync(process.execPath,[path],{env,encoding:'utf8'}));assert.equal(preview.preview,true);
  const input=JSON.parse(await readFile(`examples/workflows/${recipe.name}/request.json`,'utf8'));
  const {execute}=await import('../'+path);const [group,method]=recipe.operation.split('.');let received;
  const fake={[group]:{[method]:(...args)=>{received=args;return {};}}};await execute(fake,input);assert.ok(received);
 }
});
test('portable export and native adapters resolve the canonical skill',async()=>{
 execFileSync(process.execPath,['scripts/skills.mjs','--check']);
 const pkg=JSON.parse(await readFile('package.json','utf8'));assert.deepEqual(pkg.pi.skills,['./skills']);
 const cursor=JSON.parse(await readFile('.cursor-plugin/plugin.json','utf8'));assert.equal(cursor.skills,'./skills/');
 const openclaw=JSON.parse(await readFile('openclaw.plugin.json','utf8'));assert.deepEqual(openclaw.skills,['./skills']);
 execFileSync('python3',['-c',`import importlib.util; from pathlib import Path
s=importlib.util.spec_from_file_location('plugin','__init__.py'); m=importlib.util.module_from_spec(s); s.loader.exec_module(m)
class Context:
 def register_skill(self,name,path):
  assert name == 'agenttrunk' and path.is_file()
m.register(Context())`]);
});

test('publication cookbook preserves complete files and explicit scope on the wire',async()=>{
 const {execute}=await import('../examples/workflows/publish-package/index.mjs');
 const input=JSON.parse(await readFile('examples/workflows/publish-package/request.json','utf8'));
 input.trunkId='w';input.request.scopeId='s';input.request.contextKey='k';let calls=0;
 const client=new AgentTrunkClient({accessToken:'test',fetch:async(url,init)=>{
  calls++;assert.equal(new URL(url).pathname,'/v1/trunks/w/publications');const body=JSON.parse(init.body);assert.equal(body.scopeId,'s');assert.deepEqual(body.files.map(f=>f.path),['SKILL.md','references/escalation.md']);return Response.json(JSON.parse(await readFile('test/ruby/manifest.json','utf8')));
 }});
 assert.equal((await execute(client,input)).revision.id,'a'.repeat(64));assert.equal(calls,1);
});
