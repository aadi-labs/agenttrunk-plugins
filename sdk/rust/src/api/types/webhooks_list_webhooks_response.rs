pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct ListWebhooksResponse {
    #[serde(rename = "nextCursor")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub next_cursor: Option<String>,
    #[serde(default)]
    pub data: Vec<ListWebhooksResponseDataItem>,
}

impl ListWebhooksResponse {
    pub fn builder() -> ListWebhooksResponseBuilder {
        <ListWebhooksResponseBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ListWebhooksResponseBuilder {
    next_cursor: Option<String>,
    data: Option<Vec<ListWebhooksResponseDataItem>>,
}

impl ListWebhooksResponseBuilder {
    pub fn next_cursor(mut self, value: impl Into<String>) -> Self {
        self.next_cursor = Some(value.into());
        self
    }

    pub fn data(mut self, value: Vec<ListWebhooksResponseDataItem>) -> Self {
        self.data = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`ListWebhooksResponse`].
    /// This method will fail if any of the following fields are not set:
    /// - [`data`](ListWebhooksResponseBuilder::data)
    pub fn build(self) -> Result<ListWebhooksResponse, BuildError> {
        Ok(ListWebhooksResponse {
            next_cursor: self.next_cursor,
            data: self.data.ok_or_else(|| BuildError::missing_field("data"))?,
        })
    }
}
