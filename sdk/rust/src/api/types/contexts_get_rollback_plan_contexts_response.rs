pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct GetRollbackPlanContextsResponse {
    #[serde(default)]
    pub eligible: bool,
    #[serde(rename = "expectedStagingRevisionId")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub expected_staging_revision_id: Option<String>,
    #[serde(default)]
    pub reason: String,
}

impl GetRollbackPlanContextsResponse {
    pub fn builder() -> GetRollbackPlanContextsResponseBuilder {
        <GetRollbackPlanContextsResponseBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct GetRollbackPlanContextsResponseBuilder {
    eligible: Option<bool>,
    expected_staging_revision_id: Option<String>,
    reason: Option<String>,
}

impl GetRollbackPlanContextsResponseBuilder {
    pub fn eligible(mut self, value: bool) -> Self {
        self.eligible = Some(value);
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

    /// Consumes the builder and constructs a [`GetRollbackPlanContextsResponse`].
    /// This method will fail if any of the following fields are not set:
    /// - [`eligible`](GetRollbackPlanContextsResponseBuilder::eligible)
    /// - [`reason`](GetRollbackPlanContextsResponseBuilder::reason)
    pub fn build(self) -> Result<GetRollbackPlanContextsResponse, BuildError> {
        Ok(GetRollbackPlanContextsResponse {
            eligible: self
                .eligible
                .ok_or_else(|| BuildError::missing_field("eligible"))?,
            expected_staging_revision_id: self.expected_staging_revision_id,
            reason: self
                .reason
                .ok_or_else(|| BuildError::missing_field("reason"))?,
        })
    }
}
