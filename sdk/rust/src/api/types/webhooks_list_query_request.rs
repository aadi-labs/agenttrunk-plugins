pub use crate::prelude::*;

/// Query parameters for list
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct WebhooksListQueryRequest {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub before: Option<String>,
}

impl WebhooksListQueryRequest {
    pub fn builder() -> WebhooksListQueryRequestBuilder {
        <WebhooksListQueryRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct WebhooksListQueryRequestBuilder {
    before: Option<String>,
}

impl WebhooksListQueryRequestBuilder {
    pub fn before(mut self, value: impl Into<String>) -> Self {
        self.before = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`WebhooksListQueryRequest`].
    pub fn build(self) -> Result<WebhooksListQueryRequest, BuildError> {
        Ok(WebhooksListQueryRequest {
            before: self.before,
        })
    }
}
