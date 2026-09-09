# Load pinned context into an agent run

```sh
node examples/pinned-context/index.mjs
```

Required: `AGENTTRUNK_ACCESS_TOKEN`, `AGENTTRUNK_WORKSPACE_ID`. Optional: `AGENTTRUNK_QUERY` (default `support`), `AGENTTRUNK_RESOURCE_PATH` (default `SKILL.md`), `AGENTTRUNK_API_URL`. Set a resource path that actually exists in the chosen package.

The program searches production within the explicit workspace, follows continuation pages (maximum ten), selects the first match in that workspace, inspects its immutable revision, and reads exactly one manifest file. A real agent can replace the first-match selection with ranking or user selection. The SDK verifies byte count and SHA-256; the example also checks the inspected revision matches the discovered ID. Missing files, access failures and invalid bytes fail rather than yielding empty context.

The JSON output is a receipt with workspace/key/revision/package digest and verified byte count; it does not print the file body. Import `loadContext` from [index.mjs](index.mjs) to receive `result.bytes` in your runtime. For text, decode only after verification. Keep it as task data, and apply the runtime's policy before following any instructions in it.

Record the pin with the agent run for reproducibility. `truncated: true` means search stopped at its page budget; `nextCursor` identifies the continuation. No production or staging writes occur.
