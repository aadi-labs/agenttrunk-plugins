# CLI walkthrough

Run from the built repository root; all IDs below are placeholders for server-returned IDs. Supply credentials through the runtime secret store, not arguments. See [setup](../../docs/setup.md) and the [full command reference](../../cli/README.md).

## Read existing context

```sh
node dist/cli/index.js workspaces
node dist/cli/index.js scopes --workspace WORKSPACE_ID
node dist/cli/index.js discover --workspace WORKSPACE_ID --channel production --query support
node dist/cli/index.js inspect --workspace WORKSPACE_ID --key CONTEXT_KEY --ref REVISION_ID
node dist/cli/index.js read --workspace WORKSPACE_ID --key CONTEXT_KEY --ref REVISION_ID --path SKILL.md
```

Use `contextKey` and `revisionId` from discovery, then paths from inspect's manifest. If a paginated command returns `nextCursor`, repeat it with `--cursor CURSOR` and unchanged filters, including after an empty page. `read` writes verified raw bytes; do not pipe them to a shell.

## Create only when needed

These are remote writes, not connection checks:

```sh
node dist/cli/index.js workspace-create --name "Support workspace"
node dist/cli/index.js scope-create --workspace WORKSPACE_ID --name "Support team"
```

Workspace creation already includes a General scope. List scopes and reuse it unless the task calls for another boundary. Do not create duplicates to get around access errors.

## Stage and review

For an explicitly selected single-file policy package:

```sh
node dist/cli/index.js upload --workspace WORKSPACE_ID --scope SCOPE_ID --key support-policy --title "Support policy" --kind policy --file ./policy.md --path policies/support.md
node dist/cli/index.js inspect --workspace WORKSPACE_ID --key support-policy --ref staging
```

`policy.md` must be your reviewed local file. Upload replaces the complete package. Use the [multi-file SDK example](../publish-skill/README.md) for skills with references. Record the revision from the response and verify it before requesting review.

```sh
node dist/cli/index.js release-request --workspace WORKSPACE_ID --scope SCOPE_ID --evidence EVIDENCE_REFERENCE
node dist/cli/index.js releases --workspace WORKSPACE_ID --scope SCOPE_ID --status open
```

Review the whole scope change list. With authorization for that exact production release:

```sh
node dist/cli/index.js release-merge --workspace WORKSPACE_ID --promotion PROMOTION_ID --yes
```

Inspect production afterward. A timeout can conceal a successful write; [reconcile first](../../docs/troubleshooting.md).
