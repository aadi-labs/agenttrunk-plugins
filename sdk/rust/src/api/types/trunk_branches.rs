pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct TrunkBranches {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub staging: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub production: Option<String>,
}

impl TrunkBranches {
    pub fn builder() -> TrunkBranchesBuilder {
        <TrunkBranchesBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct TrunkBranchesBuilder {
    staging: Option<String>,
    production: Option<String>,
}

impl TrunkBranchesBuilder {
    pub fn staging(mut self, value: impl Into<String>) -> Self {
        self.staging = Some(value.into());
        self
    }

    pub fn production(mut self, value: impl Into<String>) -> Self {
        self.production = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`TrunkBranches`].
    pub fn build(self) -> Result<TrunkBranches, BuildError> {
        Ok(TrunkBranches {
            staging: self.staging,
            production: self.production,
        })
    }
}
