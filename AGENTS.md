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
