/** Agent Registration client. The caller owns secret storage and human approval. */
export interface AgentIdentity { assertion: string; refresh_token?: {value: string} }
export interface RegistrationAttempt {claim: {token: string; attempt?: {verification_uri: string}}}
export class AgentAuthError extends Error {
  constructor(readonly code: string, readonly status?: number) {super(`Agent authentication failed: ${code}`);}
}
function origin(value: string) {
  const u = new URL(value);
  if (u.protocol !== "https:" || u.username || u.password || u.pathname !== "/" || u.search || u.hash) throw new AgentAuthError("invalid_origin");
  return u.origin;
}
function endpoint(value: unknown, authority: string): string {
  if (typeof value !== "string") throw new AgentAuthError("invalid_discovery");
  const u = new URL(value);
  if (u.origin !== authority || u.username || u.password || u.hash) throw new AgentAuthError("untrusted_endpoint");
  return u.href;
}
function secret(value: unknown): string {
  if (typeof value !== "string" || !value || value.length > 32768 || /\s/.test(value)) throw new AgentAuthError("invalid_credentials");
  return value;
}
async function json(fetcher: typeof fetch, url: string, init: RequestInit = {}): Promise<any> {
  let response: Response;
  try {response = await fetcher(url, {...init, redirect: "manual", signal: AbortSignal.timeout(15000)});} catch {throw new AgentAuthError("network_error");}
  if (!response.ok) {await response.body?.cancel(); throw new AgentAuthError("request_rejected", response.status);}
  const reader = response.body?.getReader();
  if (!reader) throw new AgentAuthError("invalid_response");
  const chunks: Uint8Array[] = []; let size = 0;
  try {while (true) {const {done,value} = await reader.read(); if (done) break; size += value.byteLength;
    if(size > 131072) {await reader.cancel(); throw new AgentAuthError("response_too_large");} chunks.push(value);}}
  finally {reader.releaseLock();}
  const bytes = new Uint8Array(size); let offset = 0;
  for (const chunk of chunks) {bytes.set(chunk,offset); offset+=chunk.byteLength;}
  try {return JSON.parse(new TextDecoder().decode(bytes));} catch {throw new AgentAuthError("invalid_response");}
}
export class AgentRegistration {
  private constructor(readonly resource: string, readonly issuer: string, readonly guide: string,
    private readonly identityEndpoint: string, private readonly claimEndpoint: string,
    private readonly tokenEndpoint: string, private readonly fetcher: typeof fetch) {}

  static async discover(resource = "https://api.agenttrunk.ai", fetcher: typeof fetch = fetch) {
    const api = origin(resource);
    const metadata = await json(fetcher, `${api}/.well-known/oauth-protected-resource`);
    if (metadata.resource !== api || !Array.isArray(metadata.authorization_servers) || metadata.authorization_servers.length !== 1) throw new AgentAuthError("invalid_discovery");
    const issuer = origin(metadata.authorization_servers[0]);
    const server = await json(fetcher, `${issuer}/.well-known/oauth-authorization-server`);
    if (server.issuer !== issuer || !server.agent_auth?.identity_types_supported?.includes("service_auth")) throw new AgentAuthError("registration_unavailable");
    return new AgentRegistration(api, issuer, endpoint(server.agent_auth.skill,issuer),
      endpoint(server.agent_auth.identity_endpoint,issuer), endpoint(server.agent_auth.claim_endpoint,issuer), endpoint(server.token_endpoint,issuer),fetcher);
  }
  private post(url: string, body: object) {return json(this.fetcher,url,{method:"POST",headers:{"content-type":"application/json"},body:JSON.stringify(body)});}
  async start(email: string): Promise<{claimToken: string; verificationUri: string}> {
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email) || email.length > 254) throw new AgentAuthError("invalid_email");
    const registration = await this.post(this.identityEndpoint,{type:"service_auth",login_hint:email});
    const claimToken = secret(registration.claim?.token);
    // Use the initial attempt when supplied; never duplicate a valid attempt.
    const attempt = registration.claim?.attempt ?? (await this.post(this.claimEndpoint,{type:"service_auth",login_hint:email,claim_token:claimToken})).attempt;
    return {claimToken, verificationUri: endpoint(attempt?.verification_uri,this.issuer)};
  }
  async complete(claimToken: string, userCode: string): Promise<AgentIdentity> {
    if (!/^[A-Za-z0-9-]{4,32}$/.test(userCode)) throw new AgentAuthError("invalid_user_code");
    const result = await this.post(`${this.claimEndpoint}/complete`,{claim_token:secret(claimToken),user_code:userCode});
    return this.identity(result.identity);
  }
  async exchange(identity: AgentIdentity): Promise<{accessToken: string; expiresIn: number}> {
    const result = await json(this.fetcher,this.tokenEndpoint,{method:"POST",headers:{"content-type":"application/x-www-form-urlencoded"},
      body:new URLSearchParams({grant_type:"urn:ietf:params:oauth:grant-type:jwt-bearer",assertion:secret(identity.assertion),resource:this.resource})});
    if (result.token_type?.toLowerCase() !== "bearer" || !Number.isFinite(result.expires_in) || result.expires_in <= 0) throw new AgentAuthError("invalid_credentials");
    return {accessToken:secret(result.access_token),expiresIn:result.expires_in};
  }
  async refresh(identity: AgentIdentity): Promise<AgentIdentity> {
    return this.identity((await this.post(this.identityEndpoint,{type:"refresh",refresh_token:secret(identity.refresh_token?.value)})).identity);
  }
  private identity(value: any): AgentIdentity {
    return {assertion:secret(value?.assertion),...(value?.refresh_token ? {refresh_token:{value:secret(value.refresh_token.value)}} : {})};
  }
}
