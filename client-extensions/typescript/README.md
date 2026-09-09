# AgentTrunk TypeScript SDK (Fern)

The public npm package is built from the repository root as `@agenttrunk/sdk`. This directory is Fern's generated source and development scaffolding; do not publish a second competing npm package from here. Registry publication has not been performed.

```sh
# In the repository root:
npm ci
npm run build
npm pack
# Install the resulting root tarball into your application.
```

```ts
import { AgentTrunkClient } from '@agenttrunk/sdk';
const client = new AgentTrunkClient({
  accessToken: () => process.env.AGENTTRUNK_ACCESS_TOKEN ?? '',
  timeoutInSeconds: 20,
});
const page = await client.workspaces.list();
// Select the intended workspace; continue page.nextCursor even after an empty page.
```

Resource groups: `workspaces`, `scopes`, `contexts`, `releases`, `contextSets`, `webhooks`, `billing`, `privacy`, `health`. See [generated method reference](reference.md). Operations whose upstream contract leaves response fields unspecified return flexible JSON objects; the generator does not fabricate a typed model for them.

`AgentTrunkClient` is the complete generated REST surface. The existing `AgentTrunk` export is a separate convenience API used by the CLI: its `readFile` verifies SHA-256 and size against an inspected manifest. Use it when consuming context. Generated `contexts.readFile` requires an immutable `ref` and returns a bounded binary response, but does not itself compare the bytes against a manifest.

Default HTTP retries are zero. Writes are never retried even if `maxRetries` is set for reads. The transport rejects redirects, insecure non-loopback URLs, missing bearer tokens on `/v1/` and unpinned file reads. Responses are bounded to 1,000,000 file bytes or 24,000,000 JSON bytes. HTTP errors omit provider bodies; inspect `statusCode` and sanitized `requestId`. Custom fetch implementations must honor `redirect: 'error'` and abort signals. This is a server/runtime SDK; do not expose tokens in browser bundles.

Credentials are short-lived access tokens from the authorized runtime; no signup, credential issuer or token refresh workflow is generated. `accessToken` accepts a string or sync/async supplier evaluated per request. `baseUrl` overrides where credentials are sent; use only a trusted origin, without `/v1`. Publication creates complete staging revisions; `releases.merge` changes production and requires the user's authorization for the reviewed scope snapshot.

Changes to generated code come from `fern/openapi`, `scripts/sync-openapi.mjs`, `scripts/postprocess-sdks.mjs` and `client-extensions/`, followed by `npm run sdk:generate`. Do not edit generated methods directly.
