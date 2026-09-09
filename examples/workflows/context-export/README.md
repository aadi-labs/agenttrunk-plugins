# context export

Calls `contexts.export` through the generated SDK. Export covers this revision only. It can contain sensitive workspace content. Choose its destination deliberately; it is not a complete personal-data export.

Review [request.json](request.json). Values written as `${AGENTTRUNK_…}` come from your runtime environment. Both runners preview locally by default and omit payloads and credentials from their output.

From the repository root, after `npm ci && npm run build`:

```sh
node examples/workflows/context-export/index.mjs
uv run --with ./sdk/python python examples/workflows/context-export/main.py
```

Add `--execute` to send the read request. Reads may contain sensitive context; direct stdout only to an authorized destination. On a network failure after a write, reconcile state before retrying.

[Authentication and setup](../../../docs/setup.md) · [API reference](../../../sdk/typescript/reference.md) · [All workflows](../README.md)
