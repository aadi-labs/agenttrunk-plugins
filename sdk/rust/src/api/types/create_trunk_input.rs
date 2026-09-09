pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct CreateTrunkInput {
    #[serde(default)]
    pub name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub description: Option<String>,
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

    /// Consumes the builder and constructs a [`CreateTrunkInput`].
    /// This method will fail if any of the following fields are not set:
    /// - [`name`](CreateTrunkInputBuilder::name)
    pub fn build(self) -> Result<CreateTrunkInput, BuildError> {
        Ok(CreateTrunkInput {
            name: self.name.ok_or_else(|| BuildError::missing_field("name"))?,
            description: self.description,
        })
    }
}
