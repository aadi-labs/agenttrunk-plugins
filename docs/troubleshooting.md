# Troubleshooting and uncertain writes

The CLI emits JSON errors on stderr and exits nonzero. SDK HTTP failures are `AgentTrunkError` with `status` and sanitized `requestId`. Local validation and transport failures are ordinary errors. Do not dump request headers, raw provider bodies or token callbacks into logs.

| Symptom | Next step |
| --- | --- |
| Command missing / missing `dist` | Build from source; inspect [installation](installation.md) and Node 22+ |
| Missing or expired token / HTTP 401 | Reuse runtime authorization, or use `auth start` and human approval. Use `auth refresh` for an expired stored assertion; never automatically retry an uncertain credential mutation. |
| HTTP 403 | Verify organization, workspace, scope/environment access and delegated permission ceiling; do not broaden credentials automatically |
| HTTP 404 or missing production context | Check exact workspace/key/ref; staging publication does not create a production release |
| Empty discovery page | Continue if `nextCursor` is non-null, within budget; otherwise report no readable matches |
| Cursor rejected or expired | Restart the read with the same filters and deduplicate immutable IDs; do not mix snapshots |
| HTTP 409 | Refresh the reviewed state; do not force, merge blindly or retry writes automatically |
| HTTP 413 / oversized request | Keep 1–256 files, each ≤1,000,000 bytes and total ≤16,000,000 decoded bytes |
| HTTP 429 / 5xx | Bound read retries in the calling runtime; reconcile writes before any retry |
| Redirect or invalid API URL | Confirm the trusted origin (no `/v1`, credentials, query or fragment); do not follow redirects with a token |
| Integrity failure | Stop consuming the file; inspect the pinned manifest and investigate size/hash mismatch |
| Network failure / timeout on a write | The write may have succeeded; use the recovery steps below |

## Reconcile before repeating a mutation

- **Workspace creation:** list workspaces across continuation pages and compare intended identity/name with the account's state. A name match alone cannot prove a previous write's identity; avoid duplicate creation when uncertain.
- **Scope creation:** list scopes in the exact workspace, inspect the result, and resolve ambiguity before creating another.
- **Publication:** inspect `staging` for the exact key, compare the complete manifest's paths, sizes and SHA-256 values to the intended package. The returned revision/package digest identifies what was stored. Another writer may have changed staging; inspect review/history in the platform if the latest state cannot resolve the attempt.
- **Release request:** use `releases --workspace ID --scope ID` or `listPromotions`, follow all relevant pages, and inspect snapshot IDs, changes, status and evidence. Do not open a duplicate because the response was lost.
- **Merge:** list requests and inspect production refs. A merged status plus the intended revision mapping is useful evidence. If state is inconsistent or a 409 occurred, return to review; never force promotion.

A request ID helps an operator investigate; it is not an idempotency key. The SDK sends each operation once and does not add an undocumented idempotency header. There is no client rollback command: use the supported platform review flow or documented REST contract, retaining production release authorization.
