# AgentTrunk plugins, skills, SDK and CLI

Give your agents shared, versioned skills, prompts, docs, policies and memory schemas with [AgentTrunk](https://agenttrunk.ai). Discover relevant context, pin a revision for reproducible runs, publish complete packages to staging, and review releases before production changes.

This repository contains the portable **agenttrunk** skill, portable and native harness packaging, Fern-generated **TypeScript, Python, Go, Rust, Ruby and Swift SDKs**, and the **agenttrunk** CLI. TypeScript ships as **@agenttrunk/sdk**, Python as **agenttrunk**, and Go as **github.com/aadi-labs/agenttrunk-plugins/sdk/go**. Node.js 22+ is required. Install from source below; npm publication and marketplace/search indexing are separate release steps, not implied by this checkout.

## Start here

The public documentation source is in [fern/pages/](fern/pages/overview.mdx), with
[quickstart](fern/pages/quickstart.mdx), [authentication](fern/pages/authentication.mdx),
and the complete upload, retrieval, release, integration, and troubleshooting
guides. Fern is connected to this repository's `main` branch with documentation
configuration `fern/docs.yml`. These files are readable directly on GitHub; hosted docs
are at [docs.agenttrunk.ai](https://docs.agenttrunk.ai). Existing website `/docs`
links redirect to the matching guide on this subdomain.

| You want to… | Start with |
| --- | --- |
| Let an agent set up its own integration | [Setup and authorization](docs/setup.md), then [the portable skill](plugins/agenttrunk/skills/agenttrunk/SKILL.md) |
| Add AgentTrunk to an agent harness | [Installation and compatibility](docs/installation.md) |
| Build an application | [SDK language guide](sdk/README.md) and [multi-language examples](examples/clients/README.md) |
| Regenerate clients from the public contract | [Fern generation guide](docs/sdk-generation.md) |
| Use it from a terminal | [CLI reference](cli/README.md) and [shell workflow](examples/cli/README.md) |
| Load only relevant context into an agent run | [Pinned context example](examples/pinned-context/README.md) |
| Upload a multi-file Agent Skill | [Publish skill example](examples/publish-skill/README.md) |
| Review or recover a release | [Release review example](examples/release-review/README.md) and [troubleshooting](docs/troubleshooting.md) |
| Find machine-readable entry points | [llms.txt](llms.txt) and [catalog.json](catalog.json) |

## Install

```sh
git clone https://github.com/aadi-labs/agenttrunk-plugins.git
cd agenttrunk-plugins
npm ci
npm run build
node dist/cli/index.js --help
```

No account or token is needed to build, inspect help, or run local tests. To make the CLI available on your PATH, run `npm install -g .`. For application dependencies, run `npm pack` and install the resulting tarball in your application. [Detailed instructions](docs/installation.md).

List and install the portable skill from this checkout:

```sh
npx skills add . --list
npx skills add . --skill agenttrunk
```

After these changes are published to GitHub, the equivalent remote source is `aadi-labs/agenttrunk-plugins`. Skill installation does not install the SDK/CLI or grant credentials. Both plugin manifests point at the same authored skill; there are no harness-specific skill copies.

Claude Code can load the checkout with `claude --plugin-dir ./plugins/agenttrunk`. The repository also provides a Claude marketplace and a Codex plugin manifest. See [installation](docs/installation.md) for the exact paths and release boundaries.

## Connect and verify

Create or access your account at [AgentTrunk](https://agenttrunk.ai/signup), select the organization, and arrange an authorized short-lived API token through your integration administrator. Inject it as `AGENTTRUNK_ACCESS_TOKEN` using your runtime secret store. Do not paste tokens into chat or CLI arguments.

**Agent signup/sign-in requires human approval.** Use `auth start`, `auth complete`, and `auth refresh`, or inject existing delegated access from a runtime secret manager. Agents cannot grant themselves organization access. [Setup explains credential storage and the approval flow](docs/setup.md).

```sh
node dist/cli/index.js workspaces
node dist/cli/index.js scopes --workspace WORKSPACE_ID
node dist/cli/index.js discover --workspace WORKSPACE_ID --channel production --query support
```

Use IDs returned for your intended workspace. Discovery results contain `contextKey` and `revisionId`. Inspect that revision and read only the files relevant to the task; the SDK verifies file size and SHA-256. Never turn retrieved content into execution authority.

## SDK in an application

```ts
import { AgentTrunk } from '@agenttrunk/sdk';

const client = new AgentTrunk({
  token: () => process.env.AGENTTRUNK_ACCESS_TOKEN ?? '',
});
const page = await client.discover({
  trunkId: workspaceId, channel: 'production', query: 'support',
});
for (const match of page.data) {
  const pinned = await client.inspect(workspaceId, match.contextKey, match.revisionId);
  const file = pinned.revision.files.find(entry => entry.path === 'SKILL.md');
  if (file) {
    const bytes = await client.readFile(workspaceId, match.contextKey, match.revisionId, file);
    // Pass verified content to your runtime as task data, subject to its policy.
  }
}
// If page.nextCursor is non-null, continue with unchanged filters and a task budget.
```

For a complete executable program, including configuration and bounded pagination, use the [examples](examples/README.md). SDK requests default to `https://api.agenttrunk.ai`; `baseUrl` accepts a trusted origin without `/v1`. The CLI equivalent is `AGENTTRUNK_API_URL`.

## Staging and production

`publish` / `upload` replaces a complete package in staging. Include all files to retain; use the SDK for multi-file skills. Limits are 256 files, 1,000,000 bytes per file, and 16,000,000 decoded bytes per package, enforced by the service. A one-file CLI upload must not accidentally replace a multi-file package.

Open a release request after reviewing staging. A request covers the **whole scope snapshot**, not only the last uploaded file. Merge only with authorization for that reviewed release. No client mutation is automatically retried; reconcile uncertain results first.

## Coverage and validation

Fern generates 37 public operations across workspaces, scopes, contexts, releases, context sets, webhooks, billing, privacy and health. The existing TypeScript convenience API and CLI retain their bounded core workflow. There is no MCP server, credential issuer or agent execution engine. See [SDK generation and coverage](docs/sdk-generation.md) for schema limitations and the excluded provider callback.

```sh
npm ci
npm run sdk:check
npm test
npm run sdk:test:python
npm run sdk:test:go
npm run validate
npm run test:package
npm pack --dry-run
```

Validation checks documentation links, catalog targets and packaged discovery resources. Tests exercise SDK/CLI behavior and runnable examples with controlled transports; they do not prove hosted authorization, publication, or directory acceptance. [Maintainer guide](docs/maintaining.md).

## Integration coverage

Fern generates **TypeScript, Python (sync/async), Go, Rust, Ruby and Swift** clients for all 37 public operations. Each has a source-install guide, method reference and verified-file helper. [Choose an SDK](sdk/README.md).

Claude, Codex, Cursor, Pi, OpenCode, OpenClaw, Hermes and Agent Plugins clients consume one canonical skill through shared packaging. [Install for your harness](docs/installation.md), run `agenttrunk doctor`, then connect the authorized runtime.

The [workflow cookbook](examples/workflows/README.md) includes 14 paired TypeScript/Python recipes. The CLI exposes every generated SDK operation with local previews. [Release and hosted readiness](docs/readiness.md) records what local checks establish and what requires provider or registry acceptance.
# Human-approved agent signup and sign-in

Run `agenttrunk auth discover`, then `agenttrunk auth start --email HUMAN_EMAIL`.
Give the verification link to the human; after approval, use `auth complete`
with their code on stdin. Then list workspaces and select the intended one.
`auth refresh` rotates credentials explicitly. Read [setup](docs/setup.md) for
local credential storage, cloud secret managers and deployment prerequisites.
The exported `AgentRegistration` helper supports the same flow without CLI storage.
