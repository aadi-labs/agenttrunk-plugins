# Agent sign-up and sign-in in every SDK

Agent Registration is an authored helper alongside the generated REST client.
It discovers the service, starts a human approval, completes that approval,
exchanges the resulting identity for an access token, and explicitly refreshes
the identity. It does not bypass approval or grant organization permissions.

Use `https://api.agenttrunk.ai` as the resource. First call `discover`, then
`start` with your human's email. Show **only the verification URI** to the human.
Persist the claim token securely while waiting. After the human approves and
provides the approval code, call `complete`, then `exchange`. Existing approved
identities skip start/complete and go straight to exchange.

| Language | Helper import | Methods | Token result |
| --- | --- | --- | --- |
| TypeScript | `AgentRegistration` from `@agenttrunk/sdk` | `discover`, `start`, `complete`, `exchange`, `refresh` (async) | `accessToken`, `expiresIn` |
| Python | `AgentRegistration` from `agenttrunk.agent_auth` | Same names (synchronous) | `access_token`, `expires_in` |
| Go | `github.com/aadi-labs/agenttrunk-plugins/sdk/go/agentauth` | `Discover`, `Start`, `Complete`, `Exchange`, `Refresh` | `AccessToken`, `ExpiresIn` |
| Rust | `agenttrunk::agent_auth::AgentRegistration` | Same lowercase names (async) | JSON `access_token`, `expires_in` |
| Ruby | `require 'AgentTrunk/agent_auth'`; `AgentTrunk::AgentRegistration` | Same lowercase names | Hash `access_token`, `expires_in` |
| Swift | `import AgentTrunk`; `AgentRegistration` | Same lowercase names (async) | Dictionary `access_token`, `expires_in` |

Python example, with `human_code` supplied only after human approval:

```python
from agenttrunk.agent_auth import AgentRegistration
from agenttrunk import AgentTrunk

auth = AgentRegistration.discover()
try:
    attempt = auth.start("human@example.com")
    # Show attempt["verification_uri"], never the claim token.
    # Wait for the human and obtain human_code through your trusted UI.
    identity = auth.complete(attempt["claim_token"], human_code)
    token = auth.exchange(identity)
    client = AgentTrunk(access_token=token["access_token"])
    workspaces = client.workspaces.list()
finally:
    auth.close()
```

The caller owns credential storage, token expiry scheduling, and atomic
replacement of a refreshed identity. Never print identities, claim tokens,
access tokens, or refresh tokens. Use dedicated HTTP transports without ambient
credentials or automatic mutation retries. Python's auth helper is synchronous;
use a worker thread when calling it from an async application. Its REST client
still supports both synchronous and asynchronous access.

Exchange returns a short-lived bearer token for the generated client's token
option. Re-exchange before expiry; refresh the identity explicitly when needed.
After an uncertain registration, completion, or refresh response, investigate
before repeating the mutation. Helpers do not perform automatic refresh,
credential persistence, organization creation, or background skill sync.

For a ready-made credential store, use the [CLI setup flow](setup.md).
`agenttrunk auth logout --yes` removes this CLI's local credentials only. It does
not revoke server-side grants or tokens held by other processes. Use account
access controls for revocation; no server-revocation API is advertised here.
After authentication, select an authorized workspace or explicitly create one
through the public API. Use [skill sync](skill-sync.md) for managed local folders.

These helpers are available in repository builds. Registry publication and a
successful hosted approval must be verified separately before depending on a
published version.
