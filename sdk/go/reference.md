# Reference
## Privacy
<details><summary><code>client.Privacy.AssignReview(TrunkID, RequestID, request) -> map[string]any</code></summary>
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

```go
request := map[string]any{
    "key": "value",
}
client.Privacy.AssignReview(
    context.TODO(),
    "trunkId",
    "requestId",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**requestID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `map[string]any` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Privacy.ErasurePlan(TrunkID) -> map[string]any</code></summary>
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

```go
client.Privacy.ErasurePlan(
    context.TODO(),
    "trunkId",
)
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

**trunkID:** `string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Privacy.List(TrunkID) -> map[string]any</code></summary>
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

```go
client.Privacy.List(
    context.TODO(),
    "trunkId",
)
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

**trunkID:** `string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Privacy.Create(TrunkID, request) -> map[string]any</code></summary>
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

```go
request := &_go.CreatePrivacyRequest{
    Kind: _go.CreatePrivacyRequestKindAccess,
}
client.Privacy.Create(
    context.TODO(),
    "trunkId",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**kind:** `*_go.CreatePrivacyRequestKind` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Contexts
<details><summary><code>client.Contexts.Export(TrunkID, ContextKey) -> map[string]any</code></summary>
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

```go
request := &_go.ExportContextsRequest{
    RevisionID: "revisionId",
}
client.Contexts.Export(
    context.TODO(),
    "trunkId",
    "contextKey",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**revisionID:** `string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Contexts.GetRollbackPlan(TrunkID, ContextKey) -> *_go.GetRollbackPlanContextsResponse</code></summary>
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

```go
request := &_go.GetRollbackPlanContextsRequest{
    RevisionID: "revisionId",
}
client.Contexts.GetRollbackPlan(
    context.TODO(),
    "trunkId",
    "contextKey",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**revisionID:** `string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Contexts.StageRollback(TrunkID, ContextKey, request) -> map[string]any</code></summary>
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

```go
request := &_go.StageRollbackContextsRequest{
    RevisionID: "revisionId",
    ExpectedStagingRevisionID: "expectedStagingRevisionId",
    Reason: "reason",
}
client.Contexts.StageRollback(
    context.TODO(),
    "trunkId",
    "contextKey",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**revisionID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**expectedStagingRevisionID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**reason:** `string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Contexts.Publish(TrunkID, request) -> *_go.PublishContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
request := &_go.PublishInput{
    ContextKey: "contextKey",
    Title: "title",
    Kind: _go.ContextKindSkill,
    Files: []*_go.FileInput{
        &_go.FileInput{
            Path: "path",
            ContentBase64: "contentBase64",
        },
    },
}
client.Contexts.Publish(
    context.TODO(),
    "trunkId",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**title:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**summary:** `*string` 
    
</dd>
</dl>

<dl>
<dd>

**kind:** `*_go.ContextKind` 
    
</dd>
</dl>

<dl>
<dd>

**tags:** `[]string` 
    
</dd>
</dl>

<dl>
<dd>

**files:** `[]*_go.FileInput` 
    
</dd>
</dl>

<dl>
<dd>

**claimedDigest:** `*string` 
    
</dd>
</dl>

<dl>
<dd>

**scopeID:** `*string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Contexts.Share(TrunkID, ContextKey) -> map[string]any</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
client.Contexts.Share(
    context.TODO(),
    "trunkId",
    "contextKey",
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Contexts.Discover() -> *_go.DiscoverContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
request := &_go.DiscoverContextsRequest{}
client.Contexts.Discover(
    context.TODO(),
    request,
)
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

**scopeID:** `*string` — Filter by scope before applying the result limit.
    
</dd>
</dl>

<dl>
<dd>

**cursor:** `*string` — Opaque snapshot continuation returned by the preceding page. Keep filters and principal unchanged; cursors expire after 15 minutes. Authorization is always rechecked. Restart pagination for expired or legacy numeric cursors.
    
</dd>
</dl>

<dl>
<dd>

**trunkID:** `*string` — Narrow discovery to this authorized trunk before applying the result limit.
    
</dd>
</dl>

<dl>
<dd>

**query:** `*string` 
    
</dd>
</dl>

<dl>
<dd>

**channel:** `*_go.DiscoverContextsRequestChannel` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `*int` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Contexts.Inspect(TrunkID, ContextKey) -> *_go.InspectContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
request := &_go.InspectContextsRequest{}
client.Contexts.Inspect(
    context.TODO(),
    "trunkId",
    "contextKey",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**ref:** `*string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Contexts.History(TrunkID, ContextKey) -> *_go.HistoryContextsResponse</code></summary>
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

```go
request := &_go.HistoryContextsRequest{}
client.Contexts.History(
    context.TODO(),
    "trunkId",
    "contextKey",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**from:** `*string` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `*int` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Contexts.Compare(TrunkID, ContextKey) -> map[string]any</code></summary>
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

```go
request := &_go.CompareContextsRequest{}
client.Contexts.Compare(
    context.TODO(),
    "trunkId",
    "contextKey",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**base:** `*string` 
    
</dd>
</dl>

<dl>
<dd>

**target:** `*string` 
    
</dd>
</dl>

<dl>
<dd>

**path:** `*string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Contexts.GetProvenance(TrunkID, ContextKey) -> map[string]any</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
request := &_go.GetProvenanceContextsRequest{}
client.Contexts.GetProvenance(
    context.TODO(),
    "trunkId",
    "contextKey",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**ref:** `*string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Contexts.PutProvenance(TrunkID, ContextKey, request) -> map[string]any</code></summary>
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

```go
request := &_go.PutProvenanceContextsRequest{
    RevisionID: "revisionId",
    Text: "text",
}
client.Contexts.PutProvenance(
    context.TODO(),
    "trunkId",
    "contextKey",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**contextKey:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**revisionID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**text:** `string` — Maximum 16000 UTF-8 bytes; not 16000 arbitrary Unicode characters.
    
</dd>
</dl>

<dl>
<dd>

**expectedNotesCommitSha:** `*string` — Null for the first note; otherwise the notesCommitSha returned by GET.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Contexts.ReadFile(TrunkID, ContextKey, ResourcePath) -> string</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
request := &_go.ReadFileContextsRequest{
    Ref: "ref",
}
client.Contexts.ReadFile(
    context.TODO(),
    "trunkId",
    "contextKey",
    "resourcePath",
    request,
)
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

**trunkID:** `string` 
    
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

**ref:** `string` — Immutable revision ID from inspect; resolve moving channels before reading.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Billing
<details><summary><code>client.Billing.Get() -> *_go.GetBillingResponse</code></summary>
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

```go
client.Billing.Get(
    context.TODO(),
)
```
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Billing.CreateCheckout(request) -> *_go.CreateCheckoutBillingResponse</code></summary>
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

```go
request := &_go.CreateCheckoutBillingRequest{
    Plan: _go.CreateCheckoutBillingRequestPlanStarter,
}
client.Billing.CreateCheckout(
    context.TODO(),
    request,
)
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

**plan:** `*_go.CreateCheckoutBillingRequestPlan` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Billing.CreatePortal() -> *_go.CreatePortalBillingResponse</code></summary>
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

```go
client.Billing.CreatePortal(
    context.TODO(),
)
```
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Billing.SetSpendLimit(request) -> *_go.SetSpendLimitBillingResponse</code></summary>
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

```go
request := &_go.SetSpendLimitBillingRequest{
    Cents: 1,
}
client.Billing.SetSpendLimit(
    context.TODO(),
    request,
)
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

**cents:** `int` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Health
<details><summary><code>client.Health.Get() -> map[string]any</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
client.Health.Get(
    context.TODO(),
)
```
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Workspaces
<details><summary><code>client.Workspaces.List() -> *_go.ListWorkspacesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
request := &_go.ListWorkspacesRequest{}
client.Workspaces.List(
    context.TODO(),
    request,
)
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

**cursor:** `*string` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `*string` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `*int` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Workspaces.Create(request) -> *_go.Trunk</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
request := &_go.CreateTrunkInput{
    Name: "name",
}
client.Workspaces.Create(
    context.TODO(),
    request,
)
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

**name:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**description:** `*string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Workspaces.Get(TrunkID) -> *_go.Trunk</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
client.Workspaces.Get(
    context.TODO(),
    "trunkId",
)
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

**trunkID:** `string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Workspaces.Audit(TrunkID) -> map[string]any</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
request := &_go.AuditWorkspacesRequest{}
client.Workspaces.Audit(
    context.TODO(),
    "trunkId",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `*int` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Webhooks
<details><summary><code>client.Webhooks.List(TrunkID) -> *_go.ListWebhooksResponse</code></summary>
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

```go
request := &_go.ListWebhooksRequest{}
client.Webhooks.List(
    context.TODO(),
    "trunkId",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**before:** `*string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Webhooks.CreatePortal(TrunkID) -> *_go.CreatePortalWebhooksResponse</code></summary>
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

```go
client.Webhooks.CreatePortal(
    context.TODO(),
    "trunkId",
)
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

**trunkID:** `string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Webhooks.Retry(TrunkID, EventID) -> map[string]any</code></summary>
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

```go
client.Webhooks.Retry(
    context.TODO(),
    "trunkId",
    "eventId",
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**eventID:** `string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Scopes
<details><summary><code>client.Scopes.List(TrunkID) -> *_go.ListScopesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
client.Scopes.List(
    context.TODO(),
    "trunkId",
)
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

**trunkID:** `string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Scopes.Create(TrunkID, request) -> *_go.Scope</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
request := &_go.CreateScopesRequest{
    Name: "name",
}
client.Scopes.Create(
    context.TODO(),
    "trunkId",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**slug:** `*string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## ContextSets
<details><summary><code>client.ContextSets.Sources() -> map[string]any</code></summary>
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

```go
request := &_go.SourcesContextSetsRequest{}
client.ContextSets.Sources(
    context.TODO(),
    request,
)
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

**cursor:** `*string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.ContextSets.List() -> map[string]any</code></summary>
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

```go
request := &_go.ListContextSetsRequest{}
client.ContextSets.List(
    context.TODO(),
    request,
)
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

**cursor:** `*string` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `*int` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.ContextSets.Create(request) -> map[string]any</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
request := &_go.CreateContextSetsRequest{
    Name: "name",
    Sources: []*_go.ContextSetSource{
        &_go.ContextSetSource{
            SourceTrunkID: "sourceTrunkId",
            SourceScopeID: "sourceScopeId",
            EnvironmentID: "environmentId",
            ContextKey: "contextKey",
            RevisionID: "revisionId",
            PackageDigest: "packageDigest",
            MountPath: "mountPath",
            Required: true,
        },
    },
}
client.ContextSets.Create(
    context.TODO(),
    request,
)
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

**name:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**sources:** `[]*_go.ContextSetSource` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.ContextSets.Resolve(ContextSetID) -> map[string]any</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
client.ContextSets.Resolve(
    context.TODO(),
    "contextSetId",
)
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

**contextSetID:** `string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Releases
<details><summary><code>client.Releases.List(TrunkID) -> *_go.ListReleasesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
request := &_go.ListReleasesRequest{}
client.Releases.List(
    context.TODO(),
    "trunkId",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**cursor:** `*string` 
    
</dd>
</dl>

<dl>
<dd>

**scopeID:** `*string` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `*_go.ListReleasesRequestStatus` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `*int` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Releases.Open(TrunkID, request) -> *_go.PromotionRequest</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
request := &_go.OpenPromotionRequestInput{}
client.Releases.Open(
    context.TODO(),
    "trunkId",
    request,
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**evidenceReference:** `*string` 
    
</dd>
</dl>

<dl>
<dd>

**scopeID:** `*string` — Defaults to the trunk General scope.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.Releases.Merge(TrunkID, PromotionID) -> *_go.PromotionRequest</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```go
client.Releases.Merge(
    context.TODO(),
    "trunkId",
    "promotionId",
)
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

**trunkID:** `string` 
    
</dd>
</dl>

<dl>
<dd>

**promotionID:** `string` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

