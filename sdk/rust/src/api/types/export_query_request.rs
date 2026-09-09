pub use crate::prelude::*;

/// Query parameters for export
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct ExportQueryRequest {
    #[serde(rename = "revisionId")]
    #[serde(default)]
    pub revision_id: String,
}

impl ExportQueryRequest {
    pub fn builder() -> ExportQueryRequestBuilder {
        <ExportQueryRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ExportQueryRequestBuilder {
    revision_id: Option<String>,
}

impl ExportQueryRequestBuilder {
    pub fn revision_id(mut self, value: impl Into<String>) -> Self {
        self.revision_id = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`ExportQueryRequest`].
    /// This method will fail if any of the following fields are not set:
    /// - [`revision_id`](ExportQueryRequestBuilder::revision_id)
    pub fn build(self) -> Result<ExportQueryRequest, BuildError> {
        Ok(ExportQueryRequest {
            revision_id: self
                .revision_id
                .ok_or_else(|| BuildError::missing_field("revision_id"))?,
        })
    }
}
