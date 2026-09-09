import Foundation

public final class WebhooksClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Requires trunk management permission. Lists at most 50 workspace submission receipts, not endpoint delivery receipts. Pass nextCursor as before until null.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.webhooks.list(trunkId: "trunkId")
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func list(trunkId: String, before: String? = nil, requestOptions: RequestOptions? = nil) async throws -> ListWebhooksResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/trunks/\(trunkId)/webhooks",
            queryParams: [
                "before": before.map { .string($0) }
            ],
            requestOptions: requestOptions,
            responseType: ListWebhooksResponse.self
        )
    }

    /// Requires trunk management permission. Enables future workspace events and returns a one-hour bearer access URL for endpoint configuration, delivery inspection, and replay. Never cache or log the URL. Previously issued links remain valid until expiry.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.webhooks.createPortal(trunkId: "trunkId")
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createPortal(trunkId: String, requestOptions: RequestOptions? = nil) async throws -> CreatePortalWebhooksResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/trunks/\(trunkId)/webhooks/portal",
            requestOptions: requestOptions,
            responseType: CreatePortalWebhooksResponse.self
        )
    }

    /// Requires trunk management permission. Requeue a failed provider submission with the same event identity. Accepted messages must be replayed through the Svix portal. Consumers must deduplicate events.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.webhooks.retry(
    ///         trunkId: "trunkId",
    ///         eventId: "eventId"
    ///     )
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func retry(trunkId: String, eventId: String, requestOptions: RequestOptions? = nil) async throws -> [String: JSONValue] {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/trunks/\(trunkId)/webhooks/\(eventId)/retry",
            requestOptions: requestOptions,
            responseType: [String: JSONValue].self
        )
    }
}