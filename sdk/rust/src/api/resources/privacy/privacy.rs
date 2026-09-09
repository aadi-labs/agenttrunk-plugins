use crate::api::*;
use crate::{ApiError, ClientConfig, HttpClient, RequestOptions};
use reqwest::Method;
use std::collections::HashMap;

pub struct PrivacyClient {
    pub http_client: HttpClient,
}

impl PrivacyClient {
    pub fn new(config: ClientConfig) -> Result<Self, ApiError> {
        Ok(Self {
            http_client: HttpClient::new(config.clone())?,
        })
    }

    /// Requires workspace management. Repeating the same assignment is safe; other owners and terminal cases conflict. Does not verify identity or complete fulfillment.
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
    ///         .privacy
    ///         .assign_review(
    ///             &"trunkId".to_string(),
    ///             &"requestId".to_string(),
    ///             &HashMap::from([("key".to_string(), serde_json::json!("value"))]),
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn assign_review(
        &self,
        trunk_id: &str,
        request_id: &str,
        request: &HashMap<String, serde_json::Value>,
        options: Option<RequestOptions>,
    ) -> Result<HashMap<String, serde_json::Value>, ApiError> {
        self.http_client
            .execute_request(
                Method::POST,
                &format!("v1/trunks/{}/privacy-requests/{}/review", crate::safety::path_param(trunk_id)?, crate::safety::path_param(request_id)?),
                Some(serde_json::to_value(request).map_err(ApiError::Serialization)?),
                None,
                options,
            )
            .await
    }

    /// Requires workspace management. Counts selected database dependencies; explicitly not executable or a complete provider inventory.
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
    ///         .privacy
    ///         .erasure_plan(&"trunkId".to_string(), None)
    ///         .await;
    /// }
    /// ```
    pub async fn erasure_plan(
        &self,
        trunk_id: &str,
        options: Option<RequestOptions>,
    ) -> Result<HashMap<String, serde_json::Value>, ApiError> {
        self.http_client
            .execute_request(
                Method::GET,
                &format!("v1/trunks/{}/erasure-plan", crate::safety::path_param(trunk_id)?),
                None,
                None,
                options,
            )
            .await
    }

    /// Requires workspace management. This is not a personal-data export.
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
    ///     client.privacy.list(&"trunkId".to_string(), None).await;
    /// }
    /// ```
    pub async fn list(
        &self,
        trunk_id: &str,
        options: Option<RequestOptions>,
    ) -> Result<HashMap<String, serde_json::Value>, ApiError> {
        self.http_client
            .execute_request(
                Method::GET,
                &format!("v1/trunks/{}/privacy-requests", crate::safety::path_param(trunk_id)?),
                None,
                None,
                options,
            )
            .await
    }

    /// Requires workspace management. Deduplicates open requests for the authorizing user. Does not export or delete data.
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
    ///         .privacy
    ///         .create(
    ///             &"trunkId".to_string(),
    ///             &CreatePrivacyRequest {
    ///                 kind: CreatePrivacyRequestKind::Access,
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn create(
        &self,
        trunk_id: &str,
        request: &CreatePrivacyRequest,
        options: Option<RequestOptions>,
    ) -> Result<HashMap<String, serde_json::Value>, ApiError> {
        self.http_client
            .execute_request(
                Method::POST,
                &format!("v1/trunks/{}/privacy-requests", crate::safety::path_param(trunk_id)?),
                Some(serde_json::to_value(request).map_err(ApiError::Serialization)?),
                None,
                options,
            )
            .await
    }
}
