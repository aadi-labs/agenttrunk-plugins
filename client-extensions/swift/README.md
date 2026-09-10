# AgentTrunk Swift SDK

## Agent sign-up and sign-in

Native Agent Registration helpers support discovery, human approval, token
exchange, and explicit identity refresh. See the [six-language authentication
guide](https://github.com/aadi-labs/agenttrunk-plugins/blob/main/docs/native-agent-auth.md)
for imports, method names, and secret handling.
Use the [skill sync CLI](https://github.com/aadi-labs/agenttrunk-plugins/blob/main/docs/skill-sync.md)
alongside any SDK for managed folders; it does not execute skills or release them.

## Incremental context edits

Authenticate and select an authorized workspace/context. Inspect staging and use
its immutable revision ID as the expected base. This example uses the generated
Swift client.

```swift
let updated = try await client.contexts.edit(
    trunkId: workspaceId, contextKey: contextKey,
    request: .init(
        expectedRevisionId: stagingRevisionId,
        changes: [
            .put(.init(path: "prompts/system.md", contentBase64: "IyBTdXBwb3J0Cg==")),
            .delete(.init(path: "obsolete.md"))
        ]
    )
)
```

The example adds/replaces one file and deletes an existing file. Omit the delete
if that file does not exist. Untouched files and metadata remain unchanged.
Changes apply together to staging, never production. The complete result must
contain 1–256 files, at most 1 MB per file and 16 MB total. Paths must be unique
and relative. On 409, reread and reconcile; do not blindly update the expected
revision and retry. Identical current bytes are a no-op; historical bytes use
rollback. Inspect staging/history after an uncertain write before trying again.


Fern-generated coverage of all 38 public API operations. Requires Swift 6+ on Apple platforms. Install from source until an explicit registry/module release is available.

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
