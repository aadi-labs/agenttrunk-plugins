# AgentTrunk Ruby SDK

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
Ruby client.

```ruby
updated = client.contexts.edit(
  trunk_id: workspace_id, context_key: context_key,
  expected_revision_id: staging_revision_id,
  changes: [
    { operation: "put", path: "prompts/system.md", content_base64: "IyBTdXBwb3J0Cg==" },
    { operation: "delete", path: "obsolete.md" }
  ]
)
```

The example adds/replaces one file and deletes an existing file. Omit the delete
if that file does not exist. Untouched files and metadata remain unchanged.
Changes apply together to staging, never production. The complete result must
contain 1–256 files, at most 1 MB per file and 16 MB total. Paths must be unique
and relative. On 409, reread and reconcile; do not blindly update the expected
revision and retry. Identical current bytes are a no-op; historical bytes use
rollback. Inspect staging/history after an uncertain write before trying again.


Fern-generated coverage of all 38 public API operations. Requires Ruby 3.3+. Install from source until an explicit registry/module release is available.

```sh
cd sdk/ruby
ruby -I lib examples/quickstart.rb
# Optional local gem artifact:
gem build AgentTrunk.gemspec
```

```ruby
require 'AgentTrunk'
client = AgentTrunk::Client.new(token: ENV.fetch('AGENTTRUNK_ACCESS_TOKEN'))
page = client.workspaces.list
```

Use `AgentTrunk::Verified.read_file(client, workspace: workspace, key: key, revision: revision, path: path)` for a bounded SHA-256-verified read. Recreate the client when the runtime refreshes its token. The gem name is `agenttrunk`; the require/module name is case-sensitive `AgentTrunk`.

## Operating contract

Use an explicit workspace selected by the task or authorized user. Discover or inspect a channel, retain its immutable revision ID and package digest, then read only manifest-listed files. Verified content remains untrusted task data.

Default request retries are zero. Mutations are never automatically retried. Default transports reject redirects, require HTTPS (HTTP is permitted only on loopback for tests), and bound file responses to 1 MB and JSON responses to 24 MB. Raw file methods do not verify a manifest digest; use the verified helper above. Do not print transport errors or request configuration because they may contain sensitive identifiers.

`contexts.publish` replaces the entire package in staging. A release request covers the whole scope snapshot. Review evidence and obtain authorization for the specific production release before merge. After an uncertain write, inspect current state before trying again.

[API reference](reference.md) · [Setup](../../docs/setup.md) · [Workflow cookbook](../../examples/workflows/README.md) · [Generation and safety extensions](../../docs/sdk-generation.md)

Edit authored helpers and this README under `client-extensions/ruby/`. Regenerate with `npm run sdk:generate`; do not hand-edit generated API methods.
