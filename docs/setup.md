# Set up an agent's AgentTrunk access

An agent can discover AgentTrunk, request human-approved registration, and use context for that human. Run `agenttrunk auth discover`, `agenttrunk auth start --email HUMAN_EMAIL`, and after the human returns their approval code, `agenttrunk auth complete` (code on stdin). Reuse existing authorization; no anonymous access or independent organization grants.

The CLI stores identity assertions and refresh credentials in `~/.agenttrunk/credentials.json`, mode 0600, inside an owner-only 0700 directory. This is not encrypted storage. Use an isolated OS user or the SDK's `AgentRegistration` with your runtime secret manager for cloud agents. Access tokens are exchanged in memory for API commands. `auth refresh` explicitly rotates the stored identity; no credential mutation is automatically retried. Hosted discovery, human approval and workspace access must each be verified after deployment.

For an expired or abandoned pending claim, `auth cancel` clears only local pending state; it does not revoke a completed registration. Then start a fresh claim deliberately. A crash may leave `credentials.lock`: confirm no auth process is running before removing that exact lock. Never delete it while a claim completion or refresh is in flight. Provider revocation is managed separately.

## 1. Check the local client

Run `node --version` (22+) and `node dist/cli/index.js --help` from a built clone. If missing, follow [installation](installation.md). An agent may complete this local setup within the requested installation scope without waiting for credentials.

## 2. Supply authorization

Use [AgentTrunk signup](https://agenttrunk.ai/signup) for first-time human account and organization onboarding. External agents use the registration commands above. First-party backends use server-side delegated Blueprint sessions. Never ask a human for provider administrator credentials.

The token must target the AgentTrunk API and active organization. For delegated access, preserve the authorizing user and the agent's permission ceiling. A shared admin credential is not a delegation mechanism. The runtime owns token refresh and secret persistence; the SDK evaluates its token callback for every request.

| Setting | Used by | Meaning |
| --- | --- | --- |
| `AGENTTRUNK_ACCESS_TOKEN` | CLI and examples | Short-lived token injected by a secret manager; never print it |
| `AGENTTRUNK_API_URL` | CLI and examples | Optional trusted API origin; default `https://api.agenttrunk.ai` |
| `AGENTTRUNK_WORKSPACE_ID` | Examples | Workspace chosen for this task; no implicit first-workspace selection |
| `AGENTTRUNK_SCOPE_ID` | Publishing/release examples | Scope inside that workspace |
| `AGENTTRUNK_CONTEXT_KEY` | Context examples | Explicit package key |

The TypeScript convenience client takes `token`, `baseUrl`, `timeoutMs` and optional `fetch`. The generated TypeScript client uses `accessToken`, Python uses `access_token`, and Go uses `option.WithAccessToken` or `option.WithAccessTokenFunc`. See the [language guides](../sdk/README.md) for exact environment and callback behavior. None automatically loads `.env` files. Pass a token callback from your runtime secret provider for refreshable credentials. Keep tokens out of browser bundles.

If a token is unavailable, finish local checks and report: “Client installed; API access needs an organization-authorized AgentTrunk token injected into the runtime.” This is an access handoff, not an invitation to extract browser cookies or mint a fake token.

## 3. Verify the selected workspace

```sh
node dist/cli/index.js workspaces
node dist/cli/index.js scopes --workspace WORKSPACE_ID
node dist/cli/index.js discover --workspace WORKSPACE_ID --channel production
```

Follow `nextCursor` on paged results even when `data` is empty. Select using user intent and exact IDs. An inaccessible workspace or a 401/403 response is not evidence that no workspaces exist. Do not create a replacement tenant to work around an access failure.

Workspace creation is an explicit mutation: `workspace-create --name NAME` creates the workspace with a General scope and staging/production environments. Reuse that scope unless the task calls for another; `scope-create --workspace ID --name NAME` creates a separate scope. Use server-returned IDs.

The [quickstart](../examples/quickstart/README.md) performs a read-only connection check and reports IDs and counts without context bodies or tokens. Read permission does not establish deploy/publish permission. Check those separately when the task requires writes.

## 4. Use the right workflow

- [Retrieve pinned context](../examples/pinned-context/README.md) for reproducible agent runs.
- [Publish a complete skill](../examples/publish-skill/README.md) to staging.
- [Review releases](../examples/release-review/README.md) before separately authorized production changes.

Report local installation, API read success, staging publication and production release as separate outcomes. [Troubleshooting](troubleshooting.md) covers failures.

## Agent-run setup checklist

1. Install the skill and SDK/CLI into the intended project or harness.
2. Run `agenttrunk doctor`. This local diagnostic prints only configuration presence and next steps.
3. If credentials are absent, use `auth start` and the human approval ceremony, or have the authorized runtime provide a short-lived organization-scoped bearer token through its secret store.
4. Run `agenttrunk workspaces`. A successful empty list differs from 401/403. Select the intended workspace explicitly; list its scopes before writing.
5. Run a read-only cookbook example or inspect a known context. Retain the immutable revision ID and package digest for each agent run.

A useful handoff is the verification link and a request for the human's approval code, never a token. Signup and organization access remain at https://agenttrunk.ai/signup. A successful registration does not establish workspace access, staging publication or release permission; check those separately.
