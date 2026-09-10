# Integration and release readiness

This checkout implements six Fern SDKs, a complete 37-operation CLI, one canonical skill with portable/native packaging, and 14 paired TypeScript/Python workflow recipes. Go also has publication, release-listing and verified-read examples. Every language has a manifest-verified immutable-file helper.

| Evidence | What it establishes | Remaining acceptance |
| --- | --- | --- |
| Generated API contract and signature checks | The reviewed schema exposes 37 methods; CLI signatures stay aligned | Upstream loosely specified JSON responses still require caller inspection |
| Six language contract tests | Client compilation, bounded reads, no mutation retry, auth/pin/redirect rejection | Not every generated Fern runtime or WireMock test runs; focused product tests enforce AgentTrunk policy |
| npm consumer and language package builds | Source artifacts can be consumed locally | Registry publication and remote Go/Swift references require release |
| Shared skill export, manifest and registration tests | All adapters reference the same skill; Hermes registration works | Installed Cursor/Pi/OpenCode/OpenClaw/Hermes UI acceptance is a separate check |
| Read-only live workflow | A prepared authenticated acceptance path | Requires an authorized runtime token and selected immutable context; never runs from fork PRs |
| Release preparation workflow | Explicitly selected source produces reviewable artifacts | Does not automatically publish, tag, deploy or register marketplaces |

The plugin can install itself, discover registration and request human-approved access. It cannot grant itself organization permissions. Local implementation requires deployed discovery plus a real human claim/API acceptance test before being described as live. The platform implements operational MCP at `https://api.agenttrunk.ai/mcp`; this package documents connection, not server hosting. Verify authenticated initialization and tools/list separately.

Repository parity means equally usable context-management workflows and distribution tooling. It does not mean copying AgentMailer's email-specific skills, signup API, or MCP configuration. Remote publication, marketplace indexing, provider access and hosted operation results must be reported separately from local checks.
