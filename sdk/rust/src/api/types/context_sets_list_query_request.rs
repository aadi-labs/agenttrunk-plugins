pub use crate::prelude::*;

/// Query parameters for list
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct ContextSetsListQueryRequest {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub cursor: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub limit: Option<i64>,
}

impl ContextSetsListQueryRequest {
    pub fn builder() -> ContextSetsListQueryRequestBuilder {
        <ContextSetsListQueryRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ContextSetsListQueryRequestBuilder {
    cursor: Option<String>,
    limit: Option<i64>,
}

impl ContextSetsListQueryRequestBuilder {
    pub fn cursor(mut self, value: impl Into<String>) -> Self {
        self.cursor = Some(value.into());
        self
    }

    pub fn limit(mut self, value: i64) -> Self {
        self.limit = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`ContextSetsListQueryRequest`].
    pub fn build(self) -> Result<ContextSetsListQueryRequest, BuildError> {
        Ok(ContextSetsListQueryRequest {
            cursor: self.cursor,
            limit: self.limit,
        })
    }
}
