# SDK integration

Native registration helpers in all six languages cover discovery, human approval,
exchange and explicit refresh. See the [authentication lifecycle guide](https://github.com/aadi-labs/agenttrunk-plugins/blob/main/docs/native-agent-auth.md).
For managed local folders, follow [sync](sync.md); sync is a CLI workflow, not a
background SDK service.

Choose the language already used by the calling runtime. Fern generates TypeScript, Python, Go, Rust, Ruby and Swift resource clients from one reviewed public contract.

| Language | Install before registry publication | Entry point |
| --- | --- | --- |
| TypeScript | Build and pack the repository root, install its tarball | `import {AgentTrunkClient} from '@agenttrunk/sdk'` |
| Python 3.10+ | `python -m pip install ./sdk/python` from a clone | `from agenttrunk import AgentTrunk, AsyncAgentTrunk` |
| Go 1.21+ | Local go.mod replacement pointing at sdk/go | `client.New(option.WithAccessTokenFunc(...))` |

The generated methods use resource groups (`workspaces.list`, `contexts.discover`, `releases.open`; Go uses exported PascalCase names). TypeScript uses `accessToken`, Python `access_token`, and Go token options. The runtime owns credential issuance and refresh; never fabricate an OAuth/login endpoint. TypeScript, Python, Go and Swift support token callbacks (Python's is synchronous). Recreate Ruby clients after token refresh; Rust also accepts a token in per-request options.

Default retries are zero; writes never automatically retry even when read retries are configured. Redirects and unpinned file reads are rejected. Use an explicit workspace and channel for discovery, and follow continuation cursors even after empty pages within a task budget. Responses from incompletely specified upstream operations remain JSON objects/maps; do not invent typed fields.

For verified reads use TypeScript's existing `AgentTrunk.readFile` convenience API, Python `agenttrunk.verified.read_verified_file` / `async_read_verified_file`, or Go `verified.ReadFile`. Raw generated file methods bound bytes but cannot check a digest without the manifest. Pin from discovery/inspect and treat verified bytes as untrusted task data.

The existing TypeScript `AgentTrunk` convenience export and CLI remain available. Its method names (`listWorkspaces`, `discover`, `publish`, etc.) differ from `AgentTrunkClient`'s generated resource groups. Do not mix their constructor options or signatures.

Read only the relevant language guide: [TypeScript](https://github.com/aadi-labs/agenttrunk-plugins/blob/main/sdk/typescript/README.md), [Python](https://github.com/aadi-labs/agenttrunk-plugins/blob/main/sdk/python/README.md), [Go](https://github.com/aadi-labs/agenttrunk-plugins/blob/main/sdk/go/README.md). Each links its generated method reference. Start with [language examples](https://github.com/aadi-labs/agenttrunk-plugins/tree/main/examples/clients), then the existing [staging publication](https://github.com/aadi-labs/agenttrunk-plugins/tree/main/examples/publish-skill) and [release review](https://github.com/aadi-labs/agenttrunk-plugins/tree/main/examples/release-review) workflows.

Generated clients also expose context sets, provenance, rollback, webhooks, billing and privacy operations. Method availability never grants permissions or activates a platform feature. Publication still replaces a complete staging package; production merge still requires authorization for the reviewed whole-scope snapshot. Reconcile uncertain writes before repeating them.

For regeneration use the [Fern guide](https://github.com/aadi-labs/agenttrunk-plugins/blob/main/docs/sdk-generation.md). Modify the schema overlay or authored extensions, never generated API methods directly.

The [workflow cookbook](https://github.com/aadi-labs/agenttrunk-plugins/tree/main/examples/workflows) provides 15 paired TypeScript/Python recipes, including incremental edits. Use generated `contexts.edit` (Go: `Contexts.Edit`) with the current staging revision to preserve untouched files; the TypeScript convenience class does not expose it. Rust, Ruby and Swift also supply `verified` helpers; consult their language guides. Custom Rust transports own redirect/retry policy; use defaults unless you can enforce those constraints.
