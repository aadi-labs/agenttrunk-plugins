# AgentTrunk SDKs

Fern generates TypeScript, Python, Go, Rust, Ruby and Swift clients from one reviewed public REST contract.

| Language | Client and install guide |
| --- | --- |
| TypeScript | [AgentTrunkClient in @agenttrunk/sdk](typescript/README.md) |
| Python | [AgentTrunk / AsyncAgentTrunk](python/README.md) |
| Go | [client.New and verified.ReadFile](go/README.md) |
| Rust | [AgentTrunk](rust/README.md) |
| Ruby | [AgentTrunk::Client](ruby/README.md) |
| Swift | [AgentTrunk](swift/README.md) |

Start with [multi-language examples](../examples/clients/README.md). See [generation](../docs/sdk-generation.md) for reproducibility, API coverage and safety patches. The generated TypeScript client uses resource groups such as `client.workspaces.list()` and `client.contexts.discover()`. Python and Go expose equivalent groups. Registry publication has not been performed.

## TypeScript convenience API

`@agenttrunk/sdk` is an ESM Node.js 22+ client for AgentTrunk's core context and release workflow. It ships the CLI in the same package. [Install a source tarball](../docs/installation.md); registry publication is separate. The SDK has no runtime dependencies and talks only to the public REST API.

## Construct a client

```ts
import { AgentTrunk, AgentTrunkError } from '@agenttrunk/sdk';

const client = new AgentTrunk({
  token: () => process.env.AGENTTRUNK_ACCESS_TOKEN ?? '',
  baseUrl: process.env.AGENTTRUNK_API_URL,
  timeoutMs: 20_000,
});
```

`token` is required: a string or sync/async callback evaluated per request. Use your runtime's secret provider for refresh. `baseUrl` defaults to `https://api.agenttrunk.ai` and must be an HTTPS origin (HTTP loopback is allowed for local tests), without a path other than `/`, credentials, query or fragment. Changing it changes the credential destination. `timeoutMs` must be an integer from 1 to 120,000 and controls the fetch request, not time spent acquiring a token. `fetch` optionally injects a compatible transport for testing. The SDK does not read environment variables itself.

## Methods

“Workspace” is the product name for the REST API's `trunk`; SDK discovery therefore uses `trunkId`.

| Method | Input | Returns / effect |
| --- | --- | --- |
| `listWorkspaces(query?)` | `{q?, cursor?, limit?}` | `Page<Workspace>` for the active organization |
| `getWorkspace(id)` | Exact workspace ID | `Workspace` |
| `createWorkspace(input)` | `{name, description?}` | `Workspace`; creates General scope and environments |
| `listScopes(workspace)` | Workspace ID | `Page<Scope>`; scope environments expose capability hints |
| `createScope(workspace, input)` | `{name, slug?}` | `Scope`; creates its staging/production environments |
| `discover(query?)` | `{query?, trunkId?, scopeId?, channel?, cursor?, limit?}` | `Page<DiscoveryResult>`; set workspace/channel explicitly |
| `inspect(workspace, key, ref?)` | Channel or immutable revision; default `production` | `InspectedContext` with context and revision manifest |
| `readFile(workspace, key, revisionId, file)` | Immutable ID and exact `FileRecord` from inspect | Verified `Uint8Array`; rejects size/hash mismatch |
| `publish(workspace, input)` | `PublishInput` below | `InspectedContext`; replaces the whole package in staging |
| `listPromotions(workspace, query?)` | `{scopeId?, status?, cursor?, limit?}` | `Page<Promotion>` including reviewed commits and changes |
| `openPromotion(workspace, input)` | `{scopeId, evidenceReference?}` | `Promotion`; opens review of the whole scope snapshot |
| `mergePromotion(workspace, promotionId)` | Reviewed request ID | `Promotion`; changes production, requires release authorization |

