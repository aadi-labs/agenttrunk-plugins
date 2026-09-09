pub use crate::prelude::*;

/// Query parameters for readFile
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct ReadFileQueryRequest {
    /// Immutable revision ID from inspect; resolve moving channels before reading.
    #[serde(default)]
    pub r#ref: String,
}

impl ReadFileQueryRequest {
    pub fn builder() -> ReadFileQueryRequestBuilder {
        <ReadFileQueryRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ReadFileQueryRequestBuilder {
    r#ref: Option<String>,
}

impl ReadFileQueryRequestBuilder {
    pub fn r#ref(mut self, value: impl Into<String>) -> Self {
        self.r#ref = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`ReadFileQueryRequest`].
    /// This method will fail if any of the following fields are not set:
    /// - [`r#ref`](ReadFileQueryRequestBuilder::r#ref)
    pub fn build(self) -> Result<ReadFileQueryRequest, BuildError> {
        Ok(ReadFileQueryRequest {
            r#ref: self
                .r#ref
                .ok_or_else(|| BuildError::missing_field("r#ref"))?,
        })
    }
}
