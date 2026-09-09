# webhook deliveries

Calls `webhooks.list` through the generated SDK. Inspect delivery state before retrying. Retry is a mutation; consumers must deduplicate events. Never print a signing secret or portal URL to a shared log.

Review [request.json](request.json). Values written as `${AGENTTRUNK_…}` come from your runtime environment. Both runners preview locally by default and omit payloads and credentials from their output.

From the repository root, after `npm ci && npm run build`:

```sh
node examples/workflows/webhook-deliveries/index.mjs
uv run --with ./sdk/python python examples/workflows/webhook-deliveries/main.py
```

Add `--execute` to send the read request. Reads may contain sensitive context; direct stdout only to an authorized destination. On a network failure after a write, reconcile state before retrying.

[Authentication and setup](../../../docs/setup.md) · [API reference](../../../sdk/typescript/reference.md) · [All workflows](../README.md)
