# Reference
## Privacy
<details><summary><code>client.privacy.<a href="src/agenttrunk/privacy/client.py">assign_review</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.privacy.assign_review(
    trunk_id="trunkId",
    request_id="requestId",
    request={
        "key": "value"
    },
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**request_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**request:** `typing.Dict[str, typing.Any]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="src/agenttrunk/privacy/client.py">erasure_plan</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.privacy.erasure_plan(
    trunk_id="trunkId",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="src/agenttrunk/privacy/client.py">list</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.privacy.list(
    trunk_id="trunkId",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="src/agenttrunk/privacy/client.py">create</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.privacy.create(
    trunk_id="trunkId",
    kind="access",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**kind:** `CreatePrivacyRequestKind` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Contexts
<details><summary><code>client.contexts.<a href="src/agenttrunk/contexts/client.py">export</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.contexts.export(
    trunk_id="trunkId",
    context_key="contextKey",
    revision_id="revisionId",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**revision_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="src/agenttrunk/contexts/client.py">get_rollback_plan</a>(...) -> GetRollbackPlanContextsResponse</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.contexts.get_rollback_plan(
    trunk_id="trunkId",
    context_key="contextKey",
    revision_id="revisionId",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**revision_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="src/agenttrunk/contexts/client.py">stage_rollback</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.contexts.stage_rollback(
    trunk_id="trunkId",
    context_key="contextKey",
    revision_id="revisionId",
    expected_staging_revision_id="expectedStagingRevisionId",
    reason="reason",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**revision_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**expected_staging_revision_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**reason:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="src/agenttrunk/contexts/client.py">publish</a>(...) -> PublishContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk, FileInput
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.contexts.publish(
    trunk_id="trunkId",
    context_key="contextKey",
    title="title",
    kind="skill",
    files=[
        FileInput(
            path="path",
            content_base64="contentBase64",
        )
    ],
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**title:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**kind:** `ContextKind` 
    
</dd>
</dl>

<dl>
<dd>

**files:** `typing.List[FileInput]` 
    
</dd>
</dl>

<dl>
<dd>

**summary:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**tags:** `typing.Optional[typing.List[str]]` 
    
</dd>
</dl>

<dl>
<dd>

**claimed_digest:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**scope_id:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="src/agenttrunk/contexts/client.py">share</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.contexts.share(
    trunk_id="trunkId",
    context_key="contextKey",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="src/agenttrunk/contexts/client.py">discover</a>(...) -> DiscoverContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.contexts.discover()

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

**scope_id:** `typing.Optional[str]` — Filter by scope before applying the result limit.
    
</dd>
</dl>

<dl>
<dd>

**cursor:** `typing.Optional[str]` — Opaque snapshot continuation returned by the preceding page. Keep filters and principal unchanged; cursors expire after 15 minutes. Authorization is always rechecked. Restart pagination for expired or legacy numeric cursors.
    
</dd>
</dl>

<dl>
<dd>

**trunk_id:** `typing.Optional[str]` — Narrow discovery to this authorized trunk before applying the result limit.
    
</dd>
</dl>

<dl>
<dd>

**query:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**channel:** `typing.Optional[DiscoverContextsRequestChannel]` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `typing.Optional[int]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="src/agenttrunk/contexts/client.py">inspect</a>(...) -> InspectContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.contexts.inspect(
    trunk_id="trunkId",
    context_key="contextKey",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**ref:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="src/agenttrunk/contexts/client.py">edit</a>(...) -> EditContextsResponse</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment
from agenttrunk.contexts import EditContextInputChangesItem_Put

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.contexts.edit(
    trunk_id="trunkId",
    context_key="contextKey",
    expected_revision_id="expectedRevisionId",
    changes=[
        EditContextInputChangesItem_Put(
            path="path",
            content_base64="contentBase64",
        )
    ],
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**expected_revision_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**changes:** `typing.List[EditContextInputChangesItem]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="src/agenttrunk/contexts/client.py">history</a>(...) -> HistoryContextsResponse</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.contexts.history(
    trunk_id="trunkId",
    context_key="contextKey",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**from:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `typing.Optional[int]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="src/agenttrunk/contexts/client.py">compare</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.contexts.compare(
    trunk_id="trunkId",
    context_key="contextKey",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**base:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**target:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**path:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="src/agenttrunk/contexts/client.py">get_provenance</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.contexts.get_provenance(
    trunk_id="trunkId",
    context_key="contextKey",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**ref:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="src/agenttrunk/contexts/client.py">put_provenance</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.contexts.put_provenance(
    trunk_id="trunkId",
    context_key="contextKey",
    revision_id="revisionId",
    text="text",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**revision_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**text:** `str` — Maximum 16000 UTF-8 bytes; not 16000 arbitrary Unicode characters.
    
</dd>
</dl>

<dl>
<dd>

**expected_notes_commit_sha:** `typing.Optional[str]` — Null for the first note; otherwise the notesCommitSha returned by GET.
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="src/agenttrunk/contexts/client.py">read_file</a>(...) -> typing.Iterator[bytes]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.contexts.read_file(
    trunk_id="trunkId",
    context_key="contextKey",
    resource_path="resourcePath",
    ref="ref",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**context_key:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**resource_path:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**ref:** `str` — Immutable revision ID from inspect; resolve moving channels before reading.
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Billing
<details><summary><code>client.billing.<a href="src/agenttrunk/billing/client.py">get</a>() -> GetBillingResponse</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.billing.get()

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

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="src/agenttrunk/billing/client.py">create_checkout</a>(...) -> CreateCheckoutBillingResponse</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.billing.create_checkout(
    plan="starter",
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

**plan:** `CreateCheckoutBillingRequestPlan` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="src/agenttrunk/billing/client.py">create_portal</a>() -> CreatePortalBillingResponse</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.billing.create_portal()

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

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="src/agenttrunk/billing/client.py">set_spend_limit</a>(...) -> SetSpendLimitBillingResponse</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.billing.set_spend_limit(
    cents=1,
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

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Health
<details><summary><code>client.health.<a href="src/agenttrunk/health/client.py">get</a>() -> typing.Dict[str, typing.Any]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.health.get()

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

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Workspaces
<details><summary><code>client.workspaces.<a href="src/agenttrunk/workspaces/client.py">list</a>(...) -> ListWorkspacesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.workspaces.list()

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

**cursor:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**q:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `typing.Optional[int]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="src/agenttrunk/workspaces/client.py">create</a>(...) -> Trunk</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.workspaces.create(
    name="name",
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

**name:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**description:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="src/agenttrunk/workspaces/client.py">get</a>(...) -> Trunk</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.workspaces.get(
    trunk_id="trunkId",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="src/agenttrunk/workspaces/client.py">audit</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.workspaces.audit(
    trunk_id="trunkId",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `typing.Optional[int]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Webhooks
<details><summary><code>client.webhooks.<a href="src/agenttrunk/webhooks/client.py">list</a>(...) -> ListWebhooksResponse</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.webhooks.list(
    trunk_id="trunkId",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**before:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="src/agenttrunk/webhooks/client.py">create_portal</a>(...) -> CreatePortalWebhooksResponse</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.webhooks.create_portal(
    trunk_id="trunkId",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="src/agenttrunk/webhooks/client.py">retry</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.webhooks.retry(
    trunk_id="trunkId",
    event_id="eventId",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**event_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Scopes
<details><summary><code>client.scopes.<a href="src/agenttrunk/scopes/client.py">list</a>(...) -> ListScopesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.scopes.list(
    trunk_id="trunkId",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.scopes.<a href="src/agenttrunk/scopes/client.py">create</a>(...) -> Scope</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.scopes.create(
    trunk_id="trunkId",
    name="name",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**name:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**slug:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## ContextSets
<details><summary><code>client.context_sets.<a href="src/agenttrunk/context_sets/client.py">sources</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.context_sets.sources()

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

**cursor:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.context_sets.<a href="src/agenttrunk/context_sets/client.py">list</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
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

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.context_sets.list()

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

**cursor:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `typing.Optional[int]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.context_sets.<a href="src/agenttrunk/context_sets/client.py">create</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk, ContextSetSource
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.context_sets.create(
    name="name",
    sources=[
        ContextSetSource(
            source_trunk_id="sourceTrunkId",
            source_scope_id="sourceScopeId",
            environment_id="environmentId",
            context_key="contextKey",
            revision_id="revisionId",
            package_digest="packageDigest",
            mount_path="mountPath",
            required=True,
        )
    ],
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

**name:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**sources:** `typing.List[ContextSetSource]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.context_sets.<a href="src/agenttrunk/context_sets/client.py">resolve</a>(...) -> typing.Dict[str, typing.Any]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.context_sets.resolve(
    context_set_id="contextSetId",
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

**context_set_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Releases
<details><summary><code>client.releases.<a href="src/agenttrunk/releases/client.py">list</a>(...) -> ListReleasesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.releases.list(
    trunk_id="trunkId",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**cursor:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**scope_id:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**status:** `typing.Optional[ListReleasesRequestStatus]` 
    
</dd>
</dl>

<dl>
<dd>

**limit:** `typing.Optional[int]` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.releases.<a href="src/agenttrunk/releases/client.py">open</a>(...) -> PromotionRequest</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.releases.open(
    trunk_id="trunkId",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**evidence_reference:** `typing.Optional[str]` 
    
</dd>
</dl>

<dl>
<dd>

**scope_id:** `typing.Optional[str]` — Defaults to the trunk General scope.
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.releases.<a href="src/agenttrunk/releases/client.py">merge</a>(...) -> PromotionRequest</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```python
from agenttrunk import AgentTrunk
from agenttrunk.environment import AgentTrunkEnvironment

client = AgentTrunk(
    access_token="<token>",
    environment=AgentTrunkEnvironment.DEFAULT,
)

client.releases.merge(
    trunk_id="trunkId",
    promotion_id="promotionId",
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

**trunk_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**promotion_id:** `str` 
    
</dd>
</dl>

<dl>
<dd>

**request_options:** `typing.Optional[RequestOptions]` — Request-specific configuration.
    
</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

