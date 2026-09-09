pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct StageRollbackContextsRequest {
    #[serde(rename = "revisionId")]
    #[serde(default)]
    pub revision_id: String,
    #[serde(rename = "expectedStagingRevisionId")]
    #[serde(default)]
    pub expected_staging_revision_id: String,
    #[serde(default)]
    pub reason: String,
}

impl StageRollbackContextsRequest {
    pub fn builder() -> StageRollbackContextsRequestBuilder {
        <StageRollbackContextsRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct StageRollbackContextsRequestBuilder {
    revision_id: Option<String>,
    expected_staging_revision_id: Option<String>,
    reason: Option<String>,
}

impl StageRollbackContextsRequestBuilder {
    pub fn revision_id(mut self, value: impl Into<String>) -> Self {
        self.revision_id = Some(value.into());
        self
    }

    pub fn expected_staging_revision_id(mut self, value: impl Into<String>) -> Self {
        self.expected_staging_revision_id = Some(value.into());
        self
    }

    pub fn reason(mut self, value: impl Into<String>) -> Self {
        self.reason = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`StageRollbackContextsRequest`].
    /// This method will fail if any of the following fields are not set:
    /// - [`revision_id`](StageRollbackContextsRequestBuilder::revision_id)
    /// - [`expected_staging_revision_id`](StageRollbackContextsRequestBuilder::expected_staging_revision_id)
    /// - [`reason`](StageRollbackContextsRequestBuilder::reason)
    pub fn build(self) -> Result<StageRollbackContextsRequest, BuildError> {
        Ok(StageRollbackContextsRequest {
            revision_id: self
                .revision_id
                .ok_or_else(|| BuildError::missing_field("revision_id"))?,
            expected_staging_revision_id: self
                .expected_staging_revision_id
                .ok_or_else(|| BuildError::missing_field("expected_staging_revision_id"))?,
            reason: self
                .reason
                .ok_or_else(|| BuildError::missing_field("reason"))?,
        })
    }
}
