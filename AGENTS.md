# AgentTrunk public clients

This repository contains portable skills, harness packaging, SDK and CLI only.
The platform, authorization policy, infrastructure and credentials belong elsewhere.
Use the public REST contract; never import from the private platform repository.
Keep one shared skill for both plugins. Do not add a fake MCP endpoint or claim
self-service login works before the deployed provider flow has been verified.

Never commit tokens, customer context, environment files or Terraform state.
Preserve explicit workspace scope, immutable reads and production approval.
Do not retry mutations automatically. Keep tokens out of logs and CLI arguments.
Test network failure, permission denial, redirects, size limits and integrity.

Run `npm ci`, `npm test`, `npm run check`, and `npm pack --dry-run` before release.
Publishing to npm, changing providers and deploying the platform are separate
actions from updating this repository and require user authorization.


## Fern generation

`fern/openapi/upstream.yaml` is the reviewed public contract snapshot. Normalize
it through `scripts/sync-openapi.mjs`. Use `npm run sdk:generate` for generated
TypeScript, Python, Go, Rust, Ruby and Swift resources; do not hand-edit generated API methods.
Authored safety helpers and language README sources live in `client-extensions/`.
Guarded postprocessing must remain reproducible and preserve no mutation retries,
redirect rejection, explicit workspace scope and verified immutable file reads.
Run `npm run sdk:check`, `npm run sdk:test:python`, `npm run sdk:test:go`,
`npm run validate` and `npm run test:package` for generated-client changes.

The root `skills/` directory is a deterministic portable export, not a second authoring source. Run `skills:build` after canonical skill edits and `skills:check` in CI. Keep the operation catalog and paired cookbook runners reproducible. Release workflows prepare artifacts by default; a published package or hosted authorization flow must be verified separately.
