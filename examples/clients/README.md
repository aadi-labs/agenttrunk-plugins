# Fern client examples

These examples use generated SDK resource groups rather than the TypeScript convenience methods. They are read-only and require a runtime-supplied `AGENTTRUNK_ACCESS_TOKEN`. They print workspace or context metadata, never tokens or file bodies. They stop after ten pages and report partial results. No client grants itself access or creates a workspace merely because discovery returned no results.

| Language | Run from repository root | Reference |
| --- | --- | --- |
| TypeScript / Node.js 22+ | `npm run build` then `node examples/clients/typescript/quickstart.mjs` | [Source](typescript/quickstart.mjs), [SDK](../../sdk/typescript/README.md) |
| Python 3.10+ | `uv run --with ./sdk/python python examples/clients/python/quickstart.py` | [Source](python/quickstart.py), [SDK](../../sdk/python/README.md) |
| Go 1.21+ | `cd sdk/go` then `go run ./examples/quickstart` | [Source](../../sdk/go/examples/quickstart/main.go), [SDK](../../sdk/go/README.md) |

For TypeScript and Python, optionally set `AGENTTRUNK_WORKSPACE_ID` to search production context in an explicitly selected workspace. Without it, they list workspace choices. The Go quickstart lists workspaces. If an intermediate page is empty but has a cursor, all examples continue.

Use the SDK-specific verified-read helpers before adding downloaded files to an agent run. The existing [pinned context](../pinned-context/README.md), [staging publication](../publish-skill/README.md), and [release review](../release-review/README.md) examples continue to use the TypeScript convenience API. In other languages, use the generated `contexts.publish`/`Contexts.Publish` and `releases.open`/`Releases.Open` methods documented in each generated reference. Complete-package replacement, staging, reviewed-scope release authorization and reconciliation rules are identical.

## Complete workflows

The [workflow cookbook](../workflows/README.md) includes paired TypeScript and Python publication, release, audit, context-set, provenance, webhook, billing, privacy and recovery recipes. Each starts with a token-free local preview and a reviewed input file.

Python verified file read (stdout contains context bytes):

```sh
uv run --with ./sdk/python python examples/clients/python/pinned_context.py
```

Set `AGENTTRUNK_WORKSPACE_ID`, `AGENTTRUNK_CONTEXT_KEY`, `AGENTTRUNK_REVISION_ID` and `AGENTTRUNK_RESOURCE_PATH` explicitly. The runtime supplies the access token.

Go workflows, from `sdk/go`:

```sh
go run ./examples/workflow publish
go run ./examples/workflow publish --execute --yes
go run ./examples/workflow releases --execute
go run ./examples/workflow read --execute
```

The Go publication example replaces a complete two-file skill in the selected staging scope. It uses `AGENTTRUNK_SCOPE_ID` and `AGENTTRUNK_CONTEXT_KEY`; review its source first. Release listing is read-only. Rust and Ruby quickstarts are in their SDK `examples/` directories. Swift's `AgentTrunkSafetyTests` compiles and exercises its client and verified helper.
