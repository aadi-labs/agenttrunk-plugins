import Foundation

public final class PrivacyClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Requires workspace management. Repeating the same assignment is safe; other owners and terminal cases conflict. Does not verify identity or complete fulfillment.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.privacy.assignReview(
    ///         trunkId: "trunkId",
    ///         requestId: "requestId",
    ///         request: [
    ///             "key": .string("value")
    ///         ]
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func assignReview(trunkId: String, requestId: String, request: [String: JSONValue], requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/trunks/\(trunkId)/privacy-requests/\(requestId)/review",
            body: request,
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }

    /// Requires workspace management. Counts selected database dependencies; explicitly not executable or a complete provider inventory.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.privacy.erasurePlan(trunkId: "trunkId")
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func erasurePlan(trunkId: String, requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks/\(trunkId)/erasure-plan",
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }

    /// Requires workspace management. This is not a personal-data export.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.privacy.list(trunkId: "trunkId")
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func list(trunkId: String, requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks/\(trunkId)/privacy-requests",
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }

    /// Requires workspace management. Deduplicates open requests for the authorizing user. Does not export or delete data.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.privacy.create(
    ///         trunkId: "trunkId",
    ///         request: .init(kind: .access)
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func create(trunkId: String, request: Requests.CreatePrivacyRequest, requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/trunks/\(trunkId)/privacy-requests",
            body: request,
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }
}