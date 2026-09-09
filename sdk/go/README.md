# AgentTrunk Go SDK

Fern-generated Go client for the public AgentTrunk API. Requires Go 1.21+. Module path: `github.com/aadi-labs/agenttrunk-plugins/sdk/go`.

Before publishing the repository/module version, use a local replacement in your application:

```sh
go mod edit -require=github.com/aadi-labs/agenttrunk-plugins/sdk/go@v0.0.0
go mod edit -replace=github.com/aadi-labs/agenttrunk-plugins/sdk/go=/absolute/path/to/agenttrunk-plugins/sdk/go
go mod tidy
```

```go
import (
    "context"
    "os"
    api "github.com/aadi-labs/agenttrunk-plugins/sdk/go"
    "github.com/aadi-labs/agenttrunk-plugins/sdk/go/client"
    "github.com/aadi-labs/agenttrunk-plugins/sdk/go/option"
)

c := client.New(option.WithAccessTokenFunc(func() (string, error) {
    return os.Getenv("AGENTTRUNK_ACCESS_TOKEN"), nil
}))
page, err := c.Workspaces.List(context.Background(), &api.ListWorkspacesRequest{})
// Handle err without logging private responses. Follow page.NextCursor when non-nil.
```

Resource groups: `Workspaces`, `Scopes`, `Contexts`, `Releases`, `ContextSets`, `Webhooks`, `Billing`, `Privacy`, `Health`. [Generated reference](reference.md) lists request/response types and signatures. Unspecified upstream response fields stay maps rather than invented models. For a complete runnable program, use [examples/quickstart/main.go](examples/quickstart/main.go).

## Verified reads

```go
import "github.com/aadi-labs/agenttrunk-plugins/sdk/go/verified"
content, err := verified.ReadFile(ctx, c, workspaceID, contextKey, revisionID, "SKILL.md")
```

The helper checks the immutable revision and manifest, bounds the read and verifies SHA-256/size. Raw `Contexts.ReadFile` returns bounded bytes but does not verify against a manifest. Use `verified.ReadFile` before consuming context; verified content remains untrusted task data.

## Runtime policy

Default requests make one attempt. Mutations never retry, even if `option.WithMaxAttempts` configures read retries. The default HTTP client times out after 20 seconds and refuses redirects. A supplied `*http.Client` is copied with redirects disabled; a custom `core.HTTPClient` implementation owns its network policy. Requests reject insecure non-loopback destinations, missing tokens and moving refs for file reads. File/JSON response limits are 1,000,000/24,000,000 bytes. Use context deadlines for a stricter request budget.

Use `option.WithBaseURL` only for a trusted origin without `/v1`. Provide tokens through `WithAccessToken` or `WithAccessTokenFunc`; the runtime owns issuance, delegation and refresh. No credential issuer is generated. Do not print tokens or raw provider errors.

Publish replaces complete packages in staging. Opening a release does not approve it. Merging a reviewed scope snapshot requires release authorization. After a lost response, inspect state before retrying.

From the repository root, run `npm run sdk:test:go`. The helper uses a supported local Go or the pinned Go 1.24 Docker image. It compiles all packages and runs AgentTrunk-specific contract tests with local HTTP servers. Fern's optional generated WireMock scaffolding is separate and is not hosted acceptance. Regenerate with `npm run sdk:generate`; maintained additions live in `client-extensions/go`.