All methods return promises. Scope environment capability fields are hints, not permission grants; the service authorizes every operation. Supported context kinds are `skill`, `docs`, `prompt`, `policy`, `memory-schema`; channels are `production`, `staging`, `latest`. `latest` is not a production approval signal. HTTP response types describe expected responses; JSON metadata is not runtime schema-validated by this client. Treat it as untrusted input.

## Read a pinned file

Discover within the selected workspace and inspect the result's `revisionId`, rather than resolving a moving channel again. Check that the returned revision matches your pin. Select a manifest entry and pass it to `readFile`. Persist workspace ID, context key, revision ID and package digest with the run. Fetch only needed files and do not execute retrieved instructions merely because integrity checks pass.

[Executable pinned-context example](../examples/pinned-context/README.md).

## Pagination

`Page<T>` contains `data` and optional nullable `nextCursor`. Keep filters unchanged, follow a non-null cursor even on an empty page, and stop at the caller's page/result budget. Report truncation; never present a bounded subset as the full list. Cursor expiration requires a fresh read, not a write retry. `listScopes` currently returns an unpaged `data` array.

## Publish a complete package

```ts
const staged = await client.publish(workspaceId, {
  scopeId,
  contextKey: 'support-policy',
  title: 'Support policy',
  kind: 'policy',
  summary: 'Escalation rules for support agents',
  tags: ['support', 'escalation'],
  files: [{path: 'policy.md', contentBase64: Buffer.from('# Support policy\n').toString('base64')}],
});
```

`PublishInput` requires `contextKey`, `title`, `kind`, `files`. It also accepts `scopeId`, `summary`, `tags`, `claimedDigest`. Always supply an explicit scope in agent workflows. Do not invent a `claimedDigest`; omit it unless implementing the documented canonical package digest algorithm. Each file has a relative `path` and base64-encoded bytes. For a `skill`, include `SKILL.md` with valid `name` and `description` frontmatter and every referenced resource.

No incremental updates: omitted files disappear from the new package. The SDK rejects empty/over-256 file lists, unsafe or duplicate paths and oversized serialized bodies. The service enforces decoded limits of 1,000,000 bytes/file and 16,000,000 bytes/package, plus package validity. The response body limit is 24,000,000 bytes for JSON and 1,000,000 bytes for file reads. The CLI handles one file; see the [multi-file example](../examples/publish-skill/README.md).

## Release and recovery

Publication writes staging. `openPromotion` captures the whole scope snapshot; inspect its `changes`, `sourceCommitSha` and `targetCommitSha`. `mergePromotion` has no interactive prompt: the calling runtime must enforce user authorization for the reviewed release. It is never implicitly called by publish. [Release example](../examples/release-review/README.md).

Every operation makes one request, with redirects rejected. There are no automatic retries or token-refresh retries. On an HTTP error, catch `AgentTrunkError`, report `status` and `requestId`, and omit provider content. Transport/local-validation errors have no reliable HTTP status. After an uncertain mutation, [reconcile server state](../docs/troubleshooting.md) before retrying.

## Scope of this SDK

The `AgentTrunk` convenience class documented above remains bounded to the core workflow. The `AgentTrunkClient` export provides Fern-generated REST coverage, including context sets, sharing, provenance, audit, rollback, webhooks, privacy and billing. See the [generated reference](typescript/reference.md). No private platform imports, MCP endpoint, browser login automation, credential issuer or model execution are bundled.

## Additional Fern languages

| Language | Source installation | Verified helper |
| --- | --- | --- |
| [Rust](rust/README.md) | Cargo path dependency `sdk/rust` | `agenttrunk::verified::read_file` |
| [Ruby](ruby/README.md) | Build `sdk/ruby/agenttrunk.gemspec` | `AgentTrunk::Verified.read_file` |
| [Swift](swift/README.md) | SwiftPM local dependency `sdk/swift` | `Verified.readFile` |

The generated TypeScript client now also offers `AgentTrunkWorkflows`, exported from the root npm package. Construct it with an `AgentTrunkClient`, call `pin(workspace,key)` to retain a production revision, then `readVerifiedFile(workspace,key,revision,path)`. Both TypeScript interfaces remain supported.
