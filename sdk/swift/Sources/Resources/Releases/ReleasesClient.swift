import Foundation

public final class ReleasesClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.releases.list(trunkId: "trunkId")
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func list(trunkId: String, cursor: String? = nil, scopeId: String? = nil, status: ListReleasesRequestStatus? = nil, limit: Int? = nil, requestOptions: RequestOptions? = nil) async throws -> ListReleasesResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks/\(trunkId)/promotion-requests",
            queryParams: [
                "cursor": cursor.map { .string($0) }, 
                "scopeId": scopeId.map { .string($0) }, 
                "status": status.map { .string($0.rawValue) }, 
                "limit": limit.map { .int($0) }
            ],
            requestOptions: requestOptions,
            responseType: ListReleasesResponse.self
        )
    }

    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.releases.open(
    ///         trunkId: "trunkId",
    ///         request: .init()
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func open(trunkId: String, request: Requests.OpenPromotionRequestInput, requestOptions: RequestOptions? = nil) async throws -> PromotionRequest {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/trunks/\(trunkId)/promotion-requests",
            body: request,
            requestOptions: requestOptions,
            responseType: PromotionRequest.self
        )
    }

    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.releases.merge(
    ///         trunkId: "trunkId",
    ///         promotionId: "promotionId"
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func merge(trunkId: String, promotionId: String, requestOptions: RequestOptions? = nil) async throws -> PromotionRequest {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/trunks/\(trunkId)/promotion-requests/\(promotionId)/merge",
            requestOptions: requestOptions,
            responseType: PromotionRequest.self
        )
    }
}