import Foundation

public final class ContextsClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Reads require current context authorization. Includes verified files encoded as base64 and metadata; excludes other history, notes, accounts, logs and backups. Not a complete personal-data export.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.contexts.export(
    ///         trunkId: "trunkId",
    ///         contextKey: "contextKey",
    ///         revisionId: "revisionId"
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func export(trunkId: String, contextKey: String, revisionId: String, requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks/\(trunkId)/contexts/\(contextKey)/export",
            queryParams: [
                "revisionId": .string(revisionId)
            ],
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }

    /// Check whether an immutable revision can be restored to staging. This is advisory; the write rechecks permissions, release evidence, and staging concurrency. Ineligible responses do not expose the current staging revision.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.contexts.getRollbackPlan(
    ///         trunkId: "trunkId",
    ///         contextKey: "contextKey",
    ///         revisionId: "revisionId"
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getRollbackPlan(trunkId: String, contextKey: String, revisionId: String, requestOptions: RequestOptions? = nil) async throws -> GetRollbackPlanContextsResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks/\(trunkId)/contexts/\(contextKey)/rollback",
            queryParams: [
                "revisionId": .string(revisionId)
            ],
            requestOptions: requestOptions,
            responseType: GetRollbackPlanContextsResponse.self
        )
    }

    /// Restore a previously released immutable revision into staging. Requires production rollback and staging deploy permissions. Production only changes through a subsequent promotion PR.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.contexts.stageRollback(
    ///         trunkId: "trunkId",
    ///         contextKey: "contextKey",
    ///         request: .init(
    ///             revisionId: "revisionId",
    ///             expectedStagingRevisionId: "expectedStagingRevisionId",
    ///             reason: "reason"
    ///         )
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func stageRollback(trunkId: String, contextKey: String, request: Requests.StageRollbackContextsRequest, requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/trunks/\(trunkId)/contexts/\(contextKey)/rollback",
            body: request,
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }

    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.contexts.publish(
    ///         trunkId: "trunkId",
    ///         request: .init(
    ///             contextKey: "contextKey",
    ///             title: "title",
    ///             kind: .skill,
    ///             files: [
    ///                 FileInput(
    ///                     path: "path",
    ///                     contentBase64: "contentBase64"
    ///                 )
    ///             ]
    ///         )
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func publish(trunkId: String, request: Requests.PublishInput, requestOptions: RequestOptions? = nil) async throws -> PublishContextsResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/trunks/\(trunkId)/publications",
            body: request,
            requestOptions: requestOptions,
            responseType: PublishContextsResponse.self
        )
    }

    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.contexts.share(
    ///         trunkId: "trunkId",
    ///         contextKey: "contextKey"
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func share(trunkId: String, contextKey: String, requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/trunks/\(trunkId)/contexts/\(contextKey)/share",
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }

    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.contexts.discover()
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter scopeId: Filter by scope before applying the result limit.
    /// - Parameter cursor: Opaque snapshot continuation returned by the preceding page. Keep filters and principal unchanged; cursors expire after 15 minutes. Authorization is always rechecked. Restart pagination for expired or legacy numeric cursors.
    /// - Parameter trunkId: Narrow discovery to this authorized trunk before applying the result limit.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func discover(scopeId: String? = nil, cursor: String? = nil, trunkId: String? = nil, query: String? = nil, channel: DiscoverContextsRequestChannel? = nil, limit: Int? = nil, requestOptions: RequestOptions? = nil) async throws -> DiscoverContextsResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/contexts",
            queryParams: [
                "scopeId": scopeId.map { .string($0) }, 
                "cursor": cursor.map { .string($0) }, 
                "trunkId": trunkId.map { .string($0) }, 
                "query": query.map { .string($0) }, 
                "channel": channel.map { .string($0.rawValue) }, 
                "limit": limit.map { .int($0) }
            ],
            requestOptions: requestOptions,
            responseType: DiscoverContextsResponse.self
        )
    }

    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.contexts.inspect(
    ///         trunkId: "trunkId",
    ///         contextKey: "contextKey"
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func inspect(trunkId: String, contextKey: String, ref: String? = nil, requestOptions: RequestOptions? = nil) async throws -> InspectContextsResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks/\(trunkId)/contexts/\(contextKey)",
            queryParams: [
                "ref": ref.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: InspectContextsResponse.self
        )
    }

    /// Atomically add, replace, or delete files in staging, preserving metadata and unchanged files.
    /// Requires staging read and deployment permission. expectedRevisionId must equal the current
    /// staging revision. Concurrent branch changes return 409; reread and reconcile, never blindly
    /// retry. Production is unchanged. The resulting package retains the 256-file, 1 MB per-file,
    /// and 16 MB total limits and must not be empty. Each path may appear once. Deleting a missing
    /// file is invalid. Identical content is a no-op; restoring historical content uses rollback.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.contexts.edit(
    ///         trunkId: "trunkId",
    ///         contextKey: "contextKey",
    ///         request: .init(
    ///             expectedRevisionId: "expectedRevisionId",
    ///             changes: [
    ///                 EditContextInputChangesItem.put(
    ///                     EditContextInputChangesItemPut(
    ///                         path: "path",
    ///                         contentBase64: "contentBase64"
    ///                     )
    ///                 )
    ///             ]
    ///         )
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func edit(trunkId: String, contextKey: String, request: Requests.EditContextInput, requestOptions: RequestOptions? = nil) async throws -> EditContextsResponse {
        return try await httpClient.performRequest(
            method: .patch,
            path: "/v1/trunks/\(trunkId)/contexts/\(contextKey)",
            body: request,
            requestOptions: requestOptions,
            responseType: EditContextsResponse.self
        )
    }

    /// Follows immutable parent revisions, authorizing every revision. Historic IDs require staging read or shared-context-item read access.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.contexts.history(
    ///         trunkId: "trunkId",
    ///         contextKey: "contextKey"
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func history(trunkId: String, contextKey: String, from: String? = nil, limit: Int? = nil, requestOptions: RequestOptions? = nil) async throws -> HistoryContextsResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks/\(trunkId)/contexts/\(contextKey)/history",
            queryParams: [
                "from": from.map { .string($0) }, 
                "limit": limit.map { .int($0) }
            ],
            requestOptions: requestOptions,
            responseType: HistoryContextsResponse.self
        )
    }

    /// Authorizes both revisions and returns their manifests, per-file statuses,
    /// and one selected file preview. Target defaults to latest; base defaults to
    /// the target's parent, or an empty snapshot for the first revision. The
    /// returned IDs are immutable; use them for subsequent file selections.
    /// UTF-8 previews verify file digests and are capped at 128000 bytes per side.
    /// reason is null, too_large, binary, or too_complex. Omitted previews have
    /// empty content and zero counts, which must not be displayed as no changes.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.contexts.compare(
    ///         trunkId: "trunkId",
    ///         contextKey: "contextKey"
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func compare(trunkId: String, contextKey: String, base: String? = nil, target: String? = nil, path: String? = nil, requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks/\(trunkId)/contexts/\(contextKey)/compare",
            queryParams: [
                "base": base.map { .string($0) }, 
                "target": target.map { .string($0) }, 
                "path": path.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }

    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.contexts.getProvenance(
    ///         trunkId: "trunkId",
    ///         contextKey: "contextKey"
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getProvenance(trunkId: String, contextKey: String, ref: String? = nil, requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks/\(trunkId)/contexts/\(contextKey)/provenance",
            queryParams: [
                "ref": ref.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }

    /// Requires revision read and staging environment deployment permission. Author identity is assigned server-side. Does not modify content, channels, or PR approval. Concurrent updates return 409; reread and reconcile, never blindly retry with a newer token.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.contexts.putProvenance(
    ///         trunkId: "trunkId",
    ///         contextKey: "contextKey",
    ///         request: .init(
    ///             revisionId: "revisionId",
    ///             text: "text",
    ///             expectedNotesCommitSha: .null
    ///         )
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func putProvenance(trunkId: String, contextKey: String, request: Requests.PutProvenanceContextsRequest, requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .put,
            path: "/v1/trunks/\(trunkId)/contexts/\(contextKey)/provenance",
            body: request,
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }

    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.contexts.readFile(
    ///         trunkId: "trunkId",
    ///         contextKey: "contextKey",
    ///         resourcePath: "resourcePath",
    ///         ref: "ref"
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter ref: Immutable revision ID from inspect; resolve moving channels before reading.
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func readFile(trunkId: String, contextKey: String, resourcePath: String, ref: String, requestOptions: RequestOptions? = nil) async throws -> Data {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks/\(trunkId)/contexts/\(contextKey)/files/\(resourcePath)",
            queryParams: [
                "ref": .string(ref)
            ],
            requestOptions: requestOptions,
            responseType: Data.self
        )
    }
}