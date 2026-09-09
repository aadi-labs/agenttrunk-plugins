pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct PublishInput {
    #[serde(rename = "contextKey")]
    #[serde(default)]
    pub context_key: String,
    #[serde(default)]
    pub title: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub summary: Option<String>,
    pub kind: ContextKind,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub tags: Option<Vec<String>>,
    #[serde(default)]
    pub files: Vec<FileInput>,
    #[serde(rename = "claimedDigest")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub claimed_digest: Option<String>,
    #[serde(rename = "scopeId")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub scope_id: Option<String>,
}

impl PublishInput {
    pub fn builder() -> PublishInputBuilder {
        <PublishInputBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct PublishInputBuilder {
    context_key: Option<String>,
    title: Option<String>,
    summary: Option<String>,
    kind: Option<ContextKind>,
    tags: Option<Vec<String>>,
    files: Option<Vec<FileInput>>,
    claimed_digest: Option<String>,
    scope_id: Option<String>,
}

impl PublishInputBuilder {
    pub fn context_key(mut self, value: impl Into<String>) -> Self {
        self.context_key = Some(value.into());
        self
    }

    pub fn title(mut self, value: impl Into<String>) -> Self {
        self.title = Some(value.into());
        self
    }

    pub fn summary(mut self, value: impl Into<String>) -> Self {
        self.summary = Some(value.into());
        self
    }

    pub fn kind(mut self, value: ContextKind) -> Self {
        self.kind = Some(value);
        self
    }

    pub fn tags(mut self, value: Vec<String>) -> Self {
        self.tags = Some(value);
        self
    }

    pub fn files(mut self, value: Vec<FileInput>) -> Self {
        self.files = Some(value);
        self
    }

    pub fn claimed_digest(mut self, value: impl Into<String>) -> Self {
        self.claimed_digest = Some(value.into());
        self
    }

    pub fn scope_id(mut self, value: impl Into<String>) -> Self {
        self.scope_id = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`PublishInput`].
    /// This method will fail if any of the following fields are not set:
    /// - [`context_key`](PublishInputBuilder::context_key)
    /// - [`title`](PublishInputBuilder::title)
    /// - [`kind`](PublishInputBuilder::kind)
    /// - [`files`](PublishInputBuilder::files)
    pub fn build(self) -> Result<PublishInput, BuildError> {
        Ok(PublishInput {
            context_key: self
                .context_key
                .ok_or_else(|| BuildError::missing_field("context_key"))?,
            title: self
                .title
                .ok_or_else(|| BuildError::missing_field("title"))?,
            summary: self.summary,
            kind: self.kind.ok_or_else(|| BuildError::missing_field("kind"))?,
            tags: self.tags,
            files: self
                .files
                .ok_or_else(|| BuildError::missing_field("files"))?,
            claimed_digest: self.claimed_digest,
            scope_id: self.scope_id,
        })
    }
}
