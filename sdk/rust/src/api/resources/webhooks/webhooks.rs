use crate::api::*;
use crate::{ApiError, ClientConfig, HttpClient, QueryBuilder, RequestOptions};
use reqwest::Method;
use std::collections::HashMap;

pub struct WebhooksClient {
    pub http_client: HttpClient,
}

impl WebhooksClient {
    pub fn new(config: ClientConfig) -> Result<Self, ApiError> {
        Ok(Self {
            http_client: HttpClient::new(config.clone())?,
        })
    }

    /// Requires trunk management permission. Lists at most 50 workspace submission receipts, not endpoint delivery receipts. Pass nextCursor as before until null.
    ///
    /// # Arguments
    ///
    /// * `options` - Additional request options such as headers, timeout, etc.
    ///
    /// # Returns
    ///
    /// JSON response from the API
    ///
    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .webhooks
    ///         .list(
    ///             &"trunkId".to_string(),
    ///             &WebhooksListQueryRequest {
    ///                 ..Default::default()
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn list(
        &self,
        trunk_id: &str,
        request: &WebhooksListQueryRequest,
        options: Option<RequestOptions>,
    ) -> Result<ListWebhooksResponse, ApiError> {
        self.http_client
            .execute_request(
                Method::GET,
                &format!("v1/trunks/{}/webhooks", crate::safety::path_param(trunk_id)?),
                None,
                QueryBuilder::new()
                    .string("before", request.before.clone())
                    .build(),
                options,
            )
            .await
    }

    /// Requires trunk management permission. Enables future workspace events and returns a one-hour bearer access URL for endpoint configuration, delivery inspection, and replay. Never cache or log the URL. Previously issued links remain valid until expiry.
    ///
    /// # Arguments
    ///
    /// * `options` - Additional request options such as headers, timeout, etc.
    ///
    /// # Returns
    ///
    /// JSON response from the API
    ///
    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .webhooks
    ///         .create_portal(&"trunkId".to_string(), None)
    ///         .await;
    /// }
    /// ```
    pub async fn create_portal(
        &self,
        trunk_id: &str,
        options: Option<RequestOptions>,
    ) -> Result<CreatePortalWebhooksResponse, ApiError> {
        self.http_client
            .execute_request(
                Method::POST,
                &format!("v1/trunks/{}/webhooks/portal", crate::safety::path_param(trunk_id)?),
                None,
                None,
                options,
            )
            .await
    }

    /// Requires trunk management permission. Requeue a failed provider submission with the same event identity. Accepted messages must be replayed through the Svix portal. Consumers must deduplicate events.
    ///
    /// # Arguments
    ///
    /// * `options` - Additional request options such as headers, timeout, etc.
    ///
    /// # Returns
    ///
    /// JSON response from the API
    ///
    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .webhooks
    ///         .retry(&"trunkId".to_string(), &"eventId".to_string(), None)
    ///         .await;
    /// }
    /// ```
    pub async fn retry(
        &self,
        trunk_id: &str,
        event_id: &str,
        options: Option<RequestOptions>,
    ) -> Result<HashMap<String, serde_json::Value>, ApiError> {
        self.http_client
            .execute_request(
                Method::POST,
                &format!("v1/trunks/{}/webhooks/{}/retry", crate::safety::path_param(trunk_id)?, crate::safety::path_param(event_id)?),
                None,
                None,
                options,
            )
            .await
    }
}
