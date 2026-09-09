import Foundation

public final class ScopesClient: Sendable {
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
    ///     _ = try await client.scopes.list(trunkId: "trunkId")
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func list(trunkId: String, requestOptions: RequestOptions? = nil) async throws -> ListScopesResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks/\(trunkId)/scopes",
            requestOptions: requestOptions,
            responseType: ListScopesResponse.self
        )
    }

    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.scopes.create(
    ///         trunkId: "trunkId",
    ///         request: .init(name: "name")
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func create(trunkId: String, request: Requests.CreateScopesRequest, requestOptions: RequestOptions? = nil) async throws -> Scope {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/trunks/\(trunkId)/scopes",
            body: request,
            requestOptions: requestOptions,
            responseType: Scope.self
        )
    }
}