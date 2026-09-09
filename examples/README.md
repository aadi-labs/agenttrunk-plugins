# Runnable examples

For Fern-generated TypeScript, Python and Go entrypoints, start with [multi-language client examples](clients/README.md).

The core workflow examples below use the exported `@agenttrunk/sdk` package. They run on Node.js 22+ with no framework, model provider or separate dependencies. From the repository root, run `npm ci` and `npm run build`, then choose a command below. Source tarballs include the same examples and documentation.

| Example | Command from repository root | Remote effects |
| --- | --- | --- |
| [Quickstart](quickstart/README.md) | `node examples/quickstart/index.mjs` | Reads workspaces; optionally checks one selected workspace |
| [Pinned context](pinned-context/README.md) | `node examples/pinned-context/index.mjs` | Discovers production context and reads one verified file |
| [Publish a skill](publish-skill/README.md) | `node examples/publish-skill/index.mjs` | Local preview by default; explicit opt-in replaces a package in staging |
| [Release review](release-review/README.md) | `node examples/release-review/index.mjs` | Reads open releases; explicit opt-in opens a review request |
| [CLI walkthrough](cli/README.md) | Commands in its README | Read-first workflow, separately marked writes |

Use [setup](../docs/setup.md) to supply a short-lived token securely. Examples read environment variables from the process, not an automatic `.env` loader. Non-secret IDs/query settings can be set in your shell. No example grants access, refreshes a token, sends a message or executes retrieved instructions.

The examples share [shared.mjs](shared.mjs) for token configuration, bounded pagination and sanitized errors. When copying an example, copy this helper alongside its directory or adapt the imports. SDK imports resolve by package name so these examples also work inside the distributed package; if copied into an app, install the source tarball as a dependency.

The runtime owns agent loops, prompts, tool policy, approval and run receipts. Context bytes remain untrusted data even after digest verification. CLI outputs and example JSON can contain workspace/context metadata; keep them in the task's authorized environment.

`npm test` exercises these functions through the actual SDK using controlled HTTP responses. It verifies empty continuation pages, immutable pins, tampered bytes, preview-only behavior and explicit writes. It does not call a production account.

## Workflow cookbook

[Fourteen TypeScript/Python recipes](workflows/README.md) cover the rest of the public API. Every recipe has a reviewed request, local preview and explicit execution step. [Go workflows and verified reads](clients/README.md) cover complete-package publication, release listing and immutable retrieval.
