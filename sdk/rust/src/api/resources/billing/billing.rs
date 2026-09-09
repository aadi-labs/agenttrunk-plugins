use crate::api::*;
use crate::{ApiError, ClientConfig, HttpClient, RequestOptions};
use reqwest::Method;

pub struct BillingClient {
    pub http_client: HttpClient,
}

impl BillingClient {
    pub fn new(config: ClientConfig) -> Result<Self, ApiError> {
        Ok(Self {
            http_client: HttpClient::new(config.clone())?,
        })
    }

    /// Organization subscription and usage summary. Requires billing:read. MCP metering is currently inactive.
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
    ///     client.billing.get(None).await;
    /// }
    /// ```
    pub async fn get(
        &self,
        options: Option<RequestOptions>,
    ) -> Result<GetBillingResponse, ApiError> {
        self.http_client
            .execute_request(Method::GET, "v1/billing", None, None, options)
            .await
    }

    /// Requires billing:manage. Reuses an unexpired checkout; existing subscriptions must use the portal. Body limited to 4096 bytes.
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
    ///         .billing
    ///         .create_checkout(
    ///             &CreateCheckoutBillingRequest {
    ///                 plan: CreateCheckoutBillingRequestPlan::Starter,
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn create_checkout(
        &self,
        request: &CreateCheckoutBillingRequest,
        options: Option<RequestOptions>,
    ) -> Result<CreateCheckoutBillingResponse, ApiError> {
        self.http_client
            .execute_request(
                Method::POST,
                "v1/billing/checkout",
                Some(serde_json::to_value(request).map_err(ApiError::Serialization)?),
                None,
                options,
            )
            .await
    }

    /// Requires billing:manage and an existing organization customer.
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
    ///     client.billing.create_portal(None).await;
    /// }
    /// ```
    pub async fn create_portal(
        &self,
        options: Option<RequestOptions>,
    ) -> Result<CreatePortalBillingResponse, ApiError> {
        self.http_client
            .execute_request(Method::POST, "v1/billing/portal", None, None, options)
            .await
    }

    /// Requires billing:manage. Audited organization overage cap; excludes subscription fees and taxes. Does not activate metering.
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
    ///         .billing
    ///         .set_spend_limit(&SetSpendLimitBillingRequest { cents: 1 }, None)
    ///         .await;
    /// }
    /// ```
    pub async fn set_spend_limit(
        &self,
        request: &SetSpendLimitBillingRequest,
        options: Option<RequestOptions>,
    ) -> Result<SetSpendLimitBillingResponse, ApiError> {
        self.http_client
            .execute_request(
                Method::POST,
                "v1/billing/spend-limit",
                Some(serde_json::to_value(request).map_err(ApiError::Serialization)?),
                None,
                options,
            )
            .await
    }
}
