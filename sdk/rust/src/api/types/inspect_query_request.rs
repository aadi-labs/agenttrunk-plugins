pub use crate::prelude::*;

/// Query parameters for inspect
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct InspectQueryRequest {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub r#ref: Option<String>,
}

impl InspectQueryRequest {
    pub fn builder() -> InspectQueryRequestBuilder {
        <InspectQueryRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct InspectQueryRequestBuilder {
    r#ref: Option<String>,
}

impl InspectQueryRequestBuilder {
    pub fn r#ref(mut self, value: impl Into<String>) -> Self {
        self.r#ref = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`InspectQueryRequest`].
    pub fn build(self) -> Result<InspectQueryRequest, BuildError> {
        Ok(InspectQueryRequest { r#ref: self.r#ref })
    }
}
