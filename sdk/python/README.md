# AgentTrunk Python SDK

Fern-generated synchronous and asynchronous clients for the public AgentTrunk REST API. Requires Python 3.10+. Install from this repository until a registry release is verified:

```sh
python -m pip install ./sdk/python
# Or without modifying your environment, from the repository root:
uv run --with ./sdk/python python examples/clients/python/quickstart.py
```

```python
import os
from agenttrunk import AgentTrunk, AsyncAgentTrunk

client = AgentTrunk(access_token=lambda: os.environ['AGENTTRUNK_ACCESS_TOKEN'])
page = client.workspaces.list()
# Continue page.next_cursor with cursor=...; choose the intended workspace explicitly.
```

The async client exposes the same groups; for example `await async_client.workspaces.list()`. The token supplier is synchronous and evaluated per request. Use the runtime's existing refreshable token provider. No account signup, login, credential issuance or refresh endpoint is generated.

Resource groups: `workspaces`, `scopes`, `contexts`, `releases`, `context_sets`, `webhooks`, `billing`, `privacy`, `health`. See [generated reference](reference.md) for signatures. Python response attributes use snake_case: `context_key`, `revision_id`, `next_cursor`, `content_base64`. Fields unspecified by the upstream contract remain dictionaries rather than invented types.

## Verified context reads

```python
from agenttrunk.verified import read_verified_file, async_read_verified_file

# revision_id comes from scoped discovery or one inspect of production.
content = read_verified_file(client, workspace_id, context_key, revision_id, 'SKILL.md')
```

The helper inspects the immutable revision, finds the exact file, bounds its bytes and verifies size/SHA-256. The async helper takes `AsyncAgentTrunk` and must be awaited. Persist workspace/key/revision/package digest with the run. Raw `contexts.read_file` yields bounded bytes and requires an immutable `ref`; use the verified helper before consuming context as task input.

## Safety and configuration

Default retries are zero. Writes never retry even when `max_retries` is set for reads. Redirects are disabled at the request layer, including with a supplied httpx client. Non-HTTPS destinations are rejected except loopback; file reads require a lowercase 64-character revision ID. Responses are bounded to 1,000,000 bytes for files and 24,000,000 for JSON. Error strings omit provider bodies; inspect `status_code` and a sanitized request ID instead of dumping exceptions, headers or bodies. The caller owns any injected httpx client's lifetime and behavior.

Use `base_url` only for a trusted API origin without `/v1`, and `timeout` in seconds. Inject `access_token` explicitly as shown. Do not rely on changing an environment variable after module import: Fern's generated default environment value is captured at import; a callback supports refresh. Never put tokens in prompts or source files.

`contexts.publish` replaces a complete package in staging. `releases.open` captures the entire scope snapshot. `releases.merge` requires explicit authorization for that reviewed production change. Reconcile uncertain writes before repeating them.

## Build and test

```sh
uv build ./sdk/python
uv run --with ./sdk/python python -m unittest discover -s test/python -v
```

Run these from the repository root. The focused tests use controlled transports, including sync/async verified reads, permissions, redirects and mutation failures; they do not establish hosted acceptance. Regenerate through `npm run sdk:generate`; custom safety and verified-read sources live under `client-extensions/python` and are copied by postprocessing.
