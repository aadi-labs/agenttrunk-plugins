pub use crate::prelude::*;

/// Copy one authorized immutable context revision into the new workspace's staging environment. Copies verified files and current display metadata, not history, notes, permissions or production releases. The workspace name is reserved for this exact baseline; retry with identical inputs after a partial failure. Destination storage allowances apply. This is a snapshot copy, not a full Git repository fork.
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct CreateTrunkInputBaseline {
    #[serde(rename = "trunkId")]
    #[serde(default)]
    pub trunk_id: String,
    #[serde(rename = "contextKey")]
    #[serde(default)]
    pub context_key: String,
    #[serde(rename = "revisionId")]
    #[serde(default)]
    pub revision_id: String,
}

impl CreateTrunkInputBaseline {
    pub fn builder() -> CreateTrunkInputBaselineBuilder {
        <CreateTrunkInputBaselineBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct CreateTrunkInputBaselineBuilder {
    trunk_id: Option<String>,
    context_key: Option<String>,
    revision_id: Option<String>,
}

impl CreateTrunkInputBaselineBuilder {
    pub fn trunk_id(mut self, value: impl Into<String>) -> Self {
        self.trunk_id = Some(value.into());
        self
    }

    pub fn context_key(mut self, value: impl Into<String>) -> Self {
        self.context_key = Some(value.into());
        self
    }

    pub fn revision_id(mut self, value: impl Into<String>) -> Self {
        self.revision_id = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`CreateTrunkInputBaseline`].
    /// This method will fail if any of the following fields are not set:
    /// - [`trunk_id`](CreateTrunkInputBaselineBuilder::trunk_id)
    /// - [`context_key`](CreateTrunkInputBaselineBuilder::context_key)
    /// - [`revision_id`](CreateTrunkInputBaselineBuilder::revision_id)
    pub fn build(self) -> Result<CreateTrunkInputBaseline, BuildError> {
        Ok(CreateTrunkInputBaseline {
            trunk_id: self
                .trunk_id
                .ok_or_else(|| BuildError::missing_field("trunk_id"))?,
            context_key: self
                .context_key
                .ok_or_else(|| BuildError::missing_field("context_key"))?,
            revision_id: self
                .revision_id
                .ok_or_else(|| BuildError::missing_field("revision_id"))?,
        })
    }
}
