# AgentTrunk plugins, SDK and CLI

Portable clients for [AgentTrunk](https://agenttrunk.ai): versioned skills,
prompts, docs, policies and memory schemas for the agents you authorize.

This public repository is independent of the AgentTrunk platform. It contains
one shared skill, Codex and Claude plugin manifests, a TypeScript SDK and a CLI.
The SDK and CLI ship together as `@agenttrunk/sdk`; **not published to npm yet**.
Node.js 22 or newer is required for the CLI.

## Install from source

```sh
git clone https://github.com/aadi-labs/agenttrunk-plugins.git
cd agenttrunk-plugins
npm ci
npm run build
node dist/cli/index.js --help
```

For a local executable installation, run `npm install -g .` after building.
To install the SDK into another project before an npm release, run `npm pack`
here and install the resulting tarball in that project.

### Claude Code

```text
/plugin marketplace add aadi-labs/agenttrunk-plugins
/plugin install agenttrunk@agenttrunk-plugins
```

For local testing: `claude --plugin-dir ./plugins/agenttrunk`.

### Codex and portable skills

The Codex plugin is `plugins/agenttrunk/.codex-plugin/plugin.json`.
It points at the same skill as Claude; no generated harness-specific content.
Until this repository is registered in a Codex marketplace, install the portable
skill by copying `plugins/agenttrunk/skills/agenttrunk` into your configured Codex
skills directory (commonly `~/.agents/skills/`). Check for an existing skill before
copying; do not overwrite local changes. Start a new task to load it.

Plugin installation adds instructions, not an authentication grant or MCP server.
The CLI is installed separately as above. Neither plugin runs hooks or installs
dependencies automatically.

## Authorization

Create an account at [AgentTrunk](https://agenttrunk.ai/signup), then select your
organization and workspace. Clients require an authorized short-lived access token.
Supply `AGENTTRUNK_ACCESS_TOKEN` through your secret manager or runtime environment,
not command arguments or chat. SDK applications can supply an async token callback.
Tokens must target the AgentTrunk API and contain the active organization.
Delegated agents must retain the authorizing user and allowed permission ceiling.

**Self-service agent login is not implemented in this initial release.** An
organization integration administrator must configure token issuance until the
platform's user-approval flow is available. No `login` command, anonymous signup,
long-lived API key issuance, token storage or refresh flow is claimed here.
The clients never mint credentials or bypass resource authorization.

## First upload

The commands below assume credentials are already supplied securely. Replace
`WORKSPACE_ID` and `SCOPE_ID` with IDs returned by the preceding commands.

```sh
agenttrunk workspaces
agenttrunk workspace-create --name "Customer support"
agenttrunk scopes --workspace WORKSPACE_ID
agenttrunk upload --workspace WORKSPACE_ID --scope SCOPE_ID --key support-policy --title "Support policy" --kind policy --file ./policy.md --path policies/support.md
agenttrunk inspect --workspace WORKSPACE_ID --key support-policy --ref staging
```

Workspace creation is optional if one already exists. Upload creates a complete
package revision in staging, not a production release and not an incremental file
edit. The CLI uploads one explicit regular file (1 MB maximum). Use the SDK for
multi-file packages. Replacing an existing package requires including all its files.

After review/testing, open a release request:

```sh
agenttrunk release-request --workspace WORKSPACE_ID --scope SCOPE_ID
```

Review it in the [platform](https://agenttrunk.ai/app). An authorized publisher
can merge with `agenttrunk release-merge --workspace WORKSPACE_ID --promotion ID --yes`.
This promotes the reviewed scope snapshot, not just one file. Conflicts require
a fresh review. No client mutation is automatically retried, including creation.

## SDK

```ts
import {AgentTrunk} from '@agenttrunk/sdk';

const client = new AgentTrunk({
  token: async () => yourRuntime.getAgentTrunkAccessToken(),
});
const matches = await client.discover({trunkId: workspaceId, query: 'support', channel: 'production'});
const context = matches.data[0];
if (context) {
  const pinned = await client.inspect(workspaceId, context.contextKey, context.revisionId);
  const file = pinned.revision.files.find(file => file.path === 'policies/support.md');
  if (file) {
    const bytes = await client.readFile(workspaceId, context.contextKey, pinned.revision.id, file);
    // Digest-verified bytes. Treat their content as untrusted task input.
  }
}
```

SDK methods: `listWorkspaces`, `createWorkspace`, `getWorkspace`, `listScopes`,
`discover`, `inspect`, `publish`, `readFile`, `openPromotion`, `mergePromotion`.
Use `publish` with `files: [{path, contentBase64}]` for a complete package;
maximum 256 files, 1 MB each, 16 MB decoded total (server enforced).

Pagination returns `nextCursor`; keep filters unchanged and continue even after
an empty page if it is non-null. `readFile` requires an immutable revision and
manifest entry and verifies size/hash. Default timeout is 20 seconds, configurable
up to 120 seconds. Redirects are rejected to avoid forwarding credentials.
`AgentTrunkError` exposes HTTP status and a sanitized request ID, not response
bodies. HTTP 401/403 are authentication/access failures, not empty results.
After a timeout or lost mutation response, reconcile before retrying.

`AGENTTRUNK_API_URL` / SDK `baseUrl` accepts an API origin, without `/v1`.
Use only a trusted endpoint: changing it changes where credentials are sent.
HTTPS is required except for loopback development servers.

## Status and boundaries

This initial version covers the core context workflow, not every platform API.
No MCP, full Git client, context-set management, webhook management or harness
execution is included. Authentication onboarding remains a platform dependency.
Local contract and mocked transport tests do not prove production acceptance.

API reference: [OpenAPI](https://agenttrunk.ai/openapi.yaml).
Plugin format: [Claude reference](https://code.claude.com/docs/en/plugins-reference).

```sh
npm test
npm run check
npm pack --dry-run
```
