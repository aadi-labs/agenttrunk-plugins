import Foundation

public final class BillingClient: Sendable {
    private let httpClient: HTTPClient

    init(config: ClientConfig) {
        self.httpClient = HTTPClient(config: config)
    }

    /// Organization subscription and usage summary. Requires billing:read. MCP metering is currently inactive.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.billing.get()
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func get(requestOptions: RequestOptions? = nil) async throws -> GetBillingResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/v1/billing",
            requestOptions: requestOptions,
            responseType: GetBillingResponse.self
        )
    }

    /// Requires billing:manage. Reuses an unexpired checkout; existing subscriptions must use the portal. Body limited to 4096 bytes.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.billing.createCheckout(request: .init(plan: .starter))
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createCheckout(request: Requests.CreateCheckoutBillingRequest, requestOptions: RequestOptions? = nil) async throws -> CreateCheckoutBillingResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/billing/checkout",
            body: request,
            requestOptions: requestOptions,
            responseType: CreateCheckoutBillingResponse.self
        )
    }

    /// Requires billing:manage and an existing organization customer.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.billing.createPortal()
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func createPortal(requestOptions: RequestOptions? = nil) async throws -> CreatePortalBillingResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/billing/portal",
            requestOptions: requestOptions,
            responseType: CreatePortalBillingResponse.self
        )
    }

    /// Requires billing:manage. Audited organization overage cap; excludes subscription fees and taxes. Does not activate metering.
    ///
    /// ```swift
    /// import Foundation
    /// import AgentTrunk
    ///
    /// private func main() async throws {
    ///     let client = AgentTrunk(accessToken: "<token>")
    ///
    ///     _ = try await client.billing.setSpendLimit(request: .init(cents: 1))
    /// }
    ///
    /// try await main()
    /// ```
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func setSpendLimit(request: Requests.SetSpendLimitBillingRequest, requestOptions: RequestOptions? = nil) async throws -> SetSpendLimitBillingResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/v1/billing/spend-limit",
            body: request,
            requestOptions: requestOptions,
            responseType: SetSpendLimitBillingResponse.self
        )
    }
}