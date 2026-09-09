import Foundation

public final class HealthClient: Sendable {
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
    ///     _ = try await client.health.get()
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/healthz",
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }
}