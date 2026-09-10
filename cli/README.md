# AgentTrunk CLI

Use `skills pull`, `skills status`, and `skills push` for verified local context
folders. Pull/push preview unless `--execute --yes` is supplied; pushes update
staging, not production. See [skill sync](../docs/skill-sync.md).
`auth logout --yes` clears local CLI credentials without revoking remote grants.

For partial changes, preview with `agenttrunk api contexts.edit --input edit.json`,
then add `--execute --yes` when authorized. Input contains `trunkId`, `contextKey`,
and `request: {expectedRevisionId, changes}`. Inspect staging for the expected
revision. Changes use `{operation: "put", path, contentBase64}` or
`{operation: "delete", path}`; omitted files stay intact. Reconcile conflicts.
See the [edit example](../examples/workflows/edit-context/README.md).

Build the repository and use `node dist/cli/index.js` from its root, or install with `npm install -g .` to use `agenttrunk`. Requires Node.js 22+. `--help` needs no credentials.

The CLI prefers runtime-injected `AGENTTRUNK_ACCESS_TOKEN` and optional `AGENTTRUNK_API_URL`. Otherwise it exchanges a token from its human-approved local registration. It does not load `.env` or print credentials. See [setup](../docs/setup.md) for registration and explicit refresh.

| Command | Required flags | Optional flags |
| --- | --- | --- |
| `workspaces` | none | `--cursor` |
| `workspace-create` | `--name` | none |
| `scopes` | `--workspace` | none |
| `scope-create` | `--workspace`, `--name` | `--slug` |
| `discover` | none; pass `--workspace` for task scope | `--query`, `--workspace`, `--scope`, `--channel`, `--cursor` |
| `inspect` | `--workspace`, `--key` | `--ref` |
| `read` | `--workspace`, `--key`, `--ref`, `--path` | none |
| `upload` | `--workspace`, `--scope`, `--key`, `--title`, `--kind`, `--file`, `--path` | none |
| `releases` | `--workspace` | `--scope`, `--status`, `--cursor` |
| `release-request` | `--workspace`, `--scope` | `--evidence` |
| `release-merge` | `--workspace`, `--promotion`, `--yes` | none |

`discover --channel` defaults to `production`; values are `production`, `staging`, `latest`. `inspect --ref` defaults to `production` and also accepts an immutable revision. `read --ref` requires a 64-character lowercase hexadecimal revision ID, never a moving channel. `releases --status` accepts `open`, `merged`, `closed`. `upload --kind` accepts `skill`, `docs`, `prompt`, `policy`, `memory-schema`.

JSON goes to stdout, except `read`, which writes verified raw bytes. Errors go to stderr as JSON and exit with status 1. Never pipe raw file content into a shell. Unknown commands/options fail. Tokens in arguments are unsupported. Errors intentionally omit provider response bodies and sensitive argument details.

`upload` accepts one explicit regular file no larger than 1,000,000 bytes, rejecting final-path symlinks and unsafe resource paths. It replaces a complete package in staging; use the [SDK example](../examples/publish-skill/README.md) for multiple files. `--file` is a local path; `--path` is the relative path inside the package.

`release-request` captures the entire scope snapshot. `release-merge --yes` acknowledges a production change after review; the flag is not a substitute for user or service authorization. No mutation is retried automatically. [Recovery steps](../docs/troubleshooting.md).

See the [shell walkthrough](../examples/cli/README.md) for a read-first workflow and [example catalog](../examples/README.md) for applications.

## Complete API surface and local setup checks

`agenttrunk doctor` reports whether a runtime token is configured without reading or printing its value. It performs no network requests.

The CLI's operation catalog and argument order are generated from the reviewed OpenAPI and Fern TypeScript signatures. All 37 operations are available through the generated SDK:

```sh
agenttrunk api list
agenttrunk api contexts.getRollbackPlan --help
agenttrunk api contexts.getRollbackPlan --input rollback.json
agenttrunk api contexts.getRollbackPlan --input rollback.json --execute
```

`rollback.json` contains SDK parameter names, with body/query fields nested under `request`:

```json
{"trunkId":"selected-workspace","contextKey":"support","request":{"revisionId":"immutable-64-hex-revision"}}
```

Replace sample identifiers with real task-selected values. `--help` shows the path, parameter requirements, and body/query schema. No request is sent by default. Preview lists parameter names and omits values, tokens and file content. `--execute` enables a request; writes additionally require `--yes` after reviewing the input and the user's authorization. No automatic write retry occurs. The `contexts.readFile` command emits verified bytes; JSON operations emit JSON. Complete schemas are available in `fern/openapi/openapi.json` in the source checkout.

The familiar short commands remain supported. This API catalog uses Fern-generated clients instead of a second Rust CLI binary, so npm consumers retain the same executable and safety policy. Run `npm run cli:generate` after SDK regeneration; `npm run cli:check` detects drift.
## Human-approved authentication

`auth discover` prints public registration metadata. `auth start --email EMAIL`
starts or resumes a claim and prints only its human verification link. After
approval, `auth complete` accepts the human code on stdin. `auth refresh` rotates
the stored identity explicitly; `auth cancel` clears an abandoned local pending
claim. API commands exchange an access token in memory from stored authorization
when no `AGENTTRUNK_ACCESS_TOKEN` is injected. See [setup](../docs/setup.md) for
owner-only, unencrypted local storage and cloud secret-manager guidance.
