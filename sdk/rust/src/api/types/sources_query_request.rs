pub use crate::prelude::*;

/// Query parameters for sources
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct SourcesQueryRequest {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub cursor: Option<String>,
}

impl SourcesQueryRequest {
    pub fn builder() -> SourcesQueryRequestBuilder {
        <SourcesQueryRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct SourcesQueryRequestBuilder {
    cursor: Option<String>,
}

impl SourcesQueryRequestBuilder {
    pub fn cursor(mut self, value: impl Into<String>) -> Self {
        self.cursor = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`SourcesQueryRequest`].
    pub fn build(self) -> Result<SourcesQueryRequest, BuildError> {
        Ok(SourcesQueryRequest {
            cursor: self.cursor,
        })
    }
}
