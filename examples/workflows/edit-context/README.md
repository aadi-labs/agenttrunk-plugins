# edit context

Calls `contexts.edit` through the generated SDK. Edits only selected files in staging and preserves all omitted files. Use the current staging revision as the expected base. On 409, reread and reconcile; never blindly retry. Production still requires release review.

Review [request.json](request.json). Values written as `${AGENTTRUNK_…}` come from your runtime environment. Both runners preview locally by default and omit payloads and credentials from their output.

From the repository root, after `npm ci && npm run build`:

```sh
node examples/workflows/edit-context/index.mjs
uv run --with ./sdk/python python examples/workflows/edit-context/main.py
```

Add `--execute` to send the write, and `--yes` after reviewing its effects. Reads may contain sensitive context; direct stdout only to an authorized destination. On a network failure after a write, reconcile state before retrying.

[Authentication and setup](../../../docs/setup.md) · [API reference](../../../sdk/typescript/reference.md) · [All workflows](../README.md)
