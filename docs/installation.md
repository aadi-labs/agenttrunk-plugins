# Install AgentTrunk for people and agents

Use one integration surface appropriate to the task. Installing instructions does not install executable tools, and installing tools does not grant API access.

## Source SDK and CLI

Node.js 22+ and npm are required; source builds need Git. From a clone of `aadi-labs/agenttrunk-plugins`, run `npm ci` and `npm run build`. Run `node dist/cli/index.js --help` without credentials. `npm install -g .` makes the `agenttrunk` command available globally when that installation scope is intended.

For a separate application:

```sh
# In the cloned client repository:
npm pack
# In your application, replace this with the actual tarball path:
npm install /absolute/path/to/agenttrunk-sdk-0.1.0.tgz
```

Import `{ AgentTrunk, AgentTrunkError }` from `@agenttrunk/sdk`. The package is ESM and ships declarations. Do not assume an npm registry release exists; source tarballs work before publication.

## Portable Agent Skill

From the clone:

```sh
npx skills add . --list
npx skills add . --skill agenttrunk
```

The canonical skill is [agenttrunk](../plugins/agenttrunk/skills/agenttrunk/SKILL.md). Copy the **whole skill directory**, including `references/` and `agents/`, if your harness uses manual installation. Use the harness's configured skill directory, check for an existing installation, and preserve local edits. Start a new task or reload skills as your harness requires.

Once the GitHub changes are available, use:

```sh
npx skills add aadi-labs/agenttrunk-plugins --list
npx skills add aadi-labs/agenttrunk-plugins --skill agenttrunk
```

A successful direct install does not establish search indexing in skills.sh or any marketplace. The skill supports terminal and SDK workflows; it does not pretend an MCP tool exists.

## Claude Code

Local checkout:

```sh
claude --plugin-dir ./plugins/agenttrunk
```

Remote marketplace, after publishing the repository changes:

```text
/plugin marketplace add aadi-labs/agenttrunk-plugins
/plugin install agenttrunk@agenttrunk-plugins
```

The marketplace points to `plugins/agenttrunk`, whose manifest loads `./skills/`. Install the CLI separately if the agent will use terminal commands.

## Codex

The packaged manifest is [plugins/agenttrunk/.codex-plugin/plugin.json](../plugins/agenttrunk/.codex-plugin/plugin.json). A repository marketplace manifest is provided at `.agents/plugins/marketplace.json`. Add this repository through the Codex marketplace installer, then select AgentTrunk. The checkout has not been registered in your installed marketplaces by this change. Portable skill installation remains available.

## Python and Go

Install Python from source with `python -m pip install ./sdk/python` (Python 3.10+), or use uv for an isolated run. Go 1.21+ consumers can use a local module replacement pointing at `sdk/go` before a remote module release. Follow the [Python guide](../sdk/python/README.md), [Go guide](../sdk/go/README.md), and [multi-language examples](../examples/clients/README.md). TypeScript continues to install the root npm tarball. None of these installation paths implies a registry release.

## Native harness packages

The root portable `plugin.json` and deterministic `skills/` export expose the same canonical skill used by Claude and Codex. `npm run skills:check` detects drift; edit only `plugins/agenttrunk/skills/agenttrunk/`. Local installation proves discovery only; remote marketplaces must separately index or approve the repository.

| Harness | Source installation | What loads |
| --- | --- | --- |
| Cursor | Link this checkout to `~/.cursor/plugins/local/agenttrunk`, reload, inspect Customize | `.cursor-plugin/plugin.json` and the shared skill |
| Pi | `pi install /absolute/path/to/agenttrunk-plugins` | `package.json#pi.skills` |
| OpenCode | `npx skills add . --skill agenttrunk --agent opencode` | Portable Agent Skills |
| OpenClaw | `openclaw plugins install --link /absolute/path/to/agenttrunk-plugins` then `openclaw plugins enable agenttrunk` | Native manifest, runtime entry and shared skill |
| Hermes | Link/copy the checkout to `~/.hermes/plugins/agenttrunk`, then `hermes plugins enable agenttrunk` | Native `plugin.yaml` and Python skill registration |
| Agent Plugins 1.0 clients | Add this checkout using the client's plugin installer | Root `plugin.json` and `skills/` |

Check existing installation paths before linking or copying. Preserve user edits. Harnesses may require a restart or a new task. The SDK/CLI supplies executable operations; these packages do not register an MCP server or intercept agent events.

These adapters follow [Agent Plugins](https://agent-plugins.org/specification) and the [OpenClaw manifest](https://docs.openclaw.ai/plugins/manifest). Native loading tests use the declared registration interfaces; installed-client acceptance is tracked separately in [readiness](readiness.md).

## Rust, Ruby and Swift

Use the [Rust](../sdk/rust/README.md), [Ruby](../sdk/ruby/README.md) and [Swift](../sdk/swift/README.md) source-install guides. All six SDKs derive from the same contract. Package names and module paths are release targets, not claims of registry availability.

Reference install contracts: [Cursor local plugins](https://cursor.com/docs/plugins), [Pi packages](https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/packages.md), and [Hermes plugins](https://hermes-agent.nousresearch.com/docs/user-guide/features/plugins/). After repository publication, Hermes can install `aadi-labs/agenttrunk-plugins` pinned to a full commit SHA with `--ref`.
