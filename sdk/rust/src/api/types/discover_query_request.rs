pub use crate::prelude::*;

/// Query parameters for discover
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct DiscoverQueryRequest {
    /// Filter by scope before applying the result limit.
    #[serde(rename = "scopeId")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub scope_id: Option<String>,
    /// Opaque snapshot continuation returned by the preceding page. Keep filters and principal unchanged; cursors expire after 15 minutes. Authorization is always rechecked. Restart pagination for expired or legacy numeric cursors.
    #[serde(skip_serializing_if = "Option::is_none")]
    pub cursor: Option<String>,
    /// Narrow discovery to this authorized trunk before applying the result limit.
    #[serde(rename = "trunkId")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub trunk_id: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub query: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub channel: Option<DiscoverContextsRequestChannel>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub limit: Option<i64>,
}

impl DiscoverQueryRequest {
    pub fn builder() -> DiscoverQueryRequestBuilder {
        <DiscoverQueryRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct DiscoverQueryRequestBuilder {
    scope_id: Option<String>,
    cursor: Option<String>,
    trunk_id: Option<String>,
    query: Option<String>,
    channel: Option<DiscoverContextsRequestChannel>,
    limit: Option<i64>,
}

impl DiscoverQueryRequestBuilder {
    pub fn scope_id(mut self, value: impl Into<String>) -> Self {
        self.scope_id = Some(value.into());
        self
    }

    pub fn cursor(mut self, value: impl Into<String>) -> Self {
        self.cursor = Some(value.into());
        self
    }

    pub fn trunk_id(mut self, value: impl Into<String>) -> Self {
        self.trunk_id = Some(value.into());
        self
    }

    pub fn query(mut self, value: impl Into<String>) -> Self {
        self.query = Some(value.into());
        self
    }

    pub fn channel(mut self, value: DiscoverContextsRequestChannel) -> Self {
        self.channel = Some(value);
        self
    }

    pub fn limit(mut self, value: i64) -> Self {
        self.limit = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`DiscoverQueryRequest`].
    pub fn build(self) -> Result<DiscoverQueryRequest, BuildError> {
        Ok(DiscoverQueryRequest {
            scope_id: self.scope_id,
            cursor: self.cursor,
            trunk_id: self.trunk_id,
            query: self.query,
            channel: self.channel,
            limit: self.limit,
        })
    }
}
