pub use crate::prelude::*;

/// Query parameters for list
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct WorkspacesListQueryRequest {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub cursor: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub q: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub limit: Option<i64>,
}

impl WorkspacesListQueryRequest {
    pub fn builder() -> WorkspacesListQueryRequestBuilder {
        <WorkspacesListQueryRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct WorkspacesListQueryRequestBuilder {
    cursor: Option<String>,
    q: Option<String>,
    limit: Option<i64>,
}

impl WorkspacesListQueryRequestBuilder {
    pub fn cursor(mut self, value: impl Into<String>) -> Self {
        self.cursor = Some(value.into());
        self
    }

    pub fn q(mut self, value: impl Into<String>) -> Self {
        self.q = Some(value.into());
        self
    }

    pub fn limit(mut self, value: i64) -> Self {
        self.limit = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`WorkspacesListQueryRequest`].
    pub fn build(self) -> Result<WorkspacesListQueryRequest, BuildError> {
        Ok(WorkspacesListQueryRequest {
            cursor: self.cursor,
            q: self.q,
            limit: self.limit,
        })
    }
}
