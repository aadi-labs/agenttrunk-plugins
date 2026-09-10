# Reference
## Privacy
<details><summary><code>client.privacy.<a href="/src/api/resources/privacy/client.rs">assign_review</a>(trunk_id: String, request_id: String, request: std::collections::HashMap&lt;String, serde_json::Value&gt;) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .privacy
        .assign_review(
            &"trunkId".to_string(),
            &"requestId".to_string(),
            &HashMap::from([("key".to_string(), serde_json::json!("value"))]),
            None,
        )
        .await;
}
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
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="/src/api/resources/privacy/client.rs">erasure_plan</a>(trunk_id: String) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .privacy
        .erasure_plan(&"trunkId".to_string(), None)
        .await;
}
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
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="/src/api/resources/privacy/client.rs">list</a>(trunk_id: String) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client.privacy.list(&"trunkId".to_string(), None).await;
}
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
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="/src/api/resources/privacy/client.rs">create</a>(trunk_id: String, request: CreatePrivacyRequest) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .privacy
        .create(
            &"trunkId".to_string(),
            &CreatePrivacyRequest {
                kind: CreatePrivacyRequestKind::Access,
            },
            None,
        )
        .await;
}
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

**kind:** `CreatePrivacyRequestKind` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Contexts
<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client.rs">export</a>(trunk_id: String, context_key: String, revision_id: Option&lt;String&gt;) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .contexts
        .export(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &ExportQueryRequest {
                revision_id: "revisionId".to_string(),
            },
            None,
        )
        .await;
}
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
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client.rs">get_rollback_plan</a>(trunk_id: String, context_key: String, revision_id: Option&lt;String&gt;) -> Result&lt;GetRollbackPlanContextsResponse, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .contexts
        .get_rollback_plan(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &GetRollbackPlanQueryRequest {
                revision_id: "revisionId".to_string(),
            },
            None,
        )
        .await;
}
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
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client.rs">stage_rollback</a>(trunk_id: String, context_key: String, request: StageRollbackContextsRequest) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .contexts
        .stage_rollback(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &StageRollbackContextsRequest {
                revision_id: "revisionId".to_string(),
                expected_staging_revision_id: "expectedStagingRevisionId".to_string(),
                reason: "reason".to_string(),
            },
            None,
        )
        .await;
}
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
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client.rs">publish</a>(trunk_id: String, request: PublishInput) -> Result&lt;PublishContextsResponse, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .contexts
        .publish(
            &"trunkId".to_string(),
            &PublishInput {
                context_key: "contextKey".to_string(),
                title: "title".to_string(),
                kind: ContextKind::Skill,
                files: vec![FileInput {
                    path: "path".to_string(),
                    content_base64: "contentBase64".to_string(),
                    ..Default::default()
                }],
                summary: None,
                tags: None,
                claimed_digest: None,
                scope_id: None,
            },
            None,
        )
        .await;
}
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

**summary:** `Option<String>` 
    
</dd>
</dl>

<dl>
<dd>

**kind:** `ContextKind` 
    
</dd>
</dl>

<dl>
<dd>

**tags:** `Option<Vec<String>>` 
    
</dd>
</dl>

<dl>
<dd>

**files:** `Vec<FileInput>` 
    
</dd>
</dl>

<dl>
<dd>

**claimed_digest:** `Option<String>` 
    
</dd>
</dl>

<dl>
<dd>

**scope_id:** `Option<String>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client.rs">share</a>(trunk_id: String, context_key: String) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .contexts
        .share(&"trunkId".to_string(), &"contextKey".to_string(), None)
        .await;
}
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
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client.rs">discover</a>(scope_id: Option&lt;Option&lt;String&gt;&gt;, cursor: Option&lt;Option&lt;String&gt;&gt;, trunk_id: Option&lt;Option&lt;String&gt;&gt;, query: Option&lt;Option&lt;String&gt;&gt;, channel: Option&lt;Option&lt;DiscoverContextsRequestChannel&gt;&gt;, limit: Option&lt;Option&lt;i64&gt;&gt;) -> Result&lt;DiscoverContextsResponse, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .contexts
        .discover(
            &DiscoverQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;
}
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

**scope_id:** `Option<String>` — Filter by scope before applying the result limit.
    
</dd>
</dl>

<dl>
<dd>

**cursor:** `Option<String>` — Opaque snapshot continuation returned by the preceding page. Keep filters and principal unchanged; cursors expire after 15 minutes. Authorization is always rechecked. Restart pagination for expired or legacy numeric cursors.
    
</dd>
</dl>

<dl>
<dd>

**trunk_id:** `Option<String>` — Narrow discovery to this authorized trunk before applying the result limit.
    
</dd>
</dl>

<dl>
<dd>

**query:** `Option<String>` 
    
</dd>
</dl>

<dl>
<dd>

**channel:** `Option<DiscoverContextsRequestChannel>` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Option<i64>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client.rs">inspect</a>(trunk_id: String, context_key: String, ref_: Option&lt;Option&lt;String&gt;&gt;) -> Result&lt;InspectContextsResponse, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .contexts
        .inspect(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &InspectQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;
}
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

**ref_:** `Option<String>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client.rs">edit</a>(trunk_id: String, context_key: String, request: EditContextInput) -> Result&lt;EditContextsResponse, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .contexts
        .edit(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &EditContextInput {
                expected_revision_id: "expectedRevisionId".to_string(),
                changes: vec![EditContextInputChangesItem::put("path".to_string(), "contentBase64".to_string())],
            },
            None,
        )
        .await;
}
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

