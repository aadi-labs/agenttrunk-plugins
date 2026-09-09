# Prepare and release clients

Release preparation creates reviewable artifacts and performs no publication. Run from a clean release checkout after reviewing all changes:

```sh
npm ci
npm run sdk:check
npm test
npm run validate
npm run test:package
npm run sdk:test:python
npm run sdk:test:go
npm run sdk:test:rust
npm run sdk:test:ruby
npm run sdk:test:swift
npm run sdk:postprocess:check
npm run sdk:sync:check
npm pack
uv build ./sdk/python
cargo package --manifest-path sdk/rust/Cargo.toml
```

Build the Ruby gem from `sdk/ruby` with `gem build agenttrunk.gemspec`. Compile the Swift package with `swift build --package-path sdk/swift`. The `prepare-release.yml` workflow performs checks and uploads source/package artifacts after an explicit manual dispatch. Its output is not a release.

Before publishing, align the root npm version, all manifests, Fern generation version, Python pyproject, Cargo manifest and Ruby version. Regenerate clients and skill exports, rerun checks, and inspect archives for source licenses, readmes, references and absence of secrets/build caches. The private `sdk/typescript/package.json` is scaffolding; publish the root npm artifact only.

Publication needs explicit owner authorization, registry credentials and a reviewed release commit. Use `npm publish` on the root tarball, your PyPI trusted publishing process on the wheel/sdist, `cargo publish` for `agenttrunk`, and `gem push` for the Ruby artifact. Do not run these as part of installation or generation. Go subdirectory module tags must follow `sdk/go/vVERSION`; The root `Package.swift` points to the generated Swift sources, so Swift consumers can use this repository with a reviewed root `vVERSION` tag after release. Never claim `go get` or Swift remote installation works before testing the released reference.

After release, run the manually triggered published-client workflow for npm/Python/Ruby/Rust metadata, install the released artifacts into clean consumers, and test Go/Swift from their actual published sources. The live-client workflow is read-only: it verifies one explicitly selected immutable revision through the public API and emits only status. Credential/provider changes, marketplace submissions and platform deployment remain separate actions.
