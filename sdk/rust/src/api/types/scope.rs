pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct Scope {
    #[serde(rename = "canCreateScope")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub can_create_scope: Option<bool>,
    #[serde(default)]
    pub id: String,
    #[serde(default)]
    pub name: String,
    #[serde(default)]
    pub slug: String,
    #[serde(rename = "createdBy")]
    #[serde(default)]
    pub created_by: String,
    #[serde(rename = "createdAt")]
    #[serde(default)]
    #[serde(with = "crate::core::flexible_datetime::offset")]
    pub created_at: DateTime<FixedOffset>,
    #[serde(default)]
    pub environments: Vec<ScopeEnvironmentsItem>,
}

impl Scope {
    pub fn builder() -> ScopeBuilder {
        <ScopeBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ScopeBuilder {
    can_create_scope: Option<bool>,
    id: Option<String>,
    name: Option<String>,
    slug: Option<String>,
    created_by: Option<String>,
    created_at: Option<DateTime<FixedOffset>>,
    environments: Option<Vec<ScopeEnvironmentsItem>>,
}

impl ScopeBuilder {
    pub fn can_create_scope(mut self, value: bool) -> Self {
        self.can_create_scope = Some(value);
        self
    }

    pub fn id(mut self, value: impl Into<String>) -> Self {
        self.id = Some(value.into());
        self
    }

    pub fn name(mut self, value: impl Into<String>) -> Self {
        self.name = Some(value.into());
        self
    }

    pub fn slug(mut self, value: impl Into<String>) -> Self {
        self.slug = Some(value.into());
        self
    }

    pub fn created_by(mut self, value: impl Into<String>) -> Self {
        self.created_by = Some(value.into());
        self
    }

    pub fn created_at(mut self, value: DateTime<FixedOffset>) -> Self {
        self.created_at = Some(value);
        self
    }

    pub fn environments(mut self, value: Vec<ScopeEnvironmentsItem>) -> Self {
        self.environments = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`Scope`].
    /// This method will fail if any of the following fields are not set:
    /// - [`id`](ScopeBuilder::id)
    /// - [`name`](ScopeBuilder::name)
    /// - [`slug`](ScopeBuilder::slug)
    /// - [`created_by`](ScopeBuilder::created_by)
    /// - [`created_at`](ScopeBuilder::created_at)
    /// - [`environments`](ScopeBuilder::environments)
    pub fn build(self) -> Result<Scope, BuildError> {
        Ok(Scope {
            can_create_scope: self.can_create_scope,
            id: self.id.ok_or_else(|| BuildError::missing_field("id"))?,
            name: self.name.ok_or_else(|| BuildError::missing_field("name"))?,
            slug: self.slug.ok_or_else(|| BuildError::missing_field("slug"))?,
            created_by: self
                .created_by
                .ok_or_else(|| BuildError::missing_field("created_by"))?,
            created_at: self
                .created_at
                .ok_or_else(|| BuildError::missing_field("created_at"))?,
            environments: self
                .environments
                .ok_or_else(|| BuildError::missing_field("environments"))?,
        })
    }
}
