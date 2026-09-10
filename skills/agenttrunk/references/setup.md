# Install and connect

`agenttrunk auth logout` previews local sign-out; `auth logout --yes` clears this
CLI's stored credentials. It does not revoke remote grants or injected tokens.

1. Check Node.js 22+ and an existing `agenttrunk --help`. If absent, clone `https://github.com/aadi-labs/agenttrunk-plugins.git` into the intended location, run `npm ci` and `npm run build`, then use `node dist/cli/index.js --help` from that clone. A global installation is optional, not required.
2. If adding instructions to another harness, install the whole `agenttrunk` skill directory with its references. From the clone, `npx skills add . --list` discovers it and `npx skills add . --skill agenttrunk` installs it. Preserve existing customizations. Skill installation does not install the CLI.
3. Reuse an existing runtime-injected `AGENTTRUNK_ACCESS_TOKEN` or CLI registration first. If absent, run `agenttrunk auth discover`, then `agenttrunk auth start --email HUMAN_EMAIL`. Give only the verification link to the human. After they approve and provide the code, run `agenttrunk auth complete` with that code on stdin. Do not complete the approval yourself using their browser. The CLI stores identity credentials in `~/.agenttrunk/credentials.json` (0600 inside a 0700 directory), exchanges short-lived tokens in memory, and supports explicit `auth refresh`. Never print that file. Cloud runtimes should use the SDK's `AgentRegistration` with a secret manager instead. API origin defaults to `https://api.agenttrunk.ai`; overrides must be explicitly trusted origins without `/v1`.
4. Run `agenttrunk workspaces`, choose the exact workspace from task intent, and run `agenttrunk scopes --workspace ID`. Follow continuation cursors where present. Never print the environment or token.
5. A new human must complete organization onboarding at `https://www.agenttrunk.ai/signup`; an existing human signs in at `https://www.agenttrunk.ai/login`. If discovery returns 404/503 or registration is unavailable, report the connection blocker; do not invent endpoints. Permission denial is not a reason to create a replacement organization. Failed or uncertain claim/refresh mutations need reconciliation, not automatic retries. The AgentTrunk authentication guide is available at `https://www.agenttrunk.ai/auth.md`; prefer these client commands to placing secrets in shell arguments.

## Refresh and incomplete registration

The CLI credential file is owner-only but **not encrypted**. Use an isolated OS user or a runtime secret manager for cloud agents. `agenttrunk auth refresh` explicitly rotates an approved identity. `agenttrunk auth cancel` clears only an abandoned local pending claim, not an approved connection or remote grant. Reconcile an uncertain completion or refresh before retrying it. Do not delete a credential lock while an auth command is running.

## MCP connection requests

Use [operational MCP](mcp.md) at `https://api.agenttrunk.ai/mcp` with securely supplied human-approved bearer credentials. This skill does not automatically modify MCP configuration. Installation and successful CLI authorization do not prove MCP connectivity; verify authenticated initialization and tools/list.

Workspace creation, when requested: `agenttrunk workspace-create --name NAME`. It creates a General scope; list scopes to obtain its ID. For a requested separate scope: `agenttrunk scope-create --workspace ID --name NAME`. Creation changes remote state and is not a connection test.

Report what was actually verified: local client, read access, staging write or release. A working read does not establish publish permission or marketplace acceptance.

[Full installation guide](https://github.com/aadi-labs/agenttrunk-plugins/blob/main/docs/installation.md) · [Setup guide](https://github.com/aadi-labs/agenttrunk-plugins/blob/main/docs/setup.md)
