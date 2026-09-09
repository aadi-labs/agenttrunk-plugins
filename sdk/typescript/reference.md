# Reference
## Privacy
<details><summary><code>client.privacy.<a href="/src/api/resources/privacy/client/Client.ts">assignReview</a>(trunkId, requestId, { ...params }) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Requires workspace management. Repeating the same assignment is safe; other owners and terminal cases conflict. Does not verify identity or complete fulfillment.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.privacy.assignReview("trunkId", "requestId", {
    "key": "value"
});

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**requestId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `Record<string, unknown>` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `PrivacyClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="/src/api/resources/privacy/client/Client.ts">erasurePlan</a>(trunkId) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Requires workspace management. Counts selected database dependencies; explicitly not executable or a complete provider inventory.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.privacy.erasurePlan("trunkId");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `PrivacyClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="/src/api/resources/privacy/client/Client.ts">list</a>(trunkId) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Requires workspace management. This is not a personal-data export.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.privacy.list("trunkId");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `PrivacyClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="/src/api/resources/privacy/client/Client.ts">create</a>(trunkId, { ...params }) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Requires workspace management. Deduplicates open requests for the authorizing user. Does not export or delete data.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.privacy.create("trunkId", {
    kind: "access"
});

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.CreatePrivacyRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `PrivacyClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Contexts
<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client/Client.ts">export</a>(trunkId, contextKey, { ...params }) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Reads require current context authorization. Includes verified files encoded as base64 and metadata; excludes other history, notes, accounts, logs and backups. Not a complete personal-data export.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contexts.export("trunkId", "contextKey", {
    revisionId: "revisionId"
});

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.ExportContextsRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client/Client.ts">getRollbackPlan</a>(trunkId, contextKey, { ...params }) -> AgentTrunkApi.GetRollbackPlanContextsResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Check whether an immutable revision can be restored to staging. This is advisory; the write rechecks permissions, release evidence, and staging concurrency. Ineligible responses do not expose the current staging revision.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contexts.getRollbackPlan("trunkId", "contextKey", {
    revisionId: "revisionId"
});

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.GetRollbackPlanContextsRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client/Client.ts">stageRollback</a>(trunkId, contextKey, { ...params }) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Restore a previously released immutable revision into staging. Requires production rollback and staging deploy permissions. Production only changes through a subsequent promotion PR.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contexts.stageRollback("trunkId", "contextKey", {
    revisionId: "revisionId",
    expectedStagingRevisionId: "expectedStagingRevisionId",
    reason: "reason"
});

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.StageRollbackContextsRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client/Client.ts">publish</a>(trunkId, { ...params }) -> AgentTrunkApi.PublishContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contexts.publish("trunkId", {
    contextKey: "contextKey",
    title: "title",
    kind: "skill",
    files: [{
            path: "path",
            contentBase64: "contentBase64"
        }]
});

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.PublishInput` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client/Client.ts">share</a>(trunkId, contextKey) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contexts.share("trunkId", "contextKey");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client/Client.ts">discover</a>({ ...params }) -> AgentTrunkApi.DiscoverContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contexts.discover();

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `AgentTrunkApi.DiscoverContextsRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client/Client.ts">inspect</a>(trunkId, contextKey, { ...params }) -> AgentTrunkApi.InspectContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contexts.inspect("trunkId", "contextKey");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.InspectContextsRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client/Client.ts">history</a>(trunkId, contextKey, { ...params }) -> AgentTrunkApi.HistoryContextsResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Follows immutable parent revisions, authorizing every revision. Historic IDs require staging read or shared-context-item read access.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contexts.history("trunkId", "contextKey");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.HistoryContextsRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client/Client.ts">compare</a>(trunkId, contextKey, { ...params }) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Authorizes both revisions and returns their manifests, per-file statuses,
and one selected file preview. Target defaults to latest; base defaults to
the target's parent, or an empty snapshot for the first revision. The
returned IDs are immutable; use them for subsequent file selections.
UTF-8 previews verify file digests and are capped at 128000 bytes per side.
reason is null, too_large, binary, or too_complex. Omitted previews have
empty content and zero counts, which must not be displayed as no changes.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contexts.compare("trunkId", "contextKey");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.CompareContextsRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client/Client.ts">getProvenance</a>(trunkId, contextKey, { ...params }) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contexts.getProvenance("trunkId", "contextKey");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.GetProvenanceContextsRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client/Client.ts">putProvenance</a>(trunkId, contextKey, { ...params }) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Requires revision read and staging environment deployment permission. Author identity is assigned server-side. Does not modify content, channels, or PR approval. Concurrent updates return 409; reread and reconcile, never blindly retry with a newer token.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contexts.putProvenance("trunkId", "contextKey", {
    revisionId: "revisionId",
    text: "text"
});

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.PutProvenanceContextsRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client/Client.ts">readFile</a>(trunkId, contextKey, resourcePath, { ...params }) -> core.BinaryResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contexts.readFile("trunkId", "contextKey", "resourcePath", {
    ref: "ref"
});

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**resourcePath:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.ReadFileContextsRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Billing
<details><summary><code>client.billing.<a href="/src/api/resources/billing/client/Client.ts">get</a>() -> AgentTrunkApi.GetBillingResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Organization subscription and usage summary. Requires billing:read. MCP metering is currently inactive.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.billing.get();

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**requestOptions:** `BillingClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/src/api/resources/billing/client/Client.ts">createCheckout</a>({ ...params }) -> AgentTrunkApi.CreateCheckoutBillingResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Requires billing:manage. Reuses an unexpired checkout; existing subscriptions must use the portal. Body limited to 4096 bytes.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.billing.createCheckout({
    plan: "starter"
});

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `AgentTrunkApi.CreateCheckoutBillingRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `BillingClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/src/api/resources/billing/client/Client.ts">createPortal</a>() -> AgentTrunkApi.CreatePortalBillingResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Requires billing:manage and an existing organization customer.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.billing.createPortal();

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**requestOptions:** `BillingClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/src/api/resources/billing/client/Client.ts">setSpendLimit</a>({ ...params }) -> AgentTrunkApi.SetSpendLimitBillingResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Requires billing:manage. Audited organization overage cap; excludes subscription fees and taxes. Does not activate metering.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.billing.setSpendLimit({
    cents: 1
});

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `AgentTrunkApi.SetSpendLimitBillingRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `BillingClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Health
<details><summary><code>client.health.<a href="/src/api/resources/health/client/Client.ts">get</a>() -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.health.get();

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**requestOptions:** `HealthClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Workspaces
<details><summary><code>client.workspaces.<a href="/src/api/resources/workspaces/client/Client.ts">list</a>({ ...params }) -> AgentTrunkApi.ListWorkspacesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.workspaces.list();

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `AgentTrunkApi.ListWorkspacesRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `WorkspacesClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="/src/api/resources/workspaces/client/Client.ts">create</a>({ ...params }) -> AgentTrunkApi.Trunk</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.workspaces.create({
    name: "name"
});

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `AgentTrunkApi.CreateTrunkInput` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `WorkspacesClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="/src/api/resources/workspaces/client/Client.ts">get</a>(trunkId) -> AgentTrunkApi.Trunk</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.workspaces.get("trunkId");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `WorkspacesClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="/src/api/resources/workspaces/client/Client.ts">audit</a>(trunkId, { ...params }) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.workspaces.audit("trunkId");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.AuditWorkspacesRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `WorkspacesClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Webhooks
<details><summary><code>client.webhooks.<a href="/src/api/resources/webhooks/client/Client.ts">list</a>(trunkId, { ...params }) -> AgentTrunkApi.ListWebhooksResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Requires trunk management permission. Lists at most 50 workspace submission receipts, not endpoint delivery receipts. Pass nextCursor as before until null.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.webhooks.list("trunkId");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.ListWebhooksRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `WebhooksClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/src/api/resources/webhooks/client/Client.ts">createPortal</a>(trunkId) -> AgentTrunkApi.CreatePortalWebhooksResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Requires trunk management permission. Enables future workspace events and returns a one-hour bearer access URL for endpoint configuration, delivery inspection, and replay. Never cache or log the URL. Previously issued links remain valid until expiry.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.webhooks.createPortal("trunkId");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `WebhooksClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/src/api/resources/webhooks/client/Client.ts">retry</a>(trunkId, eventId) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Requires trunk management permission. Requeue a failed provider submission with the same event identity. Accepted messages must be replayed through the Svix portal. Consumers must deduplicate events.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.webhooks.retry("trunkId", "eventId");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**eventId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `WebhooksClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Scopes
<details><summary><code>client.scopes.<a href="/src/api/resources/scopes/client/Client.ts">list</a>(trunkId) -> AgentTrunkApi.ListScopesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.scopes.list("trunkId");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ScopesClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.scopes.<a href="/src/api/resources/scopes/client/Client.ts">create</a>(trunkId, { ...params }) -> AgentTrunkApi.Scope</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.scopes.create("trunkId", {
    name: "name"
});

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.CreateScopesRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ScopesClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## ContextSets
<details><summary><code>client.contextSets.<a href="/src/api/resources/contextSets/client/Client.ts">sources</a>({ ...params }) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Returns up to 20 candidates with current authorization checks and an opaque nextCursor. Snapshots expire after 15 minutes; narrow the scope if the 10000-record or 8 MB snapshot limit is exceeded.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contextSets.sources();

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `AgentTrunkApi.SourcesContextSetsRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextSetsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contextSets.<a href="/src/api/resources/contextSets/client/Client.ts">list</a>({ ...params }) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Snapshot-stable candidates with current WorkOS authorization rechecked on each page. Cursors expire after 15 minutes and are bound to the principal and filters.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contextSets.list();

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `AgentTrunkApi.ListContextSetsRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextSetsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contextSets.<a href="/src/api/resources/contextSets/client/Client.ts">create</a>({ ...params }) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contextSets.create({
    name: "name",
    sources: [{
            sourceTrunkId: "sourceTrunkId",
            sourceScopeId: "sourceScopeId",
            environmentId: "environmentId",
            contextKey: "contextKey",
            revisionId: "revisionId",
            packageDigest: "packageDigest",
            mountPath: "mountPath",
            required: true
        }]
});

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**request:** `AgentTrunkApi.CreateContextSetsRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextSetsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contextSets.<a href="/src/api/resources/contextSets/client/Client.ts">resolve</a>(contextSetId) -> Record&lt;string, unknown&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.contextSets.resolve("contextSetId");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**contextSetId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ContextSetsClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Releases
<details><summary><code>client.releases.<a href="/src/api/resources/releases/client/Client.ts">list</a>(trunkId, { ...params }) -> AgentTrunkApi.ListReleasesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.releases.list("trunkId");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.ListReleasesRequest` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ReleasesClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.releases.<a href="/src/api/resources/releases/client/Client.ts">open</a>(trunkId, { ...params }) -> AgentTrunkApi.PromotionRequest</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.releases.open("trunkId");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `AgentTrunkApi.OpenPromotionRequestInput` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ReleasesClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.releases.<a href="/src/api/resources/releases/client/Client.ts">merge</a>(trunkId, promotionId) -> AgentTrunkApi.PromotionRequest</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```typescript
await client.releases.merge("trunkId", "promotionId");

```
</dd>
</dl>
</dd>
</dl>

#### ⚙️ Parameters

<dl>
<dd>

<dl>
<dd>

**trunkId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**promotionId:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**requestOptions:** `ReleasesClient.RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

