pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct DiscoverContextsResponse {
    #[serde(default)]
    pub data: Vec<DiscoveryResult>,
    /// Continue until null, including after empty pages. At most 100 candidates are authorization-checked per request.
    #[serde(rename = "nextCursor")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub next_cursor: Option<String>,
}

impl DiscoverContextsResponse {
    pub fn builder() -> DiscoverContextsResponseBuilder {
        <DiscoverContextsResponseBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct DiscoverContextsResponseBuilder {
    data: Option<Vec<DiscoveryResult>>,
    next_cursor: Option<String>,
}

impl DiscoverContextsResponseBuilder {
    pub fn data(mut self, value: Vec<DiscoveryResult>) -> Self {
        self.data = Some(value);
        self
    }

    pub fn next_cursor(mut self, value: impl Into<String>) -> Self {
        self.next_cursor = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`DiscoverContextsResponse`].
    /// This method will fail if any of the following fields are not set:
    /// - [`data`](DiscoverContextsResponseBuilder::data)
    pub fn build(self) -> Result<DiscoverContextsResponse, BuildError> {
        Ok(DiscoverContextsResponse {
            data: self.data.ok_or_else(|| BuildError::missing_field("data"))?,
            next_cursor: self.next_cursor,
        })
    }
}
