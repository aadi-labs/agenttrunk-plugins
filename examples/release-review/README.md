# Review a scope's release

Required: `AGENTTRUNK_ACCESS_TOKEN`, `AGENTTRUNK_WORKSPACE_ID`, `AGENTTRUNK_SCOPE_ID`. Run read-only review from the built repository root:

```sh
node examples/release-review/index.mjs
```

The program lists open release requests, following up to ten pages even if an intermediate page is empty. It preserves the full scope change lists, reviewed source/target commits and status. `truncated: true` means the list is partial; retain `nextCursor` for further reading.

After staging validation, opening a review is an explicit mutation. Set `AGENTTRUNK_EVIDENCE_REFERENCE` to the real test report/reference and opt in:

```sh
AGENTTRUNK_OPEN_RELEASE=1 node examples/release-review/index.mjs
```

It opens one request and lists open reviews. Inspect **all** `changes`, since a request captures the whole scope snapshot, including contexts other than your last upload. The example never calls `mergePromotion`. Missing evidence fails before a write. A lost response requires [reconciliation](../../docs/troubleshooting.md).

When an authorized user has approved that exact reviewed release, merge separately:

```sh
node dist/cli/index.js release-merge --workspace WORKSPACE_ID --promotion PROMOTION_ID --yes
```

Afterward, inspect production for each intended context and record actual immutable revisions. Conflicts need a refreshed review; `--yes` does not bypass service permissions. Source: [index.mjs](index.mjs).
