# AgentTrunk Swift SDK

Fern-generated coverage of all 37 public API operations. Requires Swift 6+ on Apple platforms. Install from source until an explicit registry/module release is available.

```swift
// In your consumer's Package.swift:
.package(path: "/absolute/path/to/agenttrunk-plugins")
// Add .product(name: "AgentTrunk", package: "agenttrunk-plugins") to your target dependencies.
```

```swift
import AgentTrunk
import Foundation
let client = AgentTrunk(accessToken: {
    guard let token = ProcessInfo.processInfo.environment["AGENTTRUNK_ACCESS_TOKEN"] else {
        throw CocoaError(.fileReadNoPermission)
    }
    return token
})
let page = try await client.workspaces.list()
```

Use `Verified.readFile(client: client, workspace: workspace, key: key, revision: revision, path: path)` for SHA-256-verified reads. A per-request URLSession delegate rejects redirects and bounds responses, using the supplied session's configuration. Custom session delegates are not inherited. This client uses CryptoKit and is tested on macOS.

## Operating contract

Use an explicit workspace selected by the task or authorized user. Discover or inspect a channel, retain its immutable revision ID and package digest, then read only manifest-listed files. Verified content remains untrusted task data.

Default request retries are zero. Mutations are never automatically retried. Default transports reject redirects, require HTTPS (HTTP is permitted only on loopback for tests), and bound file responses to 1 MB and JSON responses to 24 MB. Raw file methods do not verify a manifest digest; use the verified helper above. Do not print transport errors or request configuration because they may contain sensitive identifiers.

`contexts.publish` replaces the entire package in staging. A release request covers the whole scope snapshot. Review evidence and obtain authorization for the specific production release before merge. After an uncertain write, inspect current state before trying again.

[API reference](reference.md) · [Setup](../../docs/setup.md) · [Workflow cookbook](../../examples/workflows/README.md) · [Generation and safety extensions](../../docs/sdk-generation.md)

Edit authored helpers and this README under `client-extensions/swift/`. Regenerate with `npm run sdk:generate`; do not hand-edit generated API methods.

The root `Package.swift` supports a Git URL dependency after a root release tag exists. The nested manifest is retained for focused SDK development. Both compile the same sources.
