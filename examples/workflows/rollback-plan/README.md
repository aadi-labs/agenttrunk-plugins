# rollback plan

Calls `contexts.getRollbackPlan` through the generated SDK. This is a read-only eligibility check. It does not restore data. The stageRollback operation requires separate authorization and must be followed by normal release review.

Review [request.json](request.json). Values written as `${AGENTTRUNK_…}` come from your runtime environment. Both runners preview locally by default and omit payloads and credentials from their output.

From the repository root, after `npm ci && npm run build`:

```sh
node examples/workflows/rollback-plan/index.mjs
uv run --with ./sdk/python python examples/workflows/rollback-plan/main.py
```

Add `--execute` to send the read request. Reads may contain sensitive context; direct stdout only to an authorized destination. On a network failure after a write, reconcile state before retrying.

[Authentication and setup](../../../docs/setup.md) · [API reference](../../../sdk/typescript/reference.md) · [All workflows](../README.md)
