pub use crate::prelude::*;

/// Query parameters for history
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct HistoryQueryRequest {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub from: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub limit: Option<i64>,
}

impl HistoryQueryRequest {
    pub fn builder() -> HistoryQueryRequestBuilder {
        <HistoryQueryRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct HistoryQueryRequestBuilder {
    from: Option<String>,
    limit: Option<i64>,
}

impl HistoryQueryRequestBuilder {
    pub fn from(mut self, value: impl Into<String>) -> Self {
        self.from = Some(value.into());
        self
    }

    pub fn limit(mut self, value: i64) -> Self {
        self.limit = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`HistoryQueryRequest`].
    pub fn build(self) -> Result<HistoryQueryRequest, BuildError> {
        Ok(HistoryQueryRequest {
            from: self.from,
            limit: self.limit,
        })
    }
}
