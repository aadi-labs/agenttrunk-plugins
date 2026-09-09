import {test} from 'node:test';
import assert from 'node:assert/strict';
import {AgentRegistration} from '../dist/sdk/agent-auth.js';
const api='https://api.example.com', issuer='https://auth.example.com';
function mock(overrides={}) {
  const calls=[];
  const fetcher=async(url,init={})=>{
    calls.push({url,init});
    assert.equal(init.redirect,'manual');
    assert.ok(!new Headers(init.headers).has('authorization'));
    const responses={
      [`${api}/.well-known/oauth-protected-resource`]:{resource:api,authorization_servers:[issuer]},
      [`${issuer}/.well-known/oauth-authorization-server`]:{issuer,token_endpoint:`${issuer}/oauth2/token`,agent_auth:{skill:`${issuer}/agent/auth.md`,identity_endpoint:`${issuer}/agent/identity`,claim_endpoint:`${issuer}/agent/identity/claim`,identity_types_supported:['service_auth']}},
      [`${issuer}/agent/identity`]:{claim:{token:'SECRET_CLAIM',attempt:{verification_uri:`${issuer}/approve`}}},
      [`${issuer}/agent/identity/claim/complete`]:{identity:{assertion:'SECRET_ASSERTION',refresh_token:{value:'SECRET_REFRESH'}}},
      [`${issuer}/oauth2/token`]:{access_token:'SECRET_ACCESS',token_type:'Bearer',expires_in:300},
      ...overrides,
    };
    const result=responses[url];
    if(result instanceof Response) return result;
    assert.ok(result,`unexpected endpoint ${url}`);
    return Response.json(result);
  };
  return {calls,fetcher};
}
test('discover, human claim and exchange use trusted endpoints and reuse initial attempt',async()=>{
  const {calls,fetcher}=mock(); const auth=await AgentRegistration.discover(api,fetcher);
  const attempt=await auth.start('human@example.com');
  assert.equal(attempt.verificationUri,`${issuer}/approve`);
  const identity=await auth.complete(attempt.claimToken,'ABCD-EFGH');
  assert.equal((await auth.exchange(identity)).expiresIn,300);
  assert.equal(calls.length,5);
  assert.equal(new URLSearchParams(calls[4].init.body).get('resource'),api);
});
test('does not follow redirects, leak provider errors, retry mutations or accept anonymous-only discovery',async()=>{
  const {calls,fetcher}=mock({[`${issuer}/agent/identity`]:new Response('SECRET_PROVIDER_ERROR',{status:500})});
  const auth=await AgentRegistration.discover(api,fetcher);
  await assert.rejects(auth.start('human@example.com'),error=>!error.message.includes('SECRET') && error.status===500);
  assert.equal(calls.length,3);
  const redirected=mock({[`${api}/.well-known/oauth-protected-resource`]:new Response(null,{status:302,headers:{location:'https://attacker.example'}})});
  await assert.rejects(AgentRegistration.discover(api,redirected.fetcher)); assert.equal(redirected.calls.length,1);
  const anonymous=mock({[`${issuer}/.well-known/oauth-authorization-server`]:{issuer,agent_auth:{identity_types_supported:['anonymous']}}});
  await assert.rejects(AgentRegistration.discover(api,anonymous.fetcher));
});
test('rejects credential exfiltration through discovery and invalid origins',async()=>{
  const changed=mock({[`${issuer}/.well-known/oauth-authorization-server`]:{issuer,token_endpoint:'https://attacker.example/token',agent_auth:{skill:`${issuer}/agent/auth.md`,identity_endpoint:`${issuer}/agent/identity`,claim_endpoint:`${issuer}/agent/identity/claim`,identity_types_supported:['service_auth']}}});
  await assert.rejects(AgentRegistration.discover(api,changed.fetcher));
  await assert.rejects(AgentRegistration.discover('https://user:pass@api.example.com',()=>{throw new Error('must not fetch');}));
});
test('refresh is explicit, rotates identity, and submits the secret only in the request body',async()=>{
  const {calls,fetcher}=mock({[`${issuer}/agent/identity`]:{identity:{assertion:'NEXT_ASSERTION',refresh_token:{value:'NEXT_REFRESH'}}}});
  const auth=await AgentRegistration.discover(api,fetcher);
  const next=await auth.refresh({assertion:'OLD_ASSERTION',refresh_token:{value:'OLD_REFRESH'}});
  assert.equal(next.refresh_token.value,'NEXT_REFRESH');
  assert.deepEqual(JSON.parse(calls[2].init.body),{type:'refresh',refresh_token:'OLD_REFRESH'});
  assert.ok(!calls[2].url.includes('OLD_REFRESH'));
  assert.equal(calls.length,3);
});
