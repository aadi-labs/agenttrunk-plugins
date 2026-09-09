pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct DiscoveryResult {
    #[serde(rename = "trunkId")]
    #[serde(default)]
    pub trunk_id: String,
    #[serde(rename = "scopeId")]
    #[serde(default)]
    pub scope_id: String,
    #[serde(rename = "contextKey")]
    #[serde(default)]
    pub context_key: String,
    #[serde(default)]
    pub title: String,
    pub kind: ContextKind,
    #[serde(default)]
    pub summary: String,
    #[serde(default)]
    pub tags: Vec<String>,
    #[serde(rename = "revisionId")]
    #[serde(default)]
    pub revision_id: String,
    #[serde(rename = "packageDigest")]
    #[serde(default)]
    pub package_digest: String,
    pub channel: DiscoveryResultChannel,
    #[serde(rename = "updatedAt")]
    #[serde(default)]
    #[serde(with = "crate::core::flexible_datetime::offset")]
    pub updated_at: DateTime<FixedOffset>,
}

impl DiscoveryResult {
    pub fn builder() -> DiscoveryResultBuilder {
        <DiscoveryResultBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct DiscoveryResultBuilder {
    trunk_id: Option<String>,
    scope_id: Option<String>,
    context_key: Option<String>,
    title: Option<String>,
    kind: Option<ContextKind>,
    summary: Option<String>,
    tags: Option<Vec<String>>,
    revision_id: Option<String>,
    package_digest: Option<String>,
    channel: Option<DiscoveryResultChannel>,
    updated_at: Option<DateTime<FixedOffset>>,
}

impl DiscoveryResultBuilder {
    pub fn trunk_id(mut self, value: impl Into<String>) -> Self {
        self.trunk_id = Some(value.into());
        self
    }

    pub fn scope_id(mut self, value: impl Into<String>) -> Self {
        self.scope_id = Some(value.into());
        self
    }

    pub fn context_key(mut self, value: impl Into<String>) -> Self {
        self.context_key = Some(value.into());
        self
    }

    pub fn title(mut self, value: impl Into<String>) -> Self {
        self.title = Some(value.into());
        self
    }

    pub fn kind(mut self, value: ContextKind) -> Self {
        self.kind = Some(value);
        self
    }

    pub fn summary(mut self, value: impl Into<String>) -> Self {
        self.summary = Some(value.into());
        self
    }

    pub fn tags(mut self, value: Vec<String>) -> Self {
        self.tags = Some(value);
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

    pub fn channel(mut self, value: DiscoveryResultChannel) -> Self {
        self.channel = Some(value);
        self
    }

    pub fn updated_at(mut self, value: DateTime<FixedOffset>) -> Self {
        self.updated_at = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`DiscoveryResult`].
    /// This method will fail if any of the following fields are not set:
    /// - [`trunk_id`](DiscoveryResultBuilder::trunk_id)
    /// - [`scope_id`](DiscoveryResultBuilder::scope_id)
    /// - [`context_key`](DiscoveryResultBuilder::context_key)
    /// - [`title`](DiscoveryResultBuilder::title)
    /// - [`kind`](DiscoveryResultBuilder::kind)
    /// - [`summary`](DiscoveryResultBuilder::summary)
    /// - [`tags`](DiscoveryResultBuilder::tags)
    /// - [`revision_id`](DiscoveryResultBuilder::revision_id)
    /// - [`package_digest`](DiscoveryResultBuilder::package_digest)
    /// - [`channel`](DiscoveryResultBuilder::channel)
    /// - [`updated_at`](DiscoveryResultBuilder::updated_at)
    pub fn build(self) -> Result<DiscoveryResult, BuildError> {
        Ok(DiscoveryResult {
            trunk_id: self
                .trunk_id
                .ok_or_else(|| BuildError::missing_field("trunk_id"))?,
            scope_id: self
                .scope_id
                .ok_or_else(|| BuildError::missing_field("scope_id"))?,
            context_key: self
                .context_key
                .ok_or_else(|| BuildError::missing_field("context_key"))?,
            title: self
                .title
                .ok_or_else(|| BuildError::missing_field("title"))?,
            kind: self.kind.ok_or_else(|| BuildError::missing_field("kind"))?,
            summary: self
                .summary
                .ok_or_else(|| BuildError::missing_field("summary"))?,
            tags: self.tags.ok_or_else(|| BuildError::missing_field("tags"))?,
            revision_id: self
                .revision_id
                .ok_or_else(|| BuildError::missing_field("revision_id"))?,
            package_digest: self
                .package_digest
                .ok_or_else(|| BuildError::missing_field("package_digest"))?,
            channel: self
                .channel
                .ok_or_else(|| BuildError::missing_field("channel"))?,
            updated_at: self
                .updated_at
                .ok_or_else(|| BuildError::missing_field("updated_at"))?,
        })
    }
}
