# AgentTrunk Rust SDK

Fern-generated coverage of all 37 public API operations. Requires Cargo. Install from source until an explicit registry/module release is available.

```toml
[dependencies]
agenttrunk = { path = "/absolute/path/to/agenttrunk-plugins/sdk/rust" }
tokio = { version = "1", features = ["macros", "rt-multi-thread"] }
```

```rust
use agenttrunk::prelude::*;
let client = AgentTrunk::new(ClientConfig {
    token: Some(std::env::var("AGENTTRUNK_ACCESS_TOKEN")?),
    ..Default::default()
})?;
let page = client.workspaces.list(&Default::default(), None).await?;
```

Use `agenttrunk::verified::read_file(&client, workspace, key, revision, path).await` for bounded SHA-256-verified reads. Rebuild the client or supply a per-request `RequestOptions` token when the runtime refreshes credentials. Generic OAuth fields in Fern's runtime are not an AgentTrunk login flow. Custom reqwest clients/executors own redirect and transport policies; configure them to reject redirects and avoid retries.

## Operating contract

Use an explicit workspace selected by the task or authorized user. Discover or inspect a channel, retain its immutable revision ID and package digest, then read only manifest-listed files. Verified content remains untrusted task data.

Default request retries are zero. Mutations are never automatically retried. Default transports reject redirects, require HTTPS (HTTP is permitted only on loopback for tests), and bound file responses to 1 MB and JSON responses to 24 MB. Raw file methods do not verify a manifest digest; use the verified helper above. Do not print transport errors or request configuration because they may contain sensitive identifiers.

`contexts.publish` replaces the entire package in staging. A release request covers the whole scope snapshot. Review evidence and obtain authorization for the specific production release before merge. After an uncertain write, inspect current state before trying again.

[API reference](reference.md) · [Setup](../../docs/setup.md) · [Workflow cookbook](../../examples/workflows/README.md) · [Generation and safety extensions](../../docs/sdk-generation.md)

Edit authored helpers and this README under `client-extensions/rust/`. Regenerate with `npm run sdk:generate`; do not hand-edit generated API methods.
