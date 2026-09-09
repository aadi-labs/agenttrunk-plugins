import {test} from 'node:test';
import assert from 'node:assert/strict';
import {mkdtemp,stat,readFile,writeFile,chmod,symlink,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {withState} from '../dist/cli/auth.js';

test('credential persistence is owner-only, atomic, resumable and excludes concurrent auth',async()=>{
  const dir=await mkdtemp(join(tmpdir(),'agenttrunk-auth-test-'));
  try {
    await withState(async(state,save)=>{
      assert.equal(state,undefined);
      await save({resource:'https://api.example.com',identity:{assertion:'TEST_ASSERTION'}});
      await assert.rejects(withState(async()=>{},dir),/Another authentication/);
    },dir);
    assert.equal((await stat(join(dir,'credentials.json'))).mode & 0o777,0o600);
    await withState(async state=>assert.equal(state.identity.assertion,'TEST_ASSERTION'),dir);
    assert.ok(!(await readFile(join(dir,'credentials.json'),'utf8')).includes('accessToken'));
    await chmod(join(dir,'credentials.json'),0o644);
    await assert.rejects(withState(async()=>{},dir),/Unsafe/);
  } finally {await rm(dir,{recursive:true,force:true});}
});
test('rejects symlink credential targets and insecure directories',async()=>{
  const dir=await mkdtemp(join(tmpdir(),'agenttrunk-auth-test-'));
  try {
    await writeFile(join(dir,'outside'),'PRIVATE',{mode:0o600});
    await symlink(join(dir,'outside'),join(dir,'credentials.json'));
    await assert.rejects(withState(async()=>{},dir),/safely open/);
    await chmod(dir,0o755);
    await assert.rejects(withState(async()=>{},dir),/0700/);
    assert.equal(await readFile(join(dir,'outside'),'utf8'),'PRIVATE');
  } finally {await rm(dir,{recursive:true,force:true});}
});
