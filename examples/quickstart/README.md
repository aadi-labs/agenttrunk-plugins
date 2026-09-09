# Check your connection

From the built repository root:

```sh
node examples/quickstart/index.mjs
```

Required: `AGENTTRUNK_ACCESS_TOKEN` from the runtime secret store. Optional: `AGENTTRUNK_API_URL`, `AGENTTRUNK_WORKSPACE_ID`. See [setup](../../docs/setup.md).

Without a workspace ID, the program lists authorized workspaces across at most ten pages and asks you to choose an exact ID. It does not select the first workspace or create one. If `truncated` is true, the result is partial and `nextCursor` is available for continuation.

Set `AGENTTRUNK_WORKSPACE_ID` to the intended ID and rerun. It reads that workspace, lists its scopes and counts the first page of production matches, returning a cursor when more exist. It prints metadata and counts, not tokens or file bodies. This demonstrates read access only; empty production results do not establish publish access or imply failure.

Next: [load pinned context](../pinned-context/README.md). Source: [index.mjs](index.mjs).
