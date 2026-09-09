import Foundation

public final class WorkspacesClient: Sendable {
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
    ///     _ = try await client.workspaces.list()
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func list(cursor: String? = nil, q: String? = nil, limit: Int? = nil, requestOptions: RequestOptions? = nil) async throws -> ListWorkspacesResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks",
            queryParams: [
                "cursor": cursor.map { .string($0) }, 
                "q": q.map { .string($0) }, 
                "limit": limit.map { .int($0) }
            ],
            requestOptions: requestOptions,
            responseType: ListWorkspacesResponse.self
        )
    }

    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.workspaces.create(request: .init(name: "name"))
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func create(request: Requests.CreateTrunkInput, requestOptions: RequestOptions? = nil) async throws -> Trunk {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/trunks",
            body: request,
            requestOptions: requestOptions,
            responseType: Trunk.self
        )
    }

    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.workspaces.get(trunkId: "trunkId")
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(trunkId: String, requestOptions: RequestOptions? = nil) async throws -> Trunk {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks/\(trunkId)",
            requestOptions: requestOptions,
            responseType: Trunk.self
        )
    }

    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.workspaces.audit(trunkId: "trunkId")
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func audit(trunkId: String, limit: Int? = nil, requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks/\(trunkId)/audit",
            queryParams: [
                "limit": limit.map { .int($0) }
            ],
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }
}