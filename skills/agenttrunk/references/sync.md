# Synchronize a local context folder

Use [setup](setup.md) if authorization is missing. The human approves registration.
Choose the explicit workspace/context and a dedicated folder, then follow the
[sync guide](https://github.com/aadi-labs/agenttrunk-plugins/blob/main/docs/skill-sync.md).

`skills pull` previews metadata; `--execute --yes` downloads verified files.
Use `--ref staging` for editing (default: production). Preserve the generated
`.agenttrunk-sync.json`; never put credentials in this folder.

`skills status` shows local differences offline. `skills push` previews changes;
`--execute --yes` submits one pinned incremental staging edit. Inspect all additions
and deletions because the whole folder is in scope. Production and harness
configuration are unchanged; downloaded skills are not executed.

Pull rejects dirty folders; push rejects remote drift. Reconcile explicitly, not
by changing the binding or retrying blindly. Inspect history after lost responses.
Pull updates retain a reported backup; do not delete it without authority.
