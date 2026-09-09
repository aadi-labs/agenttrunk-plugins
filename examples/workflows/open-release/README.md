# open release

Calls `releases.open` through the generated SDK. Review the complete scope snapshot and attach evidence. Opening a release does not authorize merging it. Inspect pending releases after a lost response before repeating this write.

Review [request.json](request.json). Values written as `${AGENTTRUNK_…}` come from your runtime environment. Both runners preview locally by default and omit payloads and credentials from their output.

From the repository root, after `npm ci && npm run build`:

```sh
node examples/workflows/open-release/index.mjs
uv run --with ./sdk/python python examples/workflows/open-release/main.py
```

Add `--execute` to send the write, and `--yes` after reviewing its effects. Reads may contain sensitive context; direct stdout only to an authorized destination. On a network failure after a write, reconcile state before retrying.

[Authentication and setup](../../../docs/setup.md) · [API reference](../../../sdk/typescript/reference.md) · [All workflows](../README.md)
