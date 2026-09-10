pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct CreateTrunkInput {
    #[serde(default)]
    pub name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub description: Option<String>,
    /// Copy one authorized immutable context revision into the new workspace's staging environment. Copies verified files and current display metadata, not history, notes, permissions or production releases. The workspace name is reserved for this exact baseline; retry with identical inputs after a partial failure. Destination storage allowances apply. This is a snapshot copy, not a full Git repository fork.
    #[serde(skip_serializing_if = "Option::is_none")]
    pub baseline: Option<CreateTrunkInputBaseline>,
}

impl CreateTrunkInput {
    pub fn builder() -> CreateTrunkInputBuilder {
        <CreateTrunkInputBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct CreateTrunkInputBuilder {
    name: Option<String>,
    description: Option<String>,
    baseline: Option<CreateTrunkInputBaseline>,
}

impl CreateTrunkInputBuilder {
    pub fn name(mut self, value: impl Into<String>) -> Self {
        self.name = Some(value.into());
        self
    }

    pub fn description(mut self, value: impl Into<String>) -> Self {
        self.description = Some(value.into());
        self
    }

    pub fn baseline(mut self, value: CreateTrunkInputBaseline) -> Self {
        self.baseline = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`CreateTrunkInput`].
    /// This method will fail if any of the following fields are not set:
    /// - [`name`](CreateTrunkInputBuilder::name)
    pub fn build(self) -> Result<CreateTrunkInput, BuildError> {
        Ok(CreateTrunkInput {
            name: self.name.ok_or_else(|| BuildError::missing_field("name"))?,
            description: self.description,
            baseline: self.baseline,
        })
    }
}
