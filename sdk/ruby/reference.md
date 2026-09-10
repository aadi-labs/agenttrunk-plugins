# Reference
## Privacy
<details><summary><code>client.privacy.<a href="/lib/AgentTrunk/privacy/client.rb">assign_review</a>(trunk_id:, request_id:, request) -> Internal::Types::Hash[String, Object]</code></summary>
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

```ruby
client.privacy.assign_review(
  trunk_id: "trunkId",
  request_id: "requestId",
  request: {
    key: "value"
  }
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `Internal::Types::Hash[String, Object]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Privacy::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="/lib/AgentTrunk/privacy/client.rb">erasure_plan</a>(trunk_id:) -> Internal::Types::Hash[String, Object]</code></summary>
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

```ruby
client.privacy.erasure_plan(trunk_id: "trunkId")
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Privacy::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="/lib/AgentTrunk/privacy/client.rb">list</a>(trunk_id:) -> Internal::Types::Hash[String, Object]</code></summary>
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

```ruby
client.privacy.list(trunk_id: "trunkId")
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Privacy::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="/lib/AgentTrunk/privacy/client.rb">create</a>(trunk_id:, request) -> Internal::Types::Hash[String, Object]</code></summary>
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

```ruby
client.privacy.create(
  trunk_id: "trunkId",
  kind: "access"
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**kind:** `AgentTrunk::Privacy::Types::CreatePrivacyRequestKind` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Privacy::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Contexts
<details><summary><code>client.contexts.<a href="/lib/AgentTrunk/contexts/client.rb">export</a>(trunk_id:, context_key:) -> Internal::Types::Hash[String, Object]</code></summary>
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

```ruby
client.contexts.export(
  trunk_id: "trunkId",
  context_key: "contextKey",
  revision_id: "revisionId"
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**revision_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Contexts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/lib/AgentTrunk/contexts/client.rb">get_rollback_plan</a>(trunk_id:, context_key:) -> AgentTrunk::Contexts::Types::GetRollbackPlanContextsResponse</code></summary>
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

```ruby
client.contexts.get_rollback_plan(
  trunk_id: "trunkId",
  context_key: "contextKey",
  revision_id: "revisionId"
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**revision_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Contexts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/lib/AgentTrunk/contexts/client.rb">stage_rollback</a>(trunk_id:, context_key:, request) -> Internal::Types::Hash[String, Object]</code></summary>
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

```ruby
client.contexts.stage_rollback(
  trunk_id: "trunkId",
  context_key: "contextKey",
  revision_id: "revisionId",
  expected_staging_revision_id: "expectedStagingRevisionId",
  reason: "reason"
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**revision_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**expected_staging_revision_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**reason:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Contexts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/lib/AgentTrunk/contexts/client.rb">publish</a>(trunk_id:, request) -> AgentTrunk::Contexts::Types::PublishContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.contexts.publish(
  trunk_id: "trunkId",
  context_key: "contextKey",
  title: "title",
  kind: "skill",
  files: [{
    path: "path",
    content_base64: "contentBase64"
  }]
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**title:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**summary:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**kind:** `AgentTrunk::Types::ContextKind` 
    
</dd>
</dl>

<dl>
<dd>

**tags:** `Internal::Types::Array[String]` 
    
</dd>
</dl>

<dl>
<dd>

**files:** `Internal::Types::Array[AgentTrunk::Types::FileInput]` 
    
</dd>
</dl>

<dl>
<dd>

**claimed_digest:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**scope_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Contexts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/lib/AgentTrunk/contexts/client.rb">share</a>(trunk_id:, context_key:) -> Internal::Types::Hash[String, Object]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.contexts.share(
  trunk_id: "trunkId",
  context_key: "contextKey"
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Contexts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/lib/AgentTrunk/contexts/client.rb">discover</a>() -> AgentTrunk::Contexts::Types::DiscoverContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.contexts.discover
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

**scope_id:** `String` — Filter by scope before applying the result limit.
    
</dd>
</dl>

<dl>
<dd>

**cursor:** `String` — Opaque snapshot continuation returned by the preceding page. Keep filters and principal unchanged; cursors expire after 15 minutes. Authorization is always rechecked. Restart pagination for expired or legacy numeric cursors.
    
</dd>
</dl>

<dl>
<dd>

**trunk_id:** `String` — Narrow discovery to this authorized trunk before applying the result limit.
    
</dd>
</dl>

<dl>
<dd>

**query:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**channel:** `AgentTrunk::Contexts::Types::DiscoverContextsRequestChannel` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Contexts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/lib/AgentTrunk/contexts/client.rb">inspect</a>(trunk_id:, context_key:) -> AgentTrunk::Contexts::Types::InspectContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.contexts.inspect(
  trunk_id: "trunkId",
  context_key: "contextKey"
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**ref:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Contexts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/lib/AgentTrunk/contexts/client.rb">edit</a>(trunk_id:, context_key:, request) -> AgentTrunk::Contexts::Types::EditContextsResponse</code></summary>
<dl>
<dd>

#### 📝 Description

<dl>
<dd>

<dl>
<dd>

Atomically add, replace, or delete files in staging, preserving metadata and unchanged files.
Requires staging read and deployment permission. expectedRevisionId must equal the current
staging revision. Concurrent branch changes return 409; reread and reconcile, never blindly
retry. Production is unchanged. The resulting package retains the 256-file, 1 MB per-file,
and 16 MB total limits and must not be empty. Each path may appear once. Deleting a missing
file is invalid. Identical content is a no-op; restoring historical content uses rollback.
</dd>
</dl>
</dd>
</dl>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.contexts.edit(
  trunk_id: "trunkId",
  context_key: "contextKey",
  expected_revision_id: "expectedRevisionId",
  changes: []
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**expected_revision_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**changes:** `Internal::Types::Array[AgentTrunk::Contexts::Types::EditContextInputChangesItem]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Contexts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/lib/AgentTrunk/contexts/client.rb">history</a>(trunk_id:, context_key:) -> AgentTrunk::Contexts::Types::HistoryContextsResponse</code></summary>
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

```ruby
client.contexts.history(
  trunk_id: "trunkId",
  context_key: "contextKey"
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**from:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Contexts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/lib/AgentTrunk/contexts/client.rb">compare</a>(trunk_id:, context_key:) -> Internal::Types::Hash[String, Object]</code></summary>
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

```ruby
client.contexts.compare(
  trunk_id: "trunkId",
  context_key: "contextKey"
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**base:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**target:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**path:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Contexts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/lib/AgentTrunk/contexts/client.rb">get_provenance</a>(trunk_id:, context_key:) -> Internal::Types::Hash[String, Object]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.contexts.get_provenance(
  trunk_id: "trunkId",
  context_key: "contextKey"
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**ref:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Contexts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/lib/AgentTrunk/contexts/client.rb">put_provenance</a>(trunk_id:, context_key:, request) -> Internal::Types::Hash[String, Object]</code></summary>
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

```ruby
client.contexts.put_provenance(
  trunk_id: "trunkId",
  context_key: "contextKey",
  revision_id: "revisionId",
  text: "text"
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**revision_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**text:** `String` — Maximum 16000 UTF-8 bytes; not 16000 arbitrary Unicode characters.
    
</dd>
</dl>

<dl>
<dd>

**expected_notes_commit_sha:** `String` — Null for the first note; otherwise the notesCommitSha returned by GET.
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Contexts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/lib/AgentTrunk/contexts/client.rb">read_file</a>(trunk_id:, context_key:, resource_path:) -> String</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.contexts.read_file(
  trunk_id: "trunkId",
  context_key: "contextKey",
  resource_path: "resourcePath",
  ref: "ref"
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**resource_path:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**ref:** `String` — Immutable revision ID from inspect; resolve moving channels before reading.
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Contexts::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Billing
<details><summary><code>client.billing.<a href="/lib/AgentTrunk/billing/client.rb">get</a>() -> AgentTrunk::Billing::Types::GetBillingResponse</code></summary>
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

```ruby
client.billing.get
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

**request_options:** `AgentTrunk::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/AgentTrunk/billing/client.rb">create_checkout</a>(request) -> AgentTrunk::Billing::Types::CreateCheckoutBillingResponse</code></summary>
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

```ruby
client.billing.create_checkout(plan: "starter")
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

**plan:** `AgentTrunk::Billing::Types::CreateCheckoutBillingRequestPlan` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/AgentTrunk/billing/client.rb">create_portal</a>() -> AgentTrunk::Billing::Types::CreatePortalBillingResponse</code></summary>
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

```ruby
client.billing.create_portal
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

**request_options:** `AgentTrunk::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/lib/AgentTrunk/billing/client.rb">set_spend_limit</a>(request) -> AgentTrunk::Billing::Types::SetSpendLimitBillingResponse</code></summary>
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

```ruby
client.billing.set_spend_limit(cents: 1)
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

**cents:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Billing::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Health
<details><summary><code>client.health.<a href="/lib/AgentTrunk/health/client.rb">get</a>() -> Internal::Types::Hash[String, Object]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.health.get
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

**request_options:** `AgentTrunk::Health::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Workspaces
<details><summary><code>client.workspaces.<a href="/lib/AgentTrunk/workspaces/client.rb">list</a>() -> AgentTrunk::Workspaces::Types::ListWorkspacesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.workspaces.list
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

**cursor:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Workspaces::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="/lib/AgentTrunk/workspaces/client.rb">create</a>(request) -> AgentTrunk::Types::Trunk</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.workspaces.create(name: "name")
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

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**description:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Workspaces::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="/lib/AgentTrunk/workspaces/client.rb">get</a>(trunk_id:) -> AgentTrunk::Types::Trunk</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.workspaces.get(trunk_id: "trunkId")
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Workspaces::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="/lib/AgentTrunk/workspaces/client.rb">audit</a>(trunk_id:) -> Internal::Types::Hash[String, Object]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.workspaces.audit(trunk_id: "trunkId")
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Workspaces::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Webhooks
<details><summary><code>client.webhooks.<a href="/lib/AgentTrunk/webhooks/client.rb">list</a>(trunk_id:) -> AgentTrunk::Webhooks::Types::ListWebhooksResponse</code></summary>
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

```ruby
client.webhooks.list(trunk_id: "trunkId")
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**before:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Webhooks::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/lib/AgentTrunk/webhooks/client.rb">create_portal</a>(trunk_id:) -> AgentTrunk::Webhooks::Types::CreatePortalWebhooksResponse</code></summary>
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

```ruby
client.webhooks.create_portal(trunk_id: "trunkId")
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Webhooks::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/lib/AgentTrunk/webhooks/client.rb">retry_</a>(trunk_id:, event_id:) -> Internal::Types::Hash[String, Object]</code></summary>
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

```ruby
client.webhooks.retry_(
  trunk_id: "trunkId",
  event_id: "eventId"
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**event_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Webhooks::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Scopes
<details><summary><code>client.scopes.<a href="/lib/AgentTrunk/scopes/client.rb">list</a>(trunk_id:) -> AgentTrunk::Scopes::Types::ListScopesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.scopes.list(trunk_id: "trunkId")
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Scopes::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.scopes.<a href="/lib/AgentTrunk/scopes/client.rb">create</a>(trunk_id:, request) -> AgentTrunk::Types::Scope</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.scopes.create(
  trunk_id: "trunkId",
  name: "name"
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**slug:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Scopes::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## ContextSets
<details><summary><code>client.context_sets.<a href="/lib/AgentTrunk/context_sets/client.rb">sources</a>() -> Internal::Types::Hash[String, Object]</code></summary>
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

```ruby
client.context_sets.sources
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

**cursor:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::ContextSets::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.context_sets.<a href="/lib/AgentTrunk/context_sets/client.rb">list</a>() -> Internal::Types::Hash[String, Object]</code></summary>
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

```ruby
client.context_sets.list
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

**cursor:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::ContextSets::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.context_sets.<a href="/lib/AgentTrunk/context_sets/client.rb">create</a>(request) -> Internal::Types::Hash[String, Object]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.context_sets.create(
  name: "name",
  sources: [{
    source_trunk_id: "sourceTrunkId",
    source_scope_id: "sourceScopeId",
    environment_id: "environmentId",
    context_key: "contextKey",
    revision_id: "revisionId",
    package_digest: "packageDigest",
    mount_path: "mountPath",
    required: true
  }]
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

**name:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**sources:** `Internal::Types::Array[AgentTrunk::Types::ContextSetSource]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::ContextSets::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.context_sets.<a href="/lib/AgentTrunk/context_sets/client.rb">resolve</a>(context_set_id:) -> Internal::Types::Hash[String, Object]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.context_sets.resolve(context_set_id: "contextSetId")
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

**context_set_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::ContextSets::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Releases
<details><summary><code>client.releases.<a href="/lib/AgentTrunk/releases/client.rb">list</a>(trunk_id:) -> AgentTrunk::Releases::Types::ListReleasesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.releases.list(trunk_id: "trunkId")
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**cursor:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**scope_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `AgentTrunk::Releases::Types::ListReleasesRequestStatus` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Integer` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Releases::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.releases.<a href="/lib/AgentTrunk/releases/client.rb">open</a>(trunk_id:, request) -> AgentTrunk::Types::PromotionRequest</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.releases.open(trunk_id: "trunkId")
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**evidence_reference:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**scope_id:** `String` — Defaults to the trunk General scope.
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Releases::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.releases.<a href="/lib/AgentTrunk/releases/client.rb">merge</a>(trunk_id:, promotion_id:) -> AgentTrunk::Types::PromotionRequest</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```ruby
client.releases.merge(
  trunk_id: "trunkId",
  promotion_id: "promotionId"
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

**trunk_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**promotion_id:** `String` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `AgentTrunk::Releases::RequestOptions` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

