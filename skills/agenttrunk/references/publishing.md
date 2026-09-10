# Publish and review a complete package

## Edit selected files without replacing the package

Use the signup/sign-in procedure in [setup](setup.md) if authorized credentials
are missing. Inspect the intended context at `staging` and retain `revision.id`.
Call generated SDK `contexts.edit` (Go: `Contexts.Edit`) or CLI
`agenttrunk api contexts.edit --input edit.json` to preview this shape:

```json
{
  "trunkId": "WORKSPACE_ID",
  "contextKey": "CONTEXT_KEY",
  "request": {
    "expectedRevisionId": "IMMUTABLE_STAGING_REVISION_ID",
    "changes": [{"operation": "put", "path": "prompts/system.md", "contentBase64": "IyBTdXBwb3J0Cg=="}]
  }
}
```

Add `--execute --yes` only when authorized to make the edit. `put` adds/replaces;
`delete` takes only `operation` and `path` and requires an existing file. Omitted
files and metadata stay intact. Use each path once; the complete result must be
nonempty and within package limits below. Both read and deployment access to
staging are required. Production does not change.

On 409, inspect staging and reconcile the intended changes; do not merely swap
in a newer expected revision. Identical current bytes are a no-op. Restoring a
historical revision uses rollback. After an uncertain write, inspect history
before retrying. [All-language examples](https://docs.agenttrunk.ai/sdks/typescript)
are linked from the docs navigation; Python has sync and async clients.

## Publish a complete replacement

Use the workspace and scope authorized for the task. Inspect the existing package before replacing it. Upload only the explicitly selected files; never traverse home directories or bundle credentials/runtime state.

For a single-file package:

```sh
agenttrunk upload --workspace WORKSPACE_ID --scope SCOPE_ID --key support-policy --title "Support policy" --kind policy --file ./policy.md --path policies/support.md
agenttrunk inspect --workspace WORKSPACE_ID --key support-policy --ref staging
```

For a multi-file skill, call `publish(workspace, {scopeId, contextKey, title, kind: 'skill', files})`. Each file is `{path, contentBase64}`. Include `SKILL.md` with `name`/`description` frontmatter plus every referenced file. The service allows 1–256 files, up to 1,000,000 bytes per file and 16,000,000 decoded bytes total. All paths are relative. Do not supply a guessed `claimedDigest`.

A publication replaces the **entire** package, not a patch. A one-file upload can remove existing references from the next revision. Inspect and read the returned immutable revision, validate its intended behavior in the calling runtime, and record evidence before a release.

```sh
agenttrunk release-request --workspace WORKSPACE_ID --scope SCOPE_ID --evidence EVIDENCE_REFERENCE
agenttrunk releases --workspace WORKSPACE_ID --scope SCOPE_ID --status open
```

Review every entry in `changes` and both snapshot commit IDs: the request includes the whole scope, potentially other contexts. Opening a request does not approve it. Only after authorization for this reviewed release:

```sh
agenttrunk release-merge --workspace WORKSPACE_ID --promotion PROMOTION_ID --yes
```

Inspect production afterward and record the actual pinned revisions. If staging or production changed and a conflict occurs, refresh review; do not force a merge. Git notes/provenance do not confer promotion authority. For a lost response, read [recovery](recovery.md) before repeating the operation.
