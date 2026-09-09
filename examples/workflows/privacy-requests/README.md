# privacy requests

Calls `privacy.list` through the generated SDK. Request intake and an erasure plan are not proof of deletion. Restrict output to authorized reviewers; include upstream retention, logs and backups in the operational process.

Review [request.json](request.json). Values written as `${AGENTTRUNK_…}` come from your runtime environment. Both runners preview locally by default and omit payloads and credentials from their output.

From the repository root, after `npm ci && npm run build`:

```sh
node examples/workflows/privacy-requests/index.mjs
uv run --with ./sdk/python python examples/workflows/privacy-requests/main.py
```

Add `--execute` to send the read request. Reads may contain sensitive context; direct stdout only to an authorized destination. On a network failure after a write, reconcile state before retrying.

[Authentication and setup](../../../docs/setup.md) · [API reference](../../../sdk/typescript/reference.md) · [All workflows](../README.md)
