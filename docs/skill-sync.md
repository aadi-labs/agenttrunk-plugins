# Synchronize a context folder

Authenticate using an existing token or human-approved CLI registration. Select
an authorized workspace/context and a dedicated folder. No command executes
downloaded instructions, configures a harness, or changes production.

```sh
agenttrunk skills pull --workspace WORKSPACE_ID --key CONTEXT_KEY --directory ./support --ref staging
agenttrunk skills pull --workspace WORKSPACE_ID --key CONTEXT_KEY --directory ./support --ref staging --execute --yes
# Edit local files, then inspect differences offline.
agenttrunk skills status --workspace WORKSPACE_ID --key CONTEXT_KEY --directory ./support
agenttrunk skills push --workspace WORKSPACE_ID --key CONTEXT_KEY --directory ./support
agenttrunk skills push --workspace WORKSPACE_ID --key CONTEXT_KEY --directory ./support --execute --yes
```

Pull and push preview by default. The parent directory must exist; an initial
pull requires a nonexistent destination. Existing destinations require the matching
`.agenttrunk-sync.json` binding. It pins origin, workspace, context, revision and
file hashes, never tokens. Do not edit it. Pull defaults to production; use staging
for editing. Push requires staging still to match the pinned base.

Pull verifies every file and refuses local changes, including untracked files.
Updates retain the old directory as a reported sibling backup. Failed downloads
may leave a private temporary directory, never an installed skill. Review and
remove backups manually when safe. Status reads local files only.

Push compares the complete local folder with the manifest: additions/changes
become puts and removed files become deletes. Keep secrets, `.env`, runtime state,
and unrelated files outside this folder. Symlinks, `.git`, unsafe paths and
oversized packages are rejected. At most 256 changes can be pushed; the result
must remain nonempty. No automatic write retries, merges, or watch mode exist.

Reconcile remote drift instead of modifying the binding. After an uncertain push
or failed manifest update, inspect staging/history before another mutation.
Cooperative operations use a sibling lock; investigate stale locks manually.
Pause editors while applying a pull. This is not a security boundary against
another process running as your user. Use separate folders for different origins
or workspaces. Harness installation remains a caller decision.
