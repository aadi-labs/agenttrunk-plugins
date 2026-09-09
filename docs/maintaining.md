# Maintaining public clients

The single authored portable skill lives at `plugins/agenttrunk/skills/agenttrunk`. Claude and Codex load that same directory, and the skills CLI discovers it directly. Do not create independently maintained harness copies. Keep its relative reference links usable when installed outside this repository.

`catalog.json` indexes local entry points for tools. `llms.txt` routes text readers. These are repository discovery aids, not new protocol endpoints or claims of marketplace registration. When adding a workflow, link its documentation from the catalog, README and relevant skill reference. Keep package keywords descriptive and avoid implying unsupported MCP/login capabilities.

The SDK uses only the public REST contract. Update types, CLI help, the SDK/CLI method tables and executable examples together for public behavior changes. Do not copy private implementation modules into this repository. The examples import the package by name, so tests exercise the exported entry point rather than an alternate client.

Run `npm ci`, `npm run check`, `npm test`, `npm run validate`, `npm run test:package`, and `npm pack --dry-run`. `npm run validate` checks relative Markdown links and catalog targets, plugin version/skill agreement, example documentation, and the files npm will distribute. `npm test` includes isolated, mocked HTTP workflows and failure paths; no credentials or live mutations are required. Run `npx skills add . --list` for a direct discovery check when changing the skill layout.

A release requires separate authorization to commit/push/publish. Before claiming hosted readiness, verify the actual token flow, scoped read, staging publication, release authorization and production read in an appropriate account. Before claiming discoverability in a directory, verify its listing/search result separately. Local skill discovery and package contents alone do not prove those outcomes.

`npm run test:package` packs and installs into a temporary consumer project, checks the exported SDK, npm executable symlink, token-free example preview and bundled skill references, then removes that temporary project. It does not install anything globally or contact the AgentTrunk API.

## Generated language clients

Follow the [Fern generation guide](sdk-generation.md) for TypeScript, Python, Go, Rust, Ruby and Swift. Do not edit generated API methods under `sdk/typescript`, `sdk/python` or `sdk/go`; change the contract overlay or `client-extensions` and regenerate. Language README authoring sources also live under `client-extensions`. Run `npm run sdk:check`, `npm run sdk:test:python`, and `npm run sdk:test:go` in addition to the existing root checks.
