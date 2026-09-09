# Fern SDK generation

This repository uses the same pinned Fern CLI and six SDK generator versions as AgentMailer. Fern produces the resource clients, models, references and test scaffolding from one reviewed public OpenAPI snapshot. The workflow uses [Fern local generation](https://buildwithfern.com/learn/cli-api-reference/cli-reference/sdk-commands) and [local filesystem outputs](https://buildwithfern.com/learn/sdks/reference/generators-yml).

## Sources and outputs

| Path | Ownership |
| --- | --- |
| `fern/openapi/upstream.yaml` | Exact checked-in snapshot of `https://agenttrunk.ai/openapi.yaml` |
| `scripts/sync-openapi.mjs` | Explicit naming, response and immutable-read normalization |
| `fern/openapi/openapi.json` | Generated normalized input consumed by Fern |
| `fern/fern.config.json`, `fern/generators.yml` | Pinned CLI 5.108.0; TypeScript 3.88.3, Python 5.29.2, Go 1.57.9, Rust 0.46.4, Ruby 1.23.2, Swift 0.36.1 |
| `sdk/typescript`, `sdk/python`, `sdk/go`, `sdk/rust`, `sdk/ruby`, `sdk/swift` | Generated output plus reproducibly copied extensions |
| `client-extensions/` | Authored transport policy, verified-read helpers, language README sources and Go example/tests |
| `scripts/postprocess-sdks.mjs` | Guarded, repeatable generator patches; unexpected templates fail closed |
| `sdk/index.ts` | Existing TypeScript convenience client plus generated `AgentTrunkClient` re-export |

The TypeScript release artifact remains the root `@agenttrunk/sdk` package, including CLI and generated API code. Fern's nested TypeScript package is private scaffolding, not a second npm release. Python builds as `agenttrunk`; Go uses `github.com/aadi-labs/agenttrunk-plugins/sdk/go`. Registry publication and Go module tags have not been performed.

## Commands

```sh
npm ci
npm run sdk:check             # Local snapshot normalization, Fern validation, TypeScript check
npm run sdk:sync:check        # Compare against the currently hosted public contract
npm run sdk:sync:live         # Explicitly refresh upstream + normalized snapshots for review
npm run sdk:generate          # Generate all six languages locally, apply extensions, tidy Go
npm run sdk:postprocess:check # Verify a second postprocessing pass leaves outputs unchanged
npm test                     # Existing client/CLI/examples plus generated TypeScript contract tests
npm run sdk:test:python       # Focused Python sync/async transport and integrity tests
npm run sdk:test:go           # Compile all Go packages; run AgentTrunk contract tests
npm run sdk:build:python      # Build wheel and source distribution
npm run validate
npm run test:package
```

`npm run sdk:generate` requires Docker and uses the configured Docker context. It creates a temporary Docker config so generator image pulls do not depend on a broken desktop credential helper. Generation stays local and does not publish or modify platform/provider configuration. If Fern requires an organization credential in another environment, supply it through the normal secret mechanism; this repository does not store or bypass that credential.

The default generation command reads the reviewed snapshot and never silently refreshes the live schema. `sdk:sync:check` performs the network drift check separately; ordinary CI is deterministic and does not depend on the hosted site. For one language, use `sh scripts/generate-local.sh python-sdk` (or `typescript-sdk`, `go-sdk`) then `npm run sdk:postprocess`. Postprocessing expects the checked-in outputs for all languages to exist.

The Go helper prefers Go 1.21+ locally. Otherwise it uses `golang:1.24-bookworm` through Docker, as AgentMailer does. Fern-generated wire-test scaffolding is retained for future server contract testing. The focused test commands do not run that entire optional WireMock suite or every upstream runtime test; they compile the outputs and test AgentTrunk-specific behavior. They do not establish hosted account acceptance.

## Contract decisions

37 client operations are generated. The Stripe inbound webhook receiver is deliberately excluded: it is a provider callback, not an agent SDK operation. Resource groups cover workspaces, scopes, contexts, releases, context sets, webhooks, privacy, billing and health. An available method does not grant the corresponding permission or activate a disabled platform feature.

The hosted contract has several response descriptions without schemas. Known core response shapes are annotated from the published descriptions. Other such responses remain JSON dictionaries/maps instead of fabricated types. Discovery is corrected to compact `contextKey` metadata (the existing client wire contract), not the full context record's `key`, `id` and `createdAt`. Ref unions are represented as strings with the same allowed values. Binary file reads require an immutable revision ID in the SDK; resolve channels through inspect first.

Bearer authentication is configured explicitly. No OAuth client-secret acquisition or unverified agent login flow is generated from provider metadata. Tokens remain runtime-supplied, organization-scoped, and tied to the authorizing user.

## Transport extensions

Default retries are zero/one attempt; mutations never retry even when read retries are configured. Redirects are refused. The shared transport rejects insecure non-loopback destinations and missing `/v1/` bearer credentials. File responses are capped at 1,000,000 bytes and JSON at 24,000,000 bytes. Python has sync/async verified-read helpers; Go has `verified.ReadFile`; TypeScript retains `AgentTrunk.readFile`.

Raw generated file methods bound the bytes but cannot verify a hash without a manifest. Use the verified helper before consuming context. A valid digest never grants execution authority. Custom transports remain trusted application code and must honor cancellation and redirect policy. Error strings omit provider bodies; never dump full exception/response objects or headers into logs.

Update source overlays/extensions and regenerate rather than hand-editing generated API methods. The generation validator checks endpoint coverage and the checked-in normalized snapshot. Review any generator version upgrade together with the guarded patches and failure-path tests.

## Six-language coverage and derived surfaces

Rust 0.46.4, Ruby 1.23.2 and Swift 0.36.1 join the pinned TypeScript/Python/Go generators. `all-sdks` generates all six. `extra-sdks` generates Rust/Ruby/Swift for focused iteration. `scripts/postprocess-extra.mjs` restores authored safeguards and verified helpers. Ruby's untyped response and binary-body correction is reapplied after generation; Rust's transport enables rustls TLS explicitly.

`npm run cli:generate` derives all CLI methods and argument ordering from the normalized contract and TypeScript AST. `npm run examples:generate` derives paired executable cookbook runners from reviewed recipes. `npm run skills:build` exports the canonical shared skill to the portable root layout; `skills:check` rejects stale exports. Generated resource methods remain owned by Fern; maintained corrections must be reproducible through postprocessing.

Validate with `npm run sdk:postprocess:check`, `npm run cli:check`, all six language checks and package-consumer tests. Never copy build caches, target directories or credentials into SDK releases.
