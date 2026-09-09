use crate::api::*;
use crate::{ApiError, ClientConfig, HttpClient, QueryBuilder, RequestOptions};
use reqwest::Method;

pub struct ReleasesClient {
    pub http_client: HttpClient,
}

impl ReleasesClient {
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
    ///     client
    ///         .releases
    ///         .list(
    ///             &"trunkId".to_string(),
    ///             &ReleasesListQueryRequest {
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
        request: &ReleasesListQueryRequest,
        options: Option<RequestOptions>,
    ) -> Result<ListReleasesResponse, ApiError> {
        self.http_client
            .execute_request(
                Method::GET,
                &format!("v1/trunks/{}/promotion-requests", crate::safety::path_param(trunk_id)?),
                None,
                QueryBuilder::new()
                    .string("cursor", request.cursor.clone())
                    .string("scopeId", request.scope_id.clone())
                    .serialize("status", request.status.clone())
                    .int("limit", request.limit.clone())
                    .build(),
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
    ///         .releases
    ///         .open(
    ///             &"trunkId".to_string(),
    ///             &OpenPromotionRequestInput {
    ///                 ..Default::default()
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn open(
        &self,
        trunk_id: &str,
        request: &OpenPromotionRequestInput,
        options: Option<RequestOptions>,
    ) -> Result<PromotionRequest, ApiError> {
        self.http_client
            .execute_request(
                Method::POST,
                &format!("v1/trunks/{}/promotion-requests", crate::safety::path_param(trunk_id)?),
                Some(serde_json::to_value(request).map_err(ApiError::Serialization)?),
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
    ///         .releases
    ///         .merge(&"trunkId".to_string(), &"promotionId".to_string(), None)
    ///         .await;
    /// }
    /// ```
    pub async fn merge(
        &self,
        trunk_id: &str,
        promotion_id: &str,
        options: Option<RequestOptions>,
    ) -> Result<PromotionRequest, ApiError> {
        self.http_client
            .execute_request(
                Method::POST,
                &format!("v1/trunks/{}/promotion-requests/{}/merge", crate::safety::path_param(trunk_id)?, crate::safety::path_param(promotion_id)?),
                None,
                None,
                options,
            )
            .await
    }
}
