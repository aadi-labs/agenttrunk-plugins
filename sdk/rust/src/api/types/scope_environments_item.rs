pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct ScopeEnvironmentsItem {
    #[serde(default)]
    pub id: String,
    pub name: ScopeEnvironmentsItemName,
    #[serde(rename = "commitSha")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub commit_sha: Option<String>,
    #[serde(rename = "canDeploy")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub can_deploy: Option<bool>,
    #[serde(rename = "canPropose")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub can_propose: Option<bool>,
    #[serde(rename = "canPublish")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub can_publish: Option<bool>,
}

impl ScopeEnvironmentsItem {
    pub fn builder() -> ScopeEnvironmentsItemBuilder {
        <ScopeEnvironmentsItemBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ScopeEnvironmentsItemBuilder {
    id: Option<String>,
    name: Option<ScopeEnvironmentsItemName>,
    commit_sha: Option<String>,
    can_deploy: Option<bool>,
    can_propose: Option<bool>,
    can_publish: Option<bool>,
}

impl ScopeEnvironmentsItemBuilder {
    pub fn id(mut self, value: impl Into<String>) -> Self {
        self.id = Some(value.into());
        self
    }

    pub fn name(mut self, value: ScopeEnvironmentsItemName) -> Self {
        self.name = Some(value);
        self
    }

    pub fn commit_sha(mut self, value: impl Into<String>) -> Self {
        self.commit_sha = Some(value.into());
        self
    }

    pub fn can_deploy(mut self, value: bool) -> Self {
        self.can_deploy = Some(value);
        self
    }

    pub fn can_propose(mut self, value: bool) -> Self {
        self.can_propose = Some(value);
        self
    }

    pub fn can_publish(mut self, value: bool) -> Self {
        self.can_publish = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`ScopeEnvironmentsItem`].
    /// This method will fail if any of the following fields are not set:
    /// - [`id`](ScopeEnvironmentsItemBuilder::id)
    /// - [`name`](ScopeEnvironmentsItemBuilder::name)
    pub fn build(self) -> Result<ScopeEnvironmentsItem, BuildError> {
        Ok(ScopeEnvironmentsItem {
            id: self.id.ok_or_else(|| BuildError::missing_field("id"))?,
            name: self.name.ok_or_else(|| BuildError::missing_field("name"))?,
            commit_sha: self.commit_sha,
            can_deploy: self.can_deploy,
            can_propose: self.can_propose,
            can_publish: self.can_publish,
        })
    }
}
