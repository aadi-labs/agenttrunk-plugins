import {constants} from "node:fs";
import {lstat, mkdir, open, rename, unlink} from "node:fs/promises";
import {homedir} from "node:os";
import {join} from "node:path";
import {createInterface} from "node:readline/promises";
import {parseArgs} from "node:util";
import {AgentRegistration, type AgentIdentity} from "../sdk/agent-auth.js";

type State = {resource: string; issuer?: string; identity?: AgentIdentity; pending?: {claimToken: string; verificationUri: string}};
const directory = () => join(homedir(), ".agenttrunk");
async function secureDirectory(path = directory()) {
  await mkdir(path, {mode: 0o700, recursive: true});
  const stat = await lstat(path);
  if (!stat.isDirectory() || stat.isSymbolicLink() || (stat.mode & 0o077) || (process.getuid && stat.uid !== process.getuid())) throw new Error("AgentTrunk credential directory must be owned by you with mode 0700");
  return path;
}
async function readState(path: string): Promise<State | undefined> {
  let file;
  try {file = await open(path, constants.O_RDONLY | constants.O_NOFOLLOW | constants.O_NONBLOCK);} catch (e) {
    if ((e as NodeJS.ErrnoException).code === "ENOENT") return;
    throw new Error("Cannot safely open AgentTrunk credentials");
  }
  try {
    const stat = await file.stat();
    if (!stat.isFile() || (stat.mode & 0o077) || stat.size > 131072 || (process.getuid && stat.uid !== process.getuid())) throw new Error("Unsafe AgentTrunk credential file");
    const buffer = Buffer.alloc(131073); const {bytesRead} = await file.read(buffer,0,buffer.length,0);
    if (bytesRead > 131072) throw new Error("Oversize credentials");
    return JSON.parse(buffer.subarray(0,bytesRead).toString());
  } finally {await file.close();}
}
export async function withState<T>(operation: (state: State | undefined, save: (state: State) => Promise<void>) => Promise<T>, storageDirectory = directory()) {
  const dir = await secureDirectory(storageDirectory);
  const lockPath = join(dir,"credentials.lock");
  let lock;
  try {lock = await open(lockPath,"wx",0o600);} catch {throw new Error("Another authentication operation is running; do not retry a pending credential rotation");}
  const path = join(dir,"credentials.json");
  try {
    return await operation(await readState(path), async state => {
      const temporary = join(dir,`credentials-${crypto.randomUUID()}.tmp`);
      const file = await open(temporary,"wx",0o600);
      try {await file.writeFile(JSON.stringify(state)); await file.sync();} finally {await file.close();}
      await rename(temporary,path);
    });
  } finally {await lock.close(); await unlink(lockPath);}
}
export async function runAuth(args: string[], env: NodeJS.ProcessEnv, write: (value: string | Uint8Array) => void) {
  const [command,...rest] = args;
  if (!command || !["discover","start","complete","refresh","cancel","logout"].includes(command)) throw new Error("Use auth discover, start, complete, refresh, cancel, or logout --yes");
  const {values} = parseArgs({args:rest,options:command === "start" ? {email:{type:"string"}} : command === "logout" ? {yes:{type:"boolean"}} : {},strict:true,allowPositionals:false});
  const resource = env.AGENTTRUNK_API_URL ?? "https://api.agenttrunk.ai";
  if (command === "logout") {
    if (!values.yes) {write("Local sign-out clears this CLI's stored identity and pending claim. It does not revoke server access or runtime-injected tokens. Run auth logout --yes to confirm.\n");return;}
    await withState(async(state,save)=>{
      if(state && state.resource !== resource) throw new Error("Stored credentials belong to another origin");
      await save({resource});
    });
    write("Local credentials cleared. Existing tokens and remote agent grants must be revoked separately by an administrator.\n");return;
  }
  if (command === "cancel") {
    await withState(async (state,save) => {
      if (state?.identity) throw new Error("Cannot cancel a completed registration; revoke it through the account administrator");
      if (state && state.resource !== resource) throw new Error("Credentials belong to another API origin");
      await save({resource});
      write("Local pending claim cleared. Its provider attempt expires independently.\n");
    });
    return;
  }
  const auth = await AgentRegistration.discover(resource);
  if (command === "discover") {write(JSON.stringify({resource:auth.resource,issuer:auth.issuer,guide:auth.guide,humanApprovalRequired:true})+"\n");return;}
  await withState(async (state,save) => {
    if (state && state.resource !== resource) throw new Error("Stored credentials belong to another API origin; use an isolated home directory for another environment");
    if ((state?.identity || state?.pending) && state.issuer !== auth.issuer) throw new Error("Authorization server changed; stored credentials will not be sent to a new issuer");
    if (command === "start") {
      if (state?.identity) {write("Already registered. Run workspaces, or auth refresh if the assertion expired.\n");return;}
      if (state?.pending) {write(JSON.stringify({verificationUri:state.pending.verificationUri,next:"Human approves, then run auth complete and enter the code on stdin."})+"\n");return;}
      if (typeof values.email !== "string" || !values.email) throw new Error("--email is required");
      const pending = await auth.start(values.email);
      await save({resource,issuer:auth.issuer,pending});
      write(JSON.stringify({verificationUri:pending.verificationUri,next:"Human approves, then run auth complete and enter the code on stdin."})+"\n");
    } else if (command === "complete") {
      if (!state?.pending) throw new Error("Run auth start first");
      // The human must provide this code. Never extract it from their browser.
      const input = createInterface({input:process.stdin,output:process.stderr,terminal:false});
      let code: string;
      try {code = (await input.question("Code from your human: ")).trim();} finally {input.close();}
      const identity = await auth.complete(state.pending.claimToken,code);
      await save({resource,issuer:auth.issuer,identity});
      write("Agent authorized. Run workspaces and choose the workspace for this task.\n");
    } else {
      if (!state?.identity) throw new Error("Run auth start first");
      const identity = await auth.refresh(state.identity);
      await save({resource,issuer:auth.issuer,identity});
      write("Agent credentials refreshed.\n");
    }
  });
}
export async function withAgentCredentials(env: NodeJS.ProcessEnv): Promise<NodeJS.ProcessEnv> {
  if (env.AGENTTRUNK_ACCESS_TOKEN) return env;
  // Avoid creating a credential directory for help or unauthenticated API calls.
  try {await lstat(directory());} catch {return env;}
  return withState(async state => {
    if (!state?.identity) return env;
    const resource = env.AGENTTRUNK_API_URL ?? "https://api.agenttrunk.ai";
    if (state.resource !== resource) throw new Error("Credentials belong to another API origin");
    const auth = await AgentRegistration.discover(resource);
    if (state.issuer !== auth.issuer) throw new Error("Authorization server changed; stored credentials will not be sent to a new issuer");
    const credential = await auth.exchange(state.identity);
    return {...env,AGENTTRUNK_ACCESS_TOKEN:credential.accessToken};
  });
}
