pub use crate::prelude::*;

/// Query parameters for getRollbackPlan
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct GetRollbackPlanQueryRequest {
    #[serde(rename = "revisionId")]
    #[serde(default)]
    pub revision_id: String,
}

impl GetRollbackPlanQueryRequest {
    pub fn builder() -> GetRollbackPlanQueryRequestBuilder {
        <GetRollbackPlanQueryRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct GetRollbackPlanQueryRequestBuilder {
    revision_id: Option<String>,
}

impl GetRollbackPlanQueryRequestBuilder {
    pub fn revision_id(mut self, value: impl Into<String>) -> Self {
        self.revision_id = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`GetRollbackPlanQueryRequest`].
    /// This method will fail if any of the following fields are not set:
    /// - [`revision_id`](GetRollbackPlanQueryRequestBuilder::revision_id)
    pub fn build(self) -> Result<GetRollbackPlanQueryRequest, BuildError> {
        Ok(GetRollbackPlanQueryRequest {
            revision_id: self
                .revision_id
                .ok_or_else(|| BuildError::missing_field("revision_id"))?,
        })
    }
}
