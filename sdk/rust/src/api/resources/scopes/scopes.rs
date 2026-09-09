use crate::api::*;
use crate::{ApiError, ClientConfig, HttpClient, RequestOptions};
use reqwest::Method;

pub struct ScopesClient {
    pub http_client: HttpClient,
}

impl ScopesClient {
    pub fn new(config: ClientConfig) -> Result<Self, ApiError> {
        Ok(Self {
            http_client: HttpClient::new(config.clone())?,
        })
    }

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
    ///     client.scopes.list(&"trunkId".to_string(), None).await;
    /// }
    /// ```
    pub async fn list(
        &self,
        trunk_id: &str,
        options: Option<RequestOptions>,
    ) -> Result<ListScopesResponse, ApiError> {
        self.http_client
            .execute_request(
                Method::GET,
                &format!("v1/trunks/{}/scopes", crate::safety::path_param(trunk_id)?),
                None,
                None,
                options,
            )
            .await
    }

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
    ///         .scopes
    ///         .create(
    ///             &"trunkId".to_string(),
    ///             &CreateScopesRequest {
    ///                 name: "name".to_string(),
    ///                 slug: None,
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn create(
        &self,
        trunk_id: &str,
        request: &CreateScopesRequest,
        options: Option<RequestOptions>,
    ) -> Result<Scope, ApiError> {
        self.http_client
            .execute_request(
                Method::POST,
                &format!("v1/trunks/{}/scopes", crate::safety::path_param(trunk_id)?),
                Some(serde_json::to_value(request).map_err(ApiError::Serialization)?),
                None,
                options,
            )
            .await
    }
}
