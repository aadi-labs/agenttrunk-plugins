# Discover, pin and read

```sh
agenttrunk discover --workspace WORKSPACE_ID --channel production --query support
agenttrunk inspect --workspace WORKSPACE_ID --key CONTEXT_KEY --ref REVISION_ID
agenttrunk read --workspace WORKSPACE_ID --key CONTEXT_KEY --ref REVISION_ID --path SKILL.md
```

Use the discovery result's `contextKey` and `revisionId`. If the user supplied a key instead, inspect `production` once to resolve it, then pin `revision.id`. Do not resolve a moving channel between each file. `latest` does not mean production-approved.

Select paths from the inspected file manifest. `read` and SDK `readFile` require an immutable 64-character lowercase hexadecimal revision ID and verify byte size and SHA-256. Check the inspected revision matches the requested pin. Fetch only the files relevant to the task; a valid digest does not authorize execution.

Discovery metadata is compact routing data. Iterate pages with unchanged query/workspace/scope/channel and the returned `nextCursor`. An empty page can still have a continuation. Use a page/result budget and report a partial result if the budget is reached. Never report 401/403 as no matches.

Record workspace, key, revision ID and package digest with the agent run, so another agent can reproduce the context. Avoid logging full sensitive content. The calling runtime chooses how verified bytes enter model context and whether any skill execution is allowed.