**changes:** `Vec<EditContextInputChangesItem>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client.rs">history</a>(trunk_id: String, context_key: String, from: Option&lt;Option&lt;String&gt;&gt;, limit: Option&lt;Option&lt;i64&gt;&gt;) -> Result&lt;HistoryContextsResponse, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .contexts
        .history(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &HistoryQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;
}
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

**from:** `Option<String>` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Option<i64>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client.rs">compare</a>(trunk_id: String, context_key: String, base: Option&lt;Option&lt;String&gt;&gt;, target: Option&lt;Option&lt;String&gt;&gt;, path: Option&lt;Option&lt;String&gt;&gt;) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .contexts
        .compare(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &CompareQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;
}
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

**base:** `Option<String>` 
    
</dd>
</dl>

<dl>
<dd>

**target:** `Option<String>` 
    
</dd>
</dl>

<dl>
<dd>

**path:** `Option<String>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client.rs">get_provenance</a>(trunk_id: String, context_key: String, ref_: Option&lt;Option&lt;String&gt;&gt;) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .contexts
        .get_provenance(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &GetProvenanceQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;
}
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

**ref_:** `Option<String>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client.rs">put_provenance</a>(trunk_id: String, context_key: String, request: PutProvenanceContextsRequest) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .contexts
        .put_provenance(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &PutProvenanceContextsRequest {
                revision_id: "revisionId".to_string(),
                text: "text".to_string(),
                expected_notes_commit_sha: None,
            },
            None,
        )
        .await;
}
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

**expected_notes_commit_sha:** `Option<String>` — Null for the first note; otherwise the notesCommitSha returned by GET.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/src/api/resources/contexts/client.rs">read_file</a>(trunk_id: String, context_key: String, resource_path: String, ref_: Option&lt;String&gt;) -> Result&lt;Vec&lt;u8&gt;, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .contexts
        .read_file(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &"resourcePath".to_string(),
            &ReadFileQueryRequest {
                r#ref: "ref".to_string(),
            },
            None,
        )
        .await;
}
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

**ref_:** `String` — Immutable revision ID from inspect; resolve moving channels before reading.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Billing
<details><summary><code>client.billing.<a href="/src/api/resources/billing/client.rs">get</a>() -> Result&lt;GetBillingResponse, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client.billing.get(None).await;
}
```
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/src/api/resources/billing/client.rs">create_checkout</a>(request: CreateCheckoutBillingRequest) -> Result&lt;CreateCheckoutBillingResponse, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .billing
        .create_checkout(
            &CreateCheckoutBillingRequest {
                plan: CreateCheckoutBillingRequestPlan::Starter,
            },
            None,
        )
        .await;
}
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

**plan:** `CreateCheckoutBillingRequestPlan` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/src/api/resources/billing/client.rs">create_portal</a>() -> Result&lt;CreatePortalBillingResponse, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client.billing.create_portal(None).await;
}
```
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/src/api/resources/billing/client.rs">set_spend_limit</a>(request: SetSpendLimitBillingRequest) -> Result&lt;SetSpendLimitBillingResponse, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .billing
        .set_spend_limit(&SetSpendLimitBillingRequest { cents: 1 }, None)
        .await;
}
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

**cents:** `i64` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Health
<details><summary><code>client.health.<a href="/src/api/resources/health/client.rs">get</a>() -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client.health.get(None).await;
}
```
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Workspaces
<details><summary><code>client.workspaces.<a href="/src/api/resources/workspaces/client.rs">list</a>(cursor: Option&lt;Option&lt;String&gt;&gt;, q: Option&lt;Option&lt;String&gt;&gt;, limit: Option&lt;Option&lt;i64&gt;&gt;) -> Result&lt;ListWorkspacesResponse, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .workspaces
        .list(
            &WorkspacesListQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;
}
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

**cursor:** `Option<String>` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `Option<String>` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Option<i64>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="/src/api/resources/workspaces/client.rs">create</a>(request: CreateTrunkInput) -> Result&lt;Trunk, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .workspaces
        .create(
            &CreateTrunkInput {
                name: "name".to_string(),
                description: None,
            },
            None,
        )
        .await;
}
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

**description:** `Option<String>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="/src/api/resources/workspaces/client.rs">get</a>(trunk_id: String) -> Result&lt;Trunk, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client.workspaces.get(&"trunkId".to_string(), None).await;
}
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
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="/src/api/resources/workspaces/client.rs">audit</a>(trunk_id: String, limit: Option&lt;Option&lt;i64&gt;&gt;) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .workspaces
        .audit(
            &"trunkId".to_string(),
            &AuditQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;
}
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

**limit:** `Option<i64>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Webhooks
<details><summary><code>client.webhooks.<a href="/src/api/resources/webhooks/client.rs">list</a>(trunk_id: String, before: Option&lt;Option&lt;String&gt;&gt;) -> Result&lt;ListWebhooksResponse, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .webhooks
        .list(
            &"trunkId".to_string(),
            &WebhooksListQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;
}
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

