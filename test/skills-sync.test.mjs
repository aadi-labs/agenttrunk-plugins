import {test} from 'node:test';
import assert from 'node:assert/strict';
import {mkdtemp,readFile,writeFile,symlink,rm,access} from 'node:fs/promises';
import {join} from 'node:path';
import {tmpdir} from 'node:os';
import {createHash} from 'node:crypto';
import {runSkills} from '../dist/cli/skills.js';

test('skill pull verifies bytes; status is offline; push previews and uses pinned PATCH',async()=>{
 const root=await mkdtemp(join(tmpdir(),'agenttrunk-sync-test-')),directory=join(root,'skill');
 const original=globalThis.fetch;const files=new Map([['SKILL.md',Buffer.from('# Skill')]]);let revision='a'.repeat(64),writes=0;
 const manifest=()=>[...files].map(([path,bytes])=>({path,size:bytes.length,sha256:createHash('sha256').update(bytes).digest('hex')}));
 globalThis.fetch=async(url,init={})=>{
  assert.equal(new Headers(init.headers).get('authorization'),'Bearer test');
  const u=new URL(url);
  if(init.method==='PATCH') {writes++;const body=JSON.parse(init.body);assert.equal(body.expectedRevisionId,revision);for(const change of body.changes)change.operation==='delete'?files.delete(change.path):files.set(change.path,Buffer.from(change.contentBase64,'base64'));revision='b'.repeat(64);}
  if(u.pathname.includes('/files/'))return new Response(files.get(u.pathname.split('/files/')[1]));
  return Response.json({context:{key:'k'},revision:{id:revision,packageDigest:'digest',files:manifest()}});
 };
 const env={AGENTTRUNK_ACCESS_TOKEN:'test',AGENTTRUNK_API_URL:'https://api.example.com'};
 const args=['--workspace','w','--key','k','--directory',directory];let output='';const out=v=>output+=v;
 try{
  await runSkills(['pull',...args,'--ref','staging'],env,out);await assert.rejects(access(directory));assert.equal(writes,0);
  await runSkills(['pull',...args,'--ref','staging','--execute','--yes'],env,out);
  assert.equal(await readFile(join(directory,'SKILL.md'),'utf8'),'# Skill');
  await writeFile(join(directory,'SKILL.md'),'# Changed');
  const fetcher=globalThis.fetch;globalThis.fetch=()=>{throw Error('offline');};output='';await runSkills(['status',...args],env,out);assert.equal(JSON.parse(output).changes[0].operation,'put');globalThis.fetch=fetcher;
  await assert.rejects(runSkills(['pull',...args,'--execute','--yes'],env,out),/Local changes/);
  await runSkills(['push',...args],env,out);assert.equal(writes,0);
  await runSkills(['push',...args,'--execute','--yes'],env,out);assert.equal(writes,1);
  assert.equal(JSON.parse(await readFile(join(directory,'.agenttrunk-sync.json'),'utf8')).revisionId,revision);
  // Remote drift must never turn a local edit into an unconditional overwrite.
  await writeFile(join(directory,'SKILL.md'),'# Local draft');revision='c'.repeat(64);
  await assert.rejects(runSkills(['push',...args,'--execute','--yes'],env,out));assert.equal(writes,1);
  // A clean pull may move forward, preserving the previous directory as backup.
  await writeFile(join(directory,'SKILL.md'),'# Changed');files.set('SKILL.md',Buffer.from('# Remote'));
  output='';await runSkills(['pull',...args,'--ref','staging','--execute','--yes'],env,out);
  assert.equal(await readFile(join(directory,'SKILL.md'),'utf8'),'# Remote');
  assert.equal(JSON.parse(await readFile(join(directory,'.agenttrunk-sync.json'),'utf8')).revisionId,revision);
  await symlink('/etc/passwd',join(directory,'unsafe'));
  await assert.rejects(runSkills(['status',...args],env,out),/symlink/);
 }finally{globalThis.fetch=original;await rm(root,{recursive:true,force:true});}
});

test('corrupt downloads never install a managed directory',async()=>{
 const root=await mkdtemp(join(tmpdir(),'agenttrunk-sync-test-')),directory=join(root,'skill');const original=globalThis.fetch;
 globalThis.fetch=async url=>String(url).includes('/files/')?new Response('bad'):Response.json({revision:{id:'a'.repeat(64),files:[{path:'SKILL.md',size:3,sha256:'0'.repeat(64)}]}});
 try{await assert.rejects(runSkills(['pull','--workspace','w','--key','k','--directory',directory,'--execute','--yes'],{AGENTTRUNK_ACCESS_TOKEN:'test'},()=>{}));await assert.rejects(access(directory));}
 finally{globalThis.fetch=original;await rm(root,{recursive:true,force:true});}
});
