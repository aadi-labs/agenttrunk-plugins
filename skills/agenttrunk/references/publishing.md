# Publish and review a complete package

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
