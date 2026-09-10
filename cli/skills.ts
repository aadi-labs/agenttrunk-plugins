import {constants} from "node:fs";
import {lstat, mkdir, mkdtemp, open, readdir, realpath, rename, unlink} from "node:fs/promises";
import {basename, dirname, join, resolve} from "node:path";
import {createHash} from "node:crypto";
import {parseArgs} from "node:util";
import {AgentTrunk, AgentTrunkClient, resourcePath, type FileRecord} from "../sdk/index.js";
import {withAgentCredentials} from "./auth.js";

const marker = ".agenttrunk-sync.json";
type Binding = {version: 1; origin: string; workspace: string; key: string; revisionId: string; files: FileRecord[]};
const digest = (bytes: Uint8Array) => createHash("sha256").update(bytes).digest("hex");
function path(value: string) {
  resourcePath(value);
  if (value.split("/").some(part => part === marker || part === ".git")) throw new Error("Reserved sync path");
  return value;
}
function manifest(files: FileRecord[]) {
  if (!Array.isArray(files) || !files.length || files.length > 256) throw new Error("Invalid sync manifest");
  const seen = new Set<string>(); let size = 0;
  for (const file of files) {
    path(file.path);
    if (seen.has(file.path) || !Number.isSafeInteger(file.size) || file.size < 0 || file.size > 1_000_000 || !/^[a-f0-9]{64}$/.test(file.sha256)) throw new Error("Invalid sync manifest");
    seen.add(file.path); size += file.size;
  }
  if (size > 16_000_000) throw new Error("Sync package is too large");
}
async function readFile(filePath: string, max = 1_000_000) {
  const file = await open(filePath, constants.O_RDONLY | constants.O_NOFOLLOW | constants.O_NONBLOCK);
  try {
    const stat = await file.stat();
    if (!stat.isFile() || stat.size > max) throw new Error("Sync requires bounded regular files");
    const bytes = Buffer.alloc(max + 1); let offset = 0;
    while (offset < bytes.length) {const {bytesRead} = await file.read(bytes,offset,bytes.length-offset,offset); if (!bytesRead) break; offset += bytesRead;}
    if (offset > max) throw new Error("Sync file is too large");
    return bytes.subarray(0, offset);
  } finally {await file.close();}
}
async function scan(directory: string) {
  const files = new Map<string, Buffer>(); let entries = 0, total = 0;
  async function walk(relative = "", depth = 0) {
    if (depth > 32) throw new Error("Sync directory is too deep");
    for (const name of await readdir(join(directory, relative))) {
      if (++entries > 1024) throw new Error("Too many sync directory entries");
      if (!relative && name === marker) continue;
      const relativePath = path(relative ? `${relative}/${name}` : name);
      const full = join(directory, relativePath); const stat = await lstat(full);
      if (stat.isSymbolicLink()) throw new Error("Sync does not follow symlinks");
      if (stat.isDirectory()) await walk(relativePath, depth + 1);
      else {
        const bytes = await readFile(full); total += bytes.length; files.set(relativePath, bytes);
        if (files.size > 256 || total > 16_000_000) throw new Error("Sync package is too large");
      }
    }
  }
  await walk(); return files;
}
async function binding(directory: string, origin: string, workspace: string, key: string): Promise<Binding> {
  const data = JSON.parse((await readFile(join(directory, marker), 131072)).toString()) as Binding;
  if (data.version !== 1 || data.origin !== origin || data.workspace !== workspace || data.key !== key || !/^[a-f0-9]{64}$/.test(data.revisionId)) throw new Error("Sync binding does not match this origin/workspace/context");
  manifest(data.files); return data;
}
export function syncChanges(base: FileRecord[], local: Map<string, Buffer>) {
  manifest(base);
  const previous = new Map(base.map(file => [file.path,file]));
  const changes: Array<{operation:"put";path:string;contentBase64:string}|{operation:"delete";path:string}> = [];
  for (const [name, bytes] of local) {
    path(name); const old = previous.get(name);
    if (!old || old.size !== bytes.length || old.sha256 !== digest(bytes)) changes.push({operation:"put",path:name,contentBase64:bytes.toString("base64")});
  }
  for (const file of base) if (!local.has(file.path)) changes.push({operation:"delete",path:file.path});
  return changes;
}
async function writeNew(filePath: string, bytes: Uint8Array) {
  const file = await open(filePath, "wx", 0o600);
  try {await file.writeFile(bytes); await file.sync();} finally {await file.close();}
}
export async function runSkills(args: string[], env: NodeJS.ProcessEnv, write: (value: string|Uint8Array)=>void) {
  const [command,...rest] = args;
  if (!command || command === "--help") {write("agenttrunk skills pull|status|push --workspace ID --key KEY --directory PATH [--ref production|staging|REVISION] [--execute --yes]\nPull/push preview by default. Only pull accepts --ref. Push changes staging, never production.\n");return;}
  if (!["pull","status","push"].includes(command)) throw new Error("Unknown skills command");
  const {values} = parseArgs({args:rest,strict:true,allowPositionals:false,options:{workspace:{type:"string"},key:{type:"string"},directory:{type:"string"},ref:{type:"string"},execute:{type:"boolean"},yes:{type:"boolean"}}});
  if (!values.workspace || !values.key || !values.directory) throw new Error("Workspace, key and directory are required");
  if (values.ref && command !== "pull") throw new Error("Only pull accepts --ref");
  if (values.execute && !values.yes) throw new Error("Execution requires --yes after preview");
  const requested = resolve(values.directory);
  if (requested === dirname(requested)) throw new Error("Cannot sync a filesystem root");
  const parent = await realpath(dirname(requested)); const directory = join(parent,basename(requested));
  let exists = false;
  try {const stat = await lstat(directory); if (!stat.isDirectory() || stat.isSymbolicLink()) throw new Error("Sync target must be a real directory"); exists = true;} catch(error) {if ((error as NodeJS.ErrnoException).code !== "ENOENT") throw error;}
  const origin = new URL(env.AGENTTRUNK_API_URL ?? "https://api.agenttrunk.ai").origin;
  const base = exists ? await binding(directory,origin,values.workspace,values.key) : undefined;
  const local = exists ? await scan(directory) : new Map<string,Buffer>();
  if (command !== "pull" && !base) throw new Error("Pull this context before status or push");
  const changes = base ? syncChanges(base.files,local) : [];
  if (command === "status") {write(JSON.stringify({revisionId:base!.revisionId,changes:changes.map(({operation,path})=>({operation,path})),remoteChecked:false})+"\n");return;}
  if (command === "pull" && changes.length) throw new Error("Local changes exist; push or preserve them before pulling");
  if (command === "push" && (!local.size || changes.length > 256)) throw new Error("Push must retain files and contain at most 256 changes");
  const authorized = await withAgentCredentials(env);
  const client = new AgentTrunk({token:authorized.AGENTTRUNK_ACCESS_TOKEN??"",baseUrl:env.AGENTTRUNK_API_URL});
  const selected = await client.inspect(values.workspace,values.key,command === "push" ? "staging" : values.ref ?? "production");
  manifest(selected.revision.files);
  if (!/^[a-f0-9]{64}$/.test(selected.revision.id)) throw new Error("Expected immutable revision");
  if (command === "push" && selected.revision.id !== base!.revisionId) throw new Error("Remote staging changed; reconcile before pushing");
  const preview = {command,workspace:values.workspace,key:values.key,revisionId:selected.revision.id,
    files:command === "pull" ? selected.revision.files.map(file=>file.path) : undefined,
    changes:command === "push" ? changes.map(({operation,path})=>({operation,path})) : undefined};
  if (!values.execute) {write(JSON.stringify({...preview,preview:true})+"\n");return;}
  const lockPath = `${directory}.agenttrunk-lock`; const lock = await open(lockPath,"wx",0o600);
  try {
    // Recheck local state after locking, before any mutation.
    if (exists) {
      const latest = await binding(directory,origin,values.workspace,values.key);
      const now = await scan(directory);
      if (latest.revisionId !== base!.revisionId || JSON.stringify(syncChanges(base!.files,now)) !== JSON.stringify(changes)) throw new Error("Local files changed; preview again");
    } else {try {await lstat(directory); throw new Error("Destination appeared; preview again");} catch(error) {if ((error as NodeJS.ErrnoException).code !== "ENOENT") throw error;}}
    if (command === "push") {
      if (!changes.length) {write(JSON.stringify({...preview,unchanged:true})+"\n");return;}
      const generated = new AgentTrunkClient({accessToken:authorized.AGENTTRUNK_ACCESS_TOKEN??"",baseUrl:origin});
      const result = await generated.contexts.edit(values.workspace,values.key,{expectedRevisionId:base!.revisionId,changes});
      manifest(result.revision.files);
      if (!/^[a-f0-9]{64}$/.test(result.revision.id) || syncChanges(result.revision.files,local).length) throw new Error("Unexpected edit receipt; inspect remote state before retrying");
      const next: Binding = {...base!,revisionId:result.revision.id,files:result.revision.files};
      const temporary = join(directory,`${marker}.${crypto.randomUUID()}`);
      await writeNew(temporary,Buffer.from(JSON.stringify(next))); await rename(temporary,join(directory,marker));
      write(JSON.stringify({command,revisionId:next.revisionId,productionChanged:false})+"\n");
    } else {
      const temporary = await mkdtemp(join(parent,`.${basename(directory)}-download-`));
      // A failed download remains a private partial directory, never an installed skill.
      for (const file of selected.revision.files) {
        const bytes = await client.readFile(values.workspace,values.key,selected.revision.id,file);
        await mkdir(dirname(join(temporary,file.path)),{recursive:true,mode:0o700}); await writeNew(join(temporary,file.path),bytes);
      }
      const next: Binding = {version:1,origin,workspace:values.workspace,key:values.key,revisionId:selected.revision.id,files:selected.revision.files};
      await writeNew(join(temporary,marker),Buffer.from(JSON.stringify(next)));
      let backup: string|undefined;
      if (exists) {
        if (syncChanges(base!.files,await scan(directory)).length) throw new Error("Local files changed during download");
        backup = `${directory}.backup-${crypto.randomUUID()}`; await rename(directory,backup);
      }
      try {await rename(temporary,directory);} catch(error) {if(backup) await rename(backup,directory);throw error;}
      write(JSON.stringify({command,revisionId:next.revisionId,directory,backup,skillExecuted:false})+"\n");
    }
  } finally {await lock.close();await unlink(lockPath);}
}
