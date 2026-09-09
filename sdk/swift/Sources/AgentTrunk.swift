import Foundation

/// Use this class to access the different functions within the SDK. You can instantiate any number of clients with different configuration that will propagate to these functions.
public final class AgentTrunk: Sendable {
    public let privacy: PrivacyClient
    public let contexts: ContextsClient
    public let billing: BillingClient
    public let health: HealthClient
    public let workspaces: WorkspacesClient
    public let webhooks: WebhooksClient
    public let scopes: ScopesClient
    public let contextSets: ContextSetsClient
    public let releases: ReleasesClient
    private let httpClient: HTTPClient

    /// Initialize the client with the specified configuration and a static bearer token.
    ///
    /// - Parameter baseURL: The base URL to use for requests from the client. If not provided, the default base URL will be used.
    /// - Parameter accessToken: Bearer token for authentication. If provided, will be sent as "Bearer {token}" in Authorization header.
    /// - Parameter headers: Additional headers to send with each request.
    /// - Parameter timeout: Request timeout in seconds. Defaults to 60 seconds. Ignored if a custom `urlSession` is provided.
    /// - Parameter maxRetries: Maximum number of retries for failed requests. Defaults to 2.
    /// - Parameter urlSession: Custom `URLSession` to use for requests. If not provided, a default session will be created with the specified timeout.
    public convenience init(
        baseURL: String = AgentTrunkEnvironment.default.rawValue,
        accessToken: String? = nil,
        headers: [String: String]? = nil,
        timeout: Int? = nil,
        maxRetries: Int? = nil,
        urlSession: Networking.URLSession? = nil
    ) {
        self.init(
            baseURL: baseURL,
            headerAuth: nil,
            bearerAuth: accessToken.map {
                .init(token: .staticToken($0))
            },
            basicAuth: nil,
            headers: headers,
            timeout: timeout,
            maxRetries: maxRetries,
            urlSession: urlSession
        )
    }

    /// Initialize the client with the specified configuration and an async bearer token provider.
    ///
    /// - Parameter baseURL: The base URL to use for requests from the client. If not provided, the default base URL will be used.
    /// - Parameter accessToken: An async function that returns the bearer token for authentication. If provided, will be sent as "Bearer {token}" in Authorization header.
    /// - Parameter headers: Additional headers to send with each request.
    /// - Parameter timeout: Request timeout in seconds. Defaults to 60 seconds. Ignored if a custom `urlSession` is provided.
    /// - Parameter maxRetries: Maximum number of retries for failed requests. Defaults to 2.
    /// - Parameter urlSession: Custom `URLSession` to use for requests. If not provided, a default session will be created with the specified timeout.
    public convenience init(
        baseURL: String = AgentTrunkEnvironment.default.rawValue,
        accessToken: ClientConfig.CredentialProvider? = nil,
        headers: [String: String]? = nil,
        timeout: Int? = nil,
        maxRetries: Int? = nil,
        urlSession: Networking.URLSession? = nil
    ) {
        self.init(
            baseURL: baseURL,
            headerAuth: nil,
            bearerAuth: accessToken.map {
                .init(token: .provider($0))
            },
            basicAuth: nil,
            headers: headers,
            timeout: timeout,
            maxRetries: maxRetries,
            urlSession: urlSession
        )
    }

    init(
        baseURL: String,
        headerAuth: ClientConfig.HeaderAuth? = nil,
        bearerAuth: ClientConfig.BearerAuth? = nil,
        basicAuth: ClientConfig.BasicAuth? = nil,
        headers: [String: String]? = nil,
        timeout: Int? = nil,
        maxRetries: Int? = nil,
        urlSession: Networking.URLSession? = nil
    ) {
        let config = ClientConfig(
            baseURL: baseURL,
            headerAuth: headerAuth,
            bearerAuth: bearerAuth,
            basicAuth: basicAuth,
            headers: headers,
            timeout: timeout,
            maxRetries: maxRetries,
            urlSession: urlSession
        )
        self.privacy = PrivacyClient(config: config)
        self.contexts = ContextsClient(config: config)
        self.billing = BillingClient(config: config)
        self.health = HealthClient(config: config)
        self.workspaces = WorkspacesClient(config: config)
        self.webhooks = WebhooksClient(config: config)
        self.scopes = ScopesClient(config: config)
        self.contextSets = ContextSetsClient(config: config)
        self.releases = ReleasesClient(config: config)
        self.httpClient = HTTPClient(config: config)
    }
}