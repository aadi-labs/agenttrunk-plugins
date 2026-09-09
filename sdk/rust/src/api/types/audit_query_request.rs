pub use crate::prelude::*;

/// Query parameters for audit
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct AuditQueryRequest {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub limit: Option<i64>,
}

impl AuditQueryRequest {
    pub fn builder() -> AuditQueryRequestBuilder {
        <AuditQueryRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct AuditQueryRequestBuilder {
    limit: Option<i64>,
}

impl AuditQueryRequestBuilder {
    pub fn limit(mut self, value: i64) -> Self {
        self.limit = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`AuditQueryRequest`].
    pub fn build(self) -> Result<AuditQueryRequest, BuildError> {
        Ok(AuditQueryRequest { limit: self.limit })
    }
}
