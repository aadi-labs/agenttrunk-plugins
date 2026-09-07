#!/usr/bin/env node
import {parseArgs} from "node:util";
import {open, constants} from "node:fs/promises";
import {pathToFileURL} from "node:url";
import {AgentTrunk, AgentTrunkError, resourcePath, type ContextKind} from "../sdk/index.js";

export const help = `AgentTrunk — versioned context for your agents

  agenttrunk workspaces [--cursor CURSOR]
  agenttrunk workspace-create --name NAME
  agenttrunk scopes --workspace ID
  agenttrunk discover [--query TEXT] [--workspace ID] [--scope ID] [--channel production|staging|latest] [--cursor CURSOR]
  agenttrunk inspect --workspace ID --key KEY [--ref production|staging|latest|REVISION]
  agenttrunk upload --workspace ID --scope ID --key KEY --title TITLE --kind skill|docs|prompt|policy|memory-schema --file FILE --path RESOURCE_PATH
  agenttrunk read --workspace ID --key KEY --ref REVISION --path RESOURCE_PATH
  agenttrunk release-request --workspace ID --scope ID [--evidence URL]
  agenttrunk release-merge --workspace ID --promotion ID --yes

Set AGENTTRUNK_ACCESS_TOKEN through your runtime's secret manager.
Optional AGENTTRUNK_API_URL must be a trusted HTTPS origin (default api.agenttrunk.ai).
JSON output except read (verified raw bytes). No automatic mutation retries.
Sign up at https://agenttrunk.ai/signup. Self-service agent login is not yet available.
`;
const commandOptions: Record<string, string[]> = {
  workspaces: ["cursor"], "workspace-create": ["name"], scopes: ["workspace"],
  discover: ["query", "workspace", "scope", "channel", "cursor"],
  inspect: ["workspace", "key", "ref"], upload: ["workspace", "scope", "key", "title", "kind", "file", "path"],
  read: ["workspace", "key", "ref", "path"], "release-request": ["workspace", "scope", "evidence"],
  "release-merge": ["workspace", "promotion", "yes"],
};
export async function run(args: string[], env: NodeJS.ProcessEnv = process.env, write: (value: string | Uint8Array) => void = v => {process.stdout.write(v);}) {
  const [command, ...rest] = args;
  if (!command || command === "--help" || command === "help") { write(help); return; }
  const allowed = commandOptions[command];
  if (!allowed) throw new Error("Unknown command. Run agenttrunk --help");
  const options = Object.fromEntries(allowed.map(key => [key, {type: key === "yes" ? "boolean" as const : "string" as const}]));
  const {values} = parseArgs({args: rest, options, strict: true, allowPositionals: false});
  const value = (key: string) => typeof values[key] === "string" ? values[key] as string : undefined;
  const need = (key: string) => { const v = value(key); if (!v) throw new Error(`--${key} is required`); return v; };
  const client = new AgentTrunk({token: env.AGENTTRUNK_ACCESS_TOKEN ?? "", baseUrl: env.AGENTTRUNK_API_URL});
  let result: unknown;
  switch (command) {
    case "workspaces": result = await client.listWorkspaces({cursor: value("cursor")}); break;
    case "workspace-create": result = await client.createWorkspace({name: need("name")}); break;
    case "scopes": result = await client.listScopes(need("workspace")); break;
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
if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  run(process.argv.slice(2)).catch(error => {
    // Provider and transport errors can contain sensitive request details. Never dump them.
    const message = error instanceof AgentTrunkError
      ? `${error.message}${error.requestId ? `; request ${error.requestId}` : ""}`
      : "Command failed. Check command arguments, credentials and network. Writes may have succeeded; reconcile before retrying.";
    process.stderr.write(JSON.stringify({error: message}) + "\n"); process.exitCode = 1;
  });
}
