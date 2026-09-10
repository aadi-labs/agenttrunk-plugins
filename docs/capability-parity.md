# Agent workflow parity

Local source readiness is separate from publication, provider configuration, and
hosted acceptance. Do not infer the latter from generated operation counts.

- [x] Six generated SDKs cover the reviewed 38 public REST operations.
- [x] Generic CLI exposes those operations with explicit mutation gates.
- [x] Incremental staging edits, expected-revision conflicts, docs in six languages.
- [x] CLI and TypeScript agent discovery, human claim, exchange and refresh.
- [x] Native auth helpers in Python, Go, Rust, Ruby and Swift (local implementation).
- [x] Skill download, local drift detection and explicit incremental push.
- [x] Workspace UI action routes checked against public contracts (scope below).
- [x] Documented local sign-out versus server-side revocation lifecycle.
- [ ] Fresh hosted human approval, organization onboarding, upload/edit/read/release acceptance.

Operational MCP has a local platform implementation with 38 named, typed tools.
Clients own discovery and composition. Deployment and authenticated client acceptance remain gates.
Documentation MCP must never be presented as an operational connection.

Skill sync must bind origin/workspace/context/revision, verify file digests, never
execute fetched skills, reject unsafe paths and symlinks, and fail on drift. A
successful upload followed by a lost response requires inspection, not automatic
resubmission. Production promotion remains separate.

## Workspace action audit

The current `trunk`, `revisions`, `upload`, `new-trunk`, `context-sets`, and
`webhooks` route actions call the public API for workspace/scope creation,
publication, promotion requests/merges, rollback, provenance, privacy intake and
review, context-set creation, and webhook portal/retry. Generated clients cover
these contracts. A portal URL still opens an interactive management UI; it is
not a programmatic replacement for every action inside that provider portal.

This does not assert feature parity with every historical idea: direct workspace
deletion, arbitrary membership administration, server-side
credential revocation, automatic merging, and background harness installation
are not established by this audit. Do not advertise unsupported operations.

## Verification boundary

Auth wire tests exist for TypeScript, Python, Go and Ruby. Rust has authority and
credential validation tests; Swift builds and passes existing SDK safety tests.
Neither proves a real hosted approval in those languages. All registry releases,
hosted authentication acceptance, and deployment checks remain release gates.
