pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct ContextSetSource {
    #[serde(rename = "sourceTrunkId")]
    #[serde(default)]
    pub source_trunk_id: String,
    #[serde(rename = "sourceScopeId")]
    #[serde(default)]
    pub source_scope_id: String,
    #[serde(rename = "environmentId")]
    #[serde(default)]
    pub environment_id: String,
    #[serde(rename = "contextKey")]
    #[serde(default)]
    pub context_key: String,
    #[serde(rename = "revisionId")]
    #[serde(default)]
    pub revision_id: String,
    #[serde(rename = "packageDigest")]
    #[serde(default)]
    pub package_digest: String,
    #[serde(rename = "mountPath")]
    #[serde(default)]
    pub mount_path: String,
    #[serde(default)]
    pub required: bool,
}

impl ContextSetSource {
    pub fn builder() -> ContextSetSourceBuilder {
        <ContextSetSourceBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ContextSetSourceBuilder {
    source_trunk_id: Option<String>,
    source_scope_id: Option<String>,
    environment_id: Option<String>,
    context_key: Option<String>,
    revision_id: Option<String>,
    package_digest: Option<String>,
    mount_path: Option<String>,
    required: Option<bool>,
}

impl ContextSetSourceBuilder {
    pub fn source_trunk_id(mut self, value: impl Into<String>) -> Self {
        self.source_trunk_id = Some(value.into());
        self
    }

    pub fn source_scope_id(mut self, value: impl Into<String>) -> Self {
        self.source_scope_id = Some(value.into());
        self
    }

    pub fn environment_id(mut self, value: impl Into<String>) -> Self {
        self.environment_id = Some(value.into());
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

    pub fn package_digest(mut self, value: impl Into<String>) -> Self {
        self.package_digest = Some(value.into());
        self
    }

    pub fn mount_path(mut self, value: impl Into<String>) -> Self {
        self.mount_path = Some(value.into());
        self
    }

    pub fn required(mut self, value: bool) -> Self {
        self.required = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`ContextSetSource`].
    /// This method will fail if any of the following fields are not set:
    /// - [`source_trunk_id`](ContextSetSourceBuilder::source_trunk_id)
    /// - [`source_scope_id`](ContextSetSourceBuilder::source_scope_id)
    /// - [`environment_id`](ContextSetSourceBuilder::environment_id)
    /// - [`context_key`](ContextSetSourceBuilder::context_key)
    /// - [`revision_id`](ContextSetSourceBuilder::revision_id)
    /// - [`package_digest`](ContextSetSourceBuilder::package_digest)
    /// - [`mount_path`](ContextSetSourceBuilder::mount_path)
    /// - [`required`](ContextSetSourceBuilder::required)
    pub fn build(self) -> Result<ContextSetSource, BuildError> {
        Ok(ContextSetSource {
            source_trunk_id: self
                .source_trunk_id
                .ok_or_else(|| BuildError::missing_field("source_trunk_id"))?,
            source_scope_id: self
                .source_scope_id
                .ok_or_else(|| BuildError::missing_field("source_scope_id"))?,
            environment_id: self
                .environment_id
                .ok_or_else(|| BuildError::missing_field("environment_id"))?,
            context_key: self
                .context_key
                .ok_or_else(|| BuildError::missing_field("context_key"))?,
            revision_id: self
                .revision_id
                .ok_or_else(|| BuildError::missing_field("revision_id"))?,
            package_digest: self
                .package_digest
                .ok_or_else(|| BuildError::missing_field("package_digest"))?,
            mount_path: self
                .mount_path
                .ok_or_else(|| BuildError::missing_field("mount_path"))?,
            required: self
                .required
                .ok_or_else(|| BuildError::missing_field("required"))?,
        })
    }
}
