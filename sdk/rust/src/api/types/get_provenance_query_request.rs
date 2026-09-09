pub use crate::prelude::*;

/// Query parameters for getProvenance
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct GetProvenanceQueryRequest {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub r#ref: Option<String>,
}

impl GetProvenanceQueryRequest {
    pub fn builder() -> GetProvenanceQueryRequestBuilder {
        <GetProvenanceQueryRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct GetProvenanceQueryRequestBuilder {
    r#ref: Option<String>,
}

impl GetProvenanceQueryRequestBuilder {
    pub fn r#ref(mut self, value: impl Into<String>) -> Self {
        self.r#ref = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`GetProvenanceQueryRequest`].
    pub fn build(self) -> Result<GetProvenanceQueryRequest, BuildError> {
        Ok(GetProvenanceQueryRequest { r#ref: self.r#ref })
    }
}
