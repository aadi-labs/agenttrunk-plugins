# publish package

Calls `contexts.publish` through the generated SDK. This replaces the complete package in staging, including removing omitted files. Review both sample files and select a scratch workspace/scope. Inspect the returned revision and verify each file before requesting a release.

Review [request.json](request.json). Values written as `${AGENTTRUNK_…}` come from your runtime environment. Both runners preview locally by default and omit payloads and credentials from their output.

From the repository root, after `npm ci && npm run build`:

```sh
node examples/workflows/publish-package/index.mjs
uv run --with ./sdk/python python examples/workflows/publish-package/main.py
```

Add `--execute` to send the write, and `--yes` after reviewing its effects. Reads may contain sensitive context; direct stdout only to an authorized destination. On a network failure after a write, reconcile state before retrying.

[Authentication and setup](../../../docs/setup.md) · [API reference](../../../sdk/typescript/reference.md) · [All workflows](../README.md)