**before:** `Option<String>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/src/api/resources/webhooks/client.rs">create_portal</a>(trunk_id: String) -> Result&lt;CreatePortalWebhooksResponse, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .webhooks
        .create_portal(&"trunkId".to_string(), None)
        .await;
}
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
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/src/api/resources/webhooks/client.rs">retry</a>(trunk_id: String, event_id: String) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .webhooks
        .retry(&"trunkId".to_string(), &"eventId".to_string(), None)
        .await;
}
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
</dd>
</dl>


</dd>
</dl>
</details>

## Scopes
<details><summary><code>client.scopes.<a href="/src/api/resources/scopes/client.rs">list</a>(trunk_id: String) -> Result&lt;ListScopesResponse, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client.scopes.list(&"trunkId".to_string(), None).await;
}
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
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.scopes.<a href="/src/api/resources/scopes/client.rs">create</a>(trunk_id: String, request: CreateScopesRequest) -> Result&lt;Scope, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .scopes
        .create(
            &"trunkId".to_string(),
            &CreateScopesRequest {
                name: "name".to_string(),
                slug: None,
            },
            None,
        )
        .await;
}
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

**slug:** `Option<String>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## ContextSets
<details><summary><code>client.context_sets.<a href="/src/api/resources/context_sets/client.rs">sources</a>(cursor: Option&lt;Option&lt;String&gt;&gt;) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .context_sets
        .sources(
            &SourcesQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;
}
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

**cursor:** `Option<String>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.context_sets.<a href="/src/api/resources/context_sets/client.rs">list</a>(cursor: Option&lt;Option&lt;String&gt;&gt;, limit: Option&lt;Option&lt;i64&gt;&gt;) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
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

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .context_sets
        .list(
            &ContextSetsListQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;
}
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

**cursor:** `Option<String>` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Option<i64>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.context_sets.<a href="/src/api/resources/context_sets/client.rs">create</a>(request: CreateContextSetsRequest) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .context_sets
        .create(
            &CreateContextSetsRequest {
                name: "name".to_string(),
                sources: vec![ContextSetSource {
                    source_trunk_id: "sourceTrunkId".to_string(),
                    source_scope_id: "sourceScopeId".to_string(),
                    environment_id: "environmentId".to_string(),
                    context_key: "contextKey".to_string(),
                    revision_id: "revisionId".to_string(),
                    package_digest: "packageDigest".to_string(),
                    mount_path: "mountPath".to_string(),
                    required: true,
                    ..Default::default()
                }],
            },
            None,
        )
        .await;
}
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

**sources:** `Vec<ContextSetSource>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.context_sets.<a href="/src/api/resources/context_sets/client.rs">resolve</a>(context_set_id: String) -> Result&lt;std::collections::HashMap&lt;String, serde_json::Value&gt;, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .context_sets
        .resolve(&"contextSetId".to_string(), None)
        .await;
}
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
</dd>
</dl>


</dd>
</dl>
</details>

## Releases
<details><summary><code>client.releases.<a href="/src/api/resources/releases/client.rs">list</a>(trunk_id: String, cursor: Option&lt;Option&lt;String&gt;&gt;, scope_id: Option&lt;Option&lt;String&gt;&gt;, status: Option&lt;Option&lt;ListReleasesRequestStatus&gt;&gt;, limit: Option&lt;Option&lt;i64&gt;&gt;) -> Result&lt;ListReleasesResponse, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .releases
        .list(
            &"trunkId".to_string(),
            &ReleasesListQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;
}
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

**cursor:** `Option<String>` 
    
</dd>
</dl>

<dl>
<dd>

**scope_id:** `Option<String>` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `Option<ListReleasesRequestStatus>` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `Option<i64>` 
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.releases.<a href="/src/api/resources/releases/client.rs">open</a>(trunk_id: String, request: OpenPromotionRequestInput) -> Result&lt;PromotionRequest, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .releases
        .open(
            &"trunkId".to_string(),
            &OpenPromotionRequestInput {
                ..Default::default()
            },
            None,
        )
        .await;
}
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

**evidence_reference:** `Option<String>` 
    
</dd>
</dl>

<dl>
<dd>

**scope_id:** `Option<String>` — Defaults to the trunk General scope.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.releases.<a href="/src/api/resources/releases/client.rs">merge</a>(trunk_id: String, promotion_id: String) -> Result&lt;PromotionRequest, ApiError&gt;</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```rust
use agenttrunk::prelude::*;

#[tokio::main]
async fn main() {
    let config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    let client = AgentTrunk::new(config).expect("Failed to build client");
    client
        .releases
        .merge(&"trunkId".to_string(), &"promotionId".to_string(), None)
        .await;
}
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
</dd>
</dl>


</dd>
</dl>
</details>

