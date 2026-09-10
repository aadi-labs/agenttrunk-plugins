# Reference
## Privacy
<details><summary><code>client.privacy.<a href="/Sources/Resources/Privacy/PrivacyClient.swift">assignReview</a>(trunkId: String, requestId: String, request: [String: JSONValue], requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.privacy.assignReview(
        trunkId: "trunkId",
        requestId: "requestId",
        request: [
            "key": .string("value")
        ]
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**requestId:** `String`

</dd>
</dl>

<dl>
<dd>

**request:** `[String: JSONValue]`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="/Sources/Resources/Privacy/PrivacyClient.swift">erasurePlan</a>(trunkId: String, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.privacy.erasurePlan(trunkId: "trunkId")
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="/Sources/Resources/Privacy/PrivacyClient.swift">list</a>(trunkId: String, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.privacy.list(trunkId: "trunkId")
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.privacy.<a href="/Sources/Resources/Privacy/PrivacyClient.swift">create</a>(trunkId: String, request: Requests.CreatePrivacyRequest, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.privacy.create(
        trunkId: "trunkId",
        request: .init(kind: .access)
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**request:** `Requests.CreatePrivacyRequest`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Contexts
<details><summary><code>client.contexts.<a href="/Sources/Resources/Contexts/ContextsClient.swift">export</a>(trunkId: String, contextKey: String, revisionId: String, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contexts.export(
        trunkId: "trunkId",
        contextKey: "contextKey",
        revisionId: "revisionId"
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**contextKey:** `String`

</dd>
</dl>

<dl>
<dd>

**revisionId:** `String`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/Sources/Resources/Contexts/ContextsClient.swift">getRollbackPlan</a>(trunkId: String, contextKey: String, revisionId: String, requestOptions: RequestOptions?) -> GetRollbackPlanContextsResponse</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contexts.getRollbackPlan(
        trunkId: "trunkId",
        contextKey: "contextKey",
        revisionId: "revisionId"
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**contextKey:** `String`

</dd>
</dl>

<dl>
<dd>

**revisionId:** `String`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/Sources/Resources/Contexts/ContextsClient.swift">stageRollback</a>(trunkId: String, contextKey: String, request: Requests.StageRollbackContextsRequest, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contexts.stageRollback(
        trunkId: "trunkId",
        contextKey: "contextKey",
        request: .init(
            revisionId: "revisionId",
            expectedStagingRevisionId: "expectedStagingRevisionId",
            reason: "reason"
        )
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**contextKey:** `String`

</dd>
</dl>

<dl>
<dd>

**request:** `Requests.StageRollbackContextsRequest`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/Sources/Resources/Contexts/ContextsClient.swift">publish</a>(trunkId: String, request: Requests.PublishInput, requestOptions: RequestOptions?) -> PublishContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contexts.publish(
        trunkId: "trunkId",
        request: .init(
            contextKey: "contextKey",
            title: "title",
            kind: .skill,
            files: [
                FileInput(
                    path: "path",
                    contentBase64: "contentBase64"
                )
            ]
        )
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**request:** `Requests.PublishInput`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/Sources/Resources/Contexts/ContextsClient.swift">share</a>(trunkId: String, contextKey: String, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contexts.share(
        trunkId: "trunkId",
        contextKey: "contextKey"
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**contextKey:** `String`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/Sources/Resources/Contexts/ContextsClient.swift">discover</a>(scopeId: String?, cursor: String?, trunkId: String?, query: String?, channel: DiscoverContextsRequestChannel?, limit: Int?, requestOptions: RequestOptions?) -> DiscoverContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contexts.discover()
}

try await main()
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

**scopeId:** `String?` — Filter by scope before applying the result limit.

</dd>
</dl>

<dl>
<dd>

**cursor:** `String?` — Opaque snapshot continuation returned by the preceding page. Keep filters and principal unchanged; cursors expire after 15 minutes. Authorization is always rechecked. Restart pagination for expired or legacy numeric cursors.

</dd>
</dl>

<dl>
<dd>

**trunkId:** `String?` — Narrow discovery to this authorized trunk before applying the result limit.

</dd>
</dl>

<dl>
<dd>

**query:** `String?`

</dd>
</dl>

<dl>
<dd>

**channel:** `DiscoverContextsRequestChannel?`

</dd>
</dl>

<dl>
<dd>

**limit:** `Int?`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/Sources/Resources/Contexts/ContextsClient.swift">inspect</a>(trunkId: String, contextKey: String, ref: String?, requestOptions: RequestOptions?) -> InspectContextsResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contexts.inspect(
        trunkId: "trunkId",
        contextKey: "contextKey"
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**contextKey:** `String`

</dd>
</dl>

<dl>
<dd>

**ref:** `String?`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/Sources/Resources/Contexts/ContextsClient.swift">edit</a>(trunkId: String, contextKey: String, request: Requests.EditContextInput, requestOptions: RequestOptions?) -> EditContextsResponse</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contexts.edit(
        trunkId: "trunkId",
        contextKey: "contextKey",
        request: .init(
            expectedRevisionId: "expectedRevisionId",
            changes: [
                EditContextInputChangesItem.put(
                    EditContextInputChangesItemPut(
                        path: "path",
                        contentBase64: "contentBase64"
                    )
                )
            ]
        )
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**contextKey:** `String`

</dd>
</dl>

<dl>
<dd>

**request:** `Requests.EditContextInput`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/Sources/Resources/Contexts/ContextsClient.swift">history</a>(trunkId: String, contextKey: String, from: String?, limit: Int?, requestOptions: RequestOptions?) -> HistoryContextsResponse</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contexts.history(
        trunkId: "trunkId",
        contextKey: "contextKey"
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**contextKey:** `String`

</dd>
</dl>

<dl>
<dd>

**from:** `String?`

</dd>
</dl>

<dl>
<dd>

**limit:** `Int?`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/Sources/Resources/Contexts/ContextsClient.swift">compare</a>(trunkId: String, contextKey: String, base: String?, target: String?, path: String?, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contexts.compare(
        trunkId: "trunkId",
        contextKey: "contextKey"
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**contextKey:** `String`

</dd>
</dl>

<dl>
<dd>

**base:** `String?`

</dd>
</dl>

<dl>
<dd>

**target:** `String?`

</dd>
</dl>

<dl>
<dd>

**path:** `String?`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/Sources/Resources/Contexts/ContextsClient.swift">getProvenance</a>(trunkId: String, contextKey: String, ref: String?, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contexts.getProvenance(
        trunkId: "trunkId",
        contextKey: "contextKey"
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**contextKey:** `String`

</dd>
</dl>

<dl>
<dd>

**ref:** `String?`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/Sources/Resources/Contexts/ContextsClient.swift">putProvenance</a>(trunkId: String, contextKey: String, request: Requests.PutProvenanceContextsRequest, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contexts.putProvenance(
        trunkId: "trunkId",
        contextKey: "contextKey",
        request: .init(
            revisionId: "revisionId",
            text: "text",
            expectedNotesCommitSha: .null
        )
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**contextKey:** `String`

</dd>
</dl>

<dl>
<dd>

**request:** `Requests.PutProvenanceContextsRequest`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contexts.<a href="/Sources/Resources/Contexts/ContextsClient.swift">readFile</a>(trunkId: String, contextKey: String, resourcePath: String, ref: String, requestOptions: RequestOptions?) -> Data</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contexts.readFile(
        trunkId: "trunkId",
        contextKey: "contextKey",
        resourcePath: "resourcePath",
        ref: "ref"
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**contextKey:** `String`

</dd>
</dl>

<dl>
<dd>

**resourcePath:** `String`

</dd>
</dl>

<dl>
<dd>

**ref:** `String` — Immutable revision ID from inspect; resolve moving channels before reading.

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Billing
<details><summary><code>client.billing.<a href="/Sources/Resources/Billing/BillingClient.swift">get</a>(requestOptions: RequestOptions?) -> GetBillingResponse</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.billing.get()
}

try await main()
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

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/Sources/Resources/Billing/BillingClient.swift">createCheckout</a>(request: Requests.CreateCheckoutBillingRequest, requestOptions: RequestOptions?) -> CreateCheckoutBillingResponse</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.billing.createCheckout(request: .init(plan: .starter))
}

try await main()
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

**request:** `Requests.CreateCheckoutBillingRequest`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/Sources/Resources/Billing/BillingClient.swift">createPortal</a>(requestOptions: RequestOptions?) -> CreatePortalBillingResponse</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.billing.createPortal()
}

try await main()
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

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.billing.<a href="/Sources/Resources/Billing/BillingClient.swift">setSpendLimit</a>(request: Requests.SetSpendLimitBillingRequest, requestOptions: RequestOptions?) -> SetSpendLimitBillingResponse</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.billing.setSpendLimit(request: .init(cents: 1))
}

try await main()
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

**request:** `Requests.SetSpendLimitBillingRequest`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Health
<details><summary><code>client.health.<a href="/Sources/Resources/Health/HealthClient.swift">get</a>(requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.health.get()
}

try await main()
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

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Workspaces
<details><summary><code>client.workspaces.<a href="/Sources/Resources/Workspaces/WorkspacesClient.swift">list</a>(cursor: String?, q: String?, limit: Int?, requestOptions: RequestOptions?) -> ListWorkspacesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.workspaces.list()
}

try await main()
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

**cursor:** `String?`

</dd>
</dl>

<dl>
<dd>

**q:** `String?`

</dd>
</dl>

<dl>
<dd>

**limit:** `Int?`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="/Sources/Resources/Workspaces/WorkspacesClient.swift">create</a>(request: Requests.CreateTrunkInput, requestOptions: RequestOptions?) -> Trunk</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.workspaces.create(request: .init(name: "name"))
}

try await main()
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

**request:** `Requests.CreateTrunkInput`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="/Sources/Resources/Workspaces/WorkspacesClient.swift">get</a>(trunkId: String, requestOptions: RequestOptions?) -> Trunk</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.workspaces.get(trunkId: "trunkId")
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.workspaces.<a href="/Sources/Resources/Workspaces/WorkspacesClient.swift">audit</a>(trunkId: String, limit: Int?, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.workspaces.audit(trunkId: "trunkId")
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**limit:** `Int?`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Webhooks
<details><summary><code>client.webhooks.<a href="/Sources/Resources/Webhooks/WebhooksClient.swift">list</a>(trunkId: String, before: String?, requestOptions: RequestOptions?) -> ListWebhooksResponse</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.webhooks.list(trunkId: "trunkId")
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**before:** `String?`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/Sources/Resources/Webhooks/WebhooksClient.swift">createPortal</a>(trunkId: String, requestOptions: RequestOptions?) -> CreatePortalWebhooksResponse</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.webhooks.createPortal(trunkId: "trunkId")
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.webhooks.<a href="/Sources/Resources/Webhooks/WebhooksClient.swift">retry</a>(trunkId: String, eventId: String, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.webhooks.retry(
        trunkId: "trunkId",
        eventId: "eventId"
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**eventId:** `String`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Scopes
<details><summary><code>client.scopes.<a href="/Sources/Resources/Scopes/ScopesClient.swift">list</a>(trunkId: String, requestOptions: RequestOptions?) -> ListScopesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.scopes.list(trunkId: "trunkId")
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.scopes.<a href="/Sources/Resources/Scopes/ScopesClient.swift">create</a>(trunkId: String, request: Requests.CreateScopesRequest, requestOptions: RequestOptions?) -> Scope</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.scopes.create(
        trunkId: "trunkId",
        request: .init(name: "name")
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**request:** `Requests.CreateScopesRequest`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## ContextSets
<details><summary><code>client.contextSets.<a href="/Sources/Resources/ContextSets/ContextSetsClient.swift">sources</a>(cursor: String?, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contextSets.sources()
}

try await main()
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

**cursor:** `String?`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contextSets.<a href="/Sources/Resources/ContextSets/ContextSetsClient.swift">list</a>(cursor: String?, limit: Int?, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
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

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contextSets.list()
}

try await main()
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

**cursor:** `String?`

</dd>
</dl>

<dl>
<dd>

**limit:** `Int?`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contextSets.<a href="/Sources/Resources/ContextSets/ContextSetsClient.swift">create</a>(request: Requests.CreateContextSetsRequest, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contextSets.create(request: .init(
        name: "name",
        sources: [
            ContextSetSource(
                sourceTrunkId: "sourceTrunkId",
                sourceScopeId: "sourceScopeId",
                environmentId: "environmentId",
                contextKey: "contextKey",
                revisionId: "revisionId",
                packageDigest: "packageDigest",
                mountPath: "mountPath",
                required: true
            )
        ]
    ))
}

try await main()
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

**request:** `Requests.CreateContextSetsRequest`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.contextSets.<a href="/Sources/Resources/ContextSets/ContextSetsClient.swift">resolve</a>(contextSetId: String, requestOptions: RequestOptions?) -> [String: JSONValue]</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.contextSets.resolve(contextSetId: "contextSetId")
}

try await main()
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

**contextSetId:** `String`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

## Releases
<details><summary><code>client.releases.<a href="/Sources/Resources/Releases/ReleasesClient.swift">list</a>(trunkId: String, cursor: String?, scopeId: String?, status: ListReleasesRequestStatus?, limit: Int?, requestOptions: RequestOptions?) -> ListReleasesResponse</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.releases.list(trunkId: "trunkId")
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**cursor:** `String?`

</dd>
</dl>

<dl>
<dd>

**scopeId:** `String?`

</dd>
</dl>

<dl>
<dd>

**status:** `ListReleasesRequestStatus?`

</dd>
</dl>

<dl>
<dd>

**limit:** `Int?`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.releases.<a href="/Sources/Resources/Releases/ReleasesClient.swift">open</a>(trunkId: String, request: Requests.OpenPromotionRequestInput, requestOptions: RequestOptions?) -> PromotionRequest</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.releases.open(
        trunkId: "trunkId",
        request: .init()
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**request:** `Requests.OpenPromotionRequestInput`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

<details><summary><code>client.releases.<a href="/Sources/Resources/Releases/ReleasesClient.swift">merge</a>(trunkId: String, promotionId: String, requestOptions: RequestOptions?) -> PromotionRequest</code></summary>
<dl>
<dd>

#### 🔌 Usage

<dl>
<dd>

<dl>
<dd>

```swift
import Foundation
import AgentTrunk

private func main() async throws {
    let client = AgentTrunk(accessToken: "<token>")

    _ = try await client.releases.merge(
        trunkId: "trunkId",
        promotionId: "promotionId"
    )
}

try await main()
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

**trunkId:** `String`

</dd>
</dl>

<dl>
<dd>

**promotionId:** `String`

</dd>
</dl>

<dl>
<dd>

**requestOptions:** `RequestOptions?` — Additional options for configuring the request, such as custom headers or timeout settings.

</dd>
</dl>
</dd>
</dl>


</dd>
</dl>
</details>

