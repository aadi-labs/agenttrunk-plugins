#!/usr/bin/env node
import {runApi} from "./api.js";
import {runSkills} from "./skills.js";
import {runAuth, withAgentCredentials} from "./auth.js";
import {parseArgs} from "node:util";
import {existsSync, realpathSync} from "node:fs";
import {open, constants} from "node:fs/promises";
import {pathToFileURL} from "node:url";
import {AgentTrunk, AgentTrunkError, resourcePath, type ContextKind} from "../sdk/index.js";

export const help = `AgentTrunk — versioned context for your agents

  agenttrunk doctor
  agenttrunk skills pull|status|push --workspace ID --key KEY --directory PATH [--execute --yes]
  agenttrunk auth discover
  agenttrunk auth start --email HUMAN_EMAIL
  agenttrunk auth complete
  agenttrunk auth refresh
  agenttrunk auth cancel
  agenttrunk auth logout [--yes]
  agenttrunk api list
  agenttrunk api RESOURCE.METHOD --help
  agenttrunk api RESOURCE.METHOD --input request.json [--execute] [--yes]

  agenttrunk workspaces [--cursor CURSOR]
  agenttrunk workspace-create --name NAME
  agenttrunk scopes --workspace ID
  agenttrunk scope-create --workspace ID --name NAME [--slug SLUG]
  agenttrunk discover [--query TEXT] [--workspace ID] [--scope ID] [--channel production|staging|latest] [--cursor CURSOR]
  agenttrunk inspect --workspace ID --key KEY [--ref production|staging|latest|REVISION]
  agenttrunk upload --workspace ID --scope ID --key KEY --title TITLE --kind skill|docs|prompt|policy|memory-schema --file FILE --path RESOURCE_PATH
  agenttrunk read --workspace ID --key KEY --ref REVISION --path RESOURCE_PATH
  agenttrunk release-request --workspace ID --scope ID [--evidence URL]
  agenttrunk releases --workspace ID [--scope ID] [--status open|merged|closed] [--cursor CURSOR]
  agenttrunk release-merge --workspace ID --promotion ID --yes

Set AGENTTRUNK_ACCESS_TOKEN through your runtime's secret manager.
Optional AGENTTRUNK_API_URL must be a trusted HTTPS origin (default api.agenttrunk.ai).
JSON output except read (verified raw bytes). No automatic mutation retries.
Setup and examples: https://github.com/aadi-labs/agenttrunk-plugins#start-here
New humans sign up at https://agenttrunk.ai/signup. Agents use auth start and human approval.
`;
const commandOptions: Record<string, string[]> = {
  workspaces: ["cursor"], "workspace-create": ["name"], scopes: ["workspace"],
  "scope-create": ["workspace", "name", "slug"], releases: ["workspace", "scope", "status", "cursor"],
  discover: ["query", "workspace", "scope", "channel", "cursor"],
  inspect: ["workspace", "key", "ref"], upload: ["workspace", "scope", "key", "title", "kind", "file", "path"],
  read: ["workspace", "key", "ref", "path"], "release-request": ["workspace", "scope", "evidence"],
  "release-merge": ["workspace", "promotion", "yes"],
};
export async function run(args: string[], env: NodeJS.ProcessEnv = process.env, write: (value: string | Uint8Array) => void = v => {process.stdout.write(v);}) {
  const [command, ...rest] = args;
  if (!command || command === "--help" || command === "help") { write(help); return; }
  if (command === "auth") return runAuth(rest,env,write);
  if (command === "skills") return runSkills(rest,env,write);
  if (command === "api") return runApi(rest, rest[0] === "list" || rest.includes("--help") ? env : await withAgentCredentials(env),write);
  if (command === "doctor") {
    if(rest.length) throw new Error("doctor takes no arguments");
    let originValid=true; try {const u=new URL(env.AGENTTRUNK_API_URL??"https://api.agenttrunk.ai"); originValid=!u.username&&!u.password&&!u.search&&!u.hash&&(u.protocol==="https:"||["localhost","127.0.0.1","[::1]"].includes(u.hostname));}catch{originValid=false;}
    write(JSON.stringify({node:process.versions.node,tokenConfigured:Boolean(env.AGENTTRUNK_ACCESS_TOKEN),originValid,registrationSupported:true,hostedAuthVerified:false,next:env.AGENTTRUNK_ACCESS_TOKEN?"Run workspaces, then select the workspace for this task.":"Run auth discover, then auth start --email HUMAN_EMAIL. Reuse stored authorization if already connected."})+"\n"); return;
  }
  const allowed = commandOptions[command];
  if (!allowed) throw new Error("Unknown command. Run agenttrunk --help");
  const options = Object.fromEntries(allowed.map(key => [key, {type: key === "yes" ? "boolean" as const : "string" as const}]));
  const {values} = parseArgs({args: rest, options, strict: true, allowPositionals: false});
  const value = (key: string) => typeof values[key] === "string" ? values[key] as string : undefined;
  const need = (key: string) => { const v = value(key); if (!v) throw new Error(`--${key} is required`); return v; };
  const authorizedEnv = await withAgentCredentials(env);
  const client = new AgentTrunk({token: authorizedEnv.AGENTTRUNK_ACCESS_TOKEN ?? "", baseUrl: env.AGENTTRUNK_API_URL});
  let result: unknown;
  switch (command) {
    case "workspaces": result = await client.listWorkspaces({cursor: value("cursor")}); break;
    case "workspace-create": result = await client.createWorkspace({name: need("name")}); break;
    case "scopes": result = await client.listScopes(need("workspace")); break;
    case "scope-create": result = await client.createScope(need("workspace"), {name: need("name"), slug: value("slug")}); break;
    case "releases": {
      const status = value("status");
      if (status && !["open", "merged", "closed"].includes(status)) throw new Error("Invalid release status");
      result = await client.listPromotions(need("workspace"), {scopeId: value("scope"), status: status as "open" | "merged" | "closed" | undefined, cursor: value("cursor")}); break;
    }
    case "discover": {
      const channel = value("channel") ?? "production";
      if (!["production", "staging", "latest"].includes(channel)) throw new Error("Invalid channel");
      result = await client.discover({query: value("query"), trunkId: value("workspace"), scopeId: value("scope"), cursor: value("cursor"), channel: channel as "production" | "staging" | "latest"}); break;
    }
    case "inspect": result = await client.inspect(need("workspace"), need("key"), value("ref")); break;
    case "upload": {
      const workspace = need("workspace"), scopeId = need("scope"), contextKey = need("key"), title = need("title"), kind = need("kind");
      if (!["skill", "docs", "prompt", "policy", "memory-schema"].includes(kind)) throw new Error("Invalid context kind");
      const path = need("path"); resourcePath(path);
      // Single explicit file only: no automatic directory traversal or credential discovery.
      const file = await open(need("file"), constants.O_RDONLY | constants.O_NOFOLLOW | constants.O_NONBLOCK);
      let bytes: Buffer;
      try {
        const stat = await file.stat();
        if (!stat.isFile() || stat.size > 1_000_000) throw new Error("Upload a regular file no larger than 1 MB");
        const buffer = Buffer.alloc(1_000_001);
        let size = 0;
        while (size < buffer.length) {
          const {bytesRead} = await file.read(buffer, size, buffer.length - size, null);
          if (!bytesRead) break;
          size += bytesRead;
        }
        if (size > 1_000_000) throw new Error("Upload exceeds 1 MB");
        bytes = buffer.subarray(0, size);
      } finally { await file.close(); }
      result = await client.publish(workspace, {scopeId, contextKey, title, kind: kind as ContextKind, files: [{path, contentBase64: bytes.toString("base64")}]}); break;
    }
    case "read": {
      const workspace = need("workspace"), key = need("key"), revision = need("ref"), path = need("path");
      if (!/^[a-f0-9]{64}$/.test(revision)) throw new Error("--ref must be an immutable revision ID from inspect");
      const manifest = await client.inspect(workspace, key, revision);
      if (manifest.revision.id !== revision) throw new Error("Revision mismatch");
      const file = manifest.revision.files.find(file => file.path === path);
      if (!file) throw new Error("File is not in the revision manifest");
      write(await client.readFile(workspace, key, revision, file)); return;
    }
    case "release-request": result = await client.openPromotion(need("workspace"), {scopeId: need("scope"), evidenceReference: value("evidence")}); break;
    case "release-merge":
      if (values.yes !== true) throw new Error("Production changes require --yes after reviewing the release request");
      result = await client.mergePromotion(need("workspace"), need("promotion")); break;
  }
  write(JSON.stringify(result, null, 2) + "\n");
}
if (process.argv[1] && existsSync(process.argv[1]) && import.meta.url === pathToFileURL(realpathSync(process.argv[1])).href) {
  run(process.argv.slice(2)).catch(error => {
    // Provider and transport errors can contain sensitive request details. Never dump them.
    const message = error instanceof AgentTrunkError
      ? `${error.message}${error.requestId ? `; request ${error.requestId}` : ""}`
      : "Command failed. Check command arguments, credentials and network. Writes may have succeeded; reconcile before retrying.";
    process.stderr.write(JSON.stringify({error: message}) + "\n"); process.exitCode = 1;
  });
}
