pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct CreatePortalWebhooksResponse {
    #[serde(default)]
    pub url: String,
}

impl CreatePortalWebhooksResponse {
    pub fn builder() -> CreatePortalWebhooksResponseBuilder {
        <CreatePortalWebhooksResponseBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct CreatePortalWebhooksResponseBuilder {
    url: Option<String>,
}

impl CreatePortalWebhooksResponseBuilder {
    pub fn url(mut self, value: impl Into<String>) -> Self {
        self.url = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`CreatePortalWebhooksResponse`].
    /// This method will fail if any of the following fields are not set:
    /// - [`url`](CreatePortalWebhooksResponseBuilder::url)
    pub fn build(self) -> Result<CreatePortalWebhooksResponse, BuildError> {
        Ok(CreatePortalWebhooksResponse {
            url: self.url.ok_or_else(|| BuildError::missing_field("url"))?,
        })
    }
}
