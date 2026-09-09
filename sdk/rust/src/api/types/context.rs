pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct Context {
    #[serde(default)]
    pub id: String,
    #[serde(rename = "trunkId")]
    #[serde(default)]
    pub trunk_id: String,
    #[serde(rename = "scopeId")]
    #[serde(default)]
    pub scope_id: String,
    #[serde(default)]
    pub key: String,
    #[serde(default)]
    pub title: String,
    pub kind: ContextKind,
    #[serde(default)]
    pub summary: String,
    #[serde(default)]
    pub tags: Vec<String>,
    #[serde(rename = "createdAt")]
    #[serde(default)]
    #[serde(with = "crate::core::flexible_datetime::offset")]
    pub created_at: DateTime<FixedOffset>,
    #[serde(rename = "updatedAt")]
    #[serde(default)]
    #[serde(with = "crate::core::flexible_datetime::offset")]
    pub updated_at: DateTime<FixedOffset>,
}

impl Context {
    pub fn builder() -> ContextBuilder {
        <ContextBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ContextBuilder {
    id: Option<String>,
    trunk_id: Option<String>,
    scope_id: Option<String>,
    key: Option<String>,
    title: Option<String>,
    kind: Option<ContextKind>,
    summary: Option<String>,
    tags: Option<Vec<String>>,
    created_at: Option<DateTime<FixedOffset>>,
    updated_at: Option<DateTime<FixedOffset>>,
}

impl ContextBuilder {
    pub fn id(mut self, value: impl Into<String>) -> Self {
        self.id = Some(value.into());
        self
    }

    pub fn trunk_id(mut self, value: impl Into<String>) -> Self {
        self.trunk_id = Some(value.into());
        self
    }

    pub fn scope_id(mut self, value: impl Into<String>) -> Self {
        self.scope_id = Some(value.into());
        self
    }

    pub fn key(mut self, value: impl Into<String>) -> Self {
        self.key = Some(value.into());
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

    pub fn created_at(mut self, value: DateTime<FixedOffset>) -> Self {
        self.created_at = Some(value);
        self
    }

    pub fn updated_at(mut self, value: DateTime<FixedOffset>) -> Self {
        self.updated_at = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`Context`].
    /// This method will fail if any of the following fields are not set:
    /// - [`id`](ContextBuilder::id)
    /// - [`trunk_id`](ContextBuilder::trunk_id)
    /// - [`scope_id`](ContextBuilder::scope_id)
    /// - [`key`](ContextBuilder::key)
    /// - [`title`](ContextBuilder::title)
    /// - [`kind`](ContextBuilder::kind)
    /// - [`summary`](ContextBuilder::summary)
    /// - [`tags`](ContextBuilder::tags)
    /// - [`created_at`](ContextBuilder::created_at)
    /// - [`updated_at`](ContextBuilder::updated_at)
    pub fn build(self) -> Result<Context, BuildError> {
        Ok(Context {
            id: self.id.ok_or_else(|| BuildError::missing_field("id"))?,
            trunk_id: self
                .trunk_id
                .ok_or_else(|| BuildError::missing_field("trunk_id"))?,
            scope_id: self
                .scope_id
                .ok_or_else(|| BuildError::missing_field("scope_id"))?,
            key: self.key.ok_or_else(|| BuildError::missing_field("key"))?,
            title: self
                .title
                .ok_or_else(|| BuildError::missing_field("title"))?,
            kind: self.kind.ok_or_else(|| BuildError::missing_field("kind"))?,
            summary: self
                .summary
                .ok_or_else(|| BuildError::missing_field("summary"))?,
            tags: self.tags.ok_or_else(|| BuildError::missing_field("tags"))?,
            created_at: self
                .created_at
                .ok_or_else(|| BuildError::missing_field("created_at"))?,
            updated_at: self
                .updated_at
                .ok_or_else(|| BuildError::missing_field("updated_at"))?,
        })
    }
}
