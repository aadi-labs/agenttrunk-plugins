pub use crate::prelude::*;

/// Query parameters for list
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct ReleasesListQueryRequest {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub cursor: Option<String>,
    #[serde(rename = "scopeId")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub scope_id: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub status: Option<ListReleasesRequestStatus>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub limit: Option<i64>,
}

impl ReleasesListQueryRequest {
    pub fn builder() -> ReleasesListQueryRequestBuilder {
        <ReleasesListQueryRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ReleasesListQueryRequestBuilder {
    cursor: Option<String>,
    scope_id: Option<String>,
    status: Option<ListReleasesRequestStatus>,
    limit: Option<i64>,
}

impl ReleasesListQueryRequestBuilder {
    pub fn cursor(mut self, value: impl Into<String>) -> Self {
        self.cursor = Some(value.into());
        self
    }

    pub fn scope_id(mut self, value: impl Into<String>) -> Self {
        self.scope_id = Some(value.into());
        self
    }

    pub fn status(mut self, value: ListReleasesRequestStatus) -> Self {
        self.status = Some(value);
        self
    }

    pub fn limit(mut self, value: i64) -> Self {
        self.limit = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`ReleasesListQueryRequest`].
    pub fn build(self) -> Result<ReleasesListQueryRequest, BuildError> {
        Ok(ReleasesListQueryRequest {
            cursor: self.cursor,
            scope_id: self.scope_id,
            status: self.status,
            limit: self.limit,
        })
    }
}
