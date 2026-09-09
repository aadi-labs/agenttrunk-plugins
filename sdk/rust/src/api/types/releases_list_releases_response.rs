pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct ListReleasesResponse {
    #[serde(default)]
    pub data: Vec<PromotionRequest>,
    #[serde(rename = "nextCursor")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub next_cursor: Option<String>,
}

impl ListReleasesResponse {
    pub fn builder() -> ListReleasesResponseBuilder {
        <ListReleasesResponseBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ListReleasesResponseBuilder {
    data: Option<Vec<PromotionRequest>>,
    next_cursor: Option<String>,
}

impl ListReleasesResponseBuilder {
    pub fn data(mut self, value: Vec<PromotionRequest>) -> Self {
        self.data = Some(value);
        self
    }

    pub fn next_cursor(mut self, value: impl Into<String>) -> Self {
        self.next_cursor = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`ListReleasesResponse`].
    /// This method will fail if any of the following fields are not set:
    /// - [`data`](ListReleasesResponseBuilder::data)
    pub fn build(self) -> Result<ListReleasesResponse, BuildError> {
        Ok(ListReleasesResponse {
            data: self.data.ok_or_else(|| BuildError::missing_field("data"))?,
            next_cursor: self.next_cursor,
        })
    }
}
