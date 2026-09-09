pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct Trunk {
    #[serde(default)]
    pub id: String,
    #[serde(rename = "organizationId")]
    #[serde(default)]
    pub organization_id: String,
    #[serde(default)]
    pub name: String,
    #[serde(default)]
    pub slug: String,
    #[serde(rename = "createdBy")]
    #[serde(default)]
    pub created_by: String,
    #[serde(default)]
    pub branches: TrunkBranches,
    #[serde(rename = "createdAt")]
    #[serde(default)]
    #[serde(with = "crate::core::flexible_datetime::offset")]
    pub created_at: DateTime<FixedOffset>,
}

impl Trunk {
    pub fn builder() -> TrunkBuilder {
        <TrunkBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct TrunkBuilder {
    id: Option<String>,
    organization_id: Option<String>,
    name: Option<String>,
    slug: Option<String>,
    created_by: Option<String>,
    branches: Option<TrunkBranches>,
    created_at: Option<DateTime<FixedOffset>>,
}

impl TrunkBuilder {
    pub fn id(mut self, value: impl Into<String>) -> Self {
        self.id = Some(value.into());
        self
    }

    pub fn organization_id(mut self, value: impl Into<String>) -> Self {
        self.organization_id = Some(value.into());
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

    pub fn branches(mut self, value: TrunkBranches) -> Self {
        self.branches = Some(value);
        self
    }

    pub fn created_at(mut self, value: DateTime<FixedOffset>) -> Self {
        self.created_at = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`Trunk`].
    /// This method will fail if any of the following fields are not set:
    /// - [`id`](TrunkBuilder::id)
    /// - [`organization_id`](TrunkBuilder::organization_id)
    /// - [`name`](TrunkBuilder::name)
    /// - [`slug`](TrunkBuilder::slug)
    /// - [`created_by`](TrunkBuilder::created_by)
    /// - [`branches`](TrunkBuilder::branches)
    /// - [`created_at`](TrunkBuilder::created_at)
    pub fn build(self) -> Result<Trunk, BuildError> {
        Ok(Trunk {
            id: self.id.ok_or_else(|| BuildError::missing_field("id"))?,
            organization_id: self
                .organization_id
                .ok_or_else(|| BuildError::missing_field("organization_id"))?,
            name: self.name.ok_or_else(|| BuildError::missing_field("name"))?,
            slug: self.slug.ok_or_else(|| BuildError::missing_field("slug"))?,
            created_by: self
                .created_by
                .ok_or_else(|| BuildError::missing_field("created_by"))?,
            branches: self
                .branches
                .ok_or_else(|| BuildError::missing_field("branches"))?,
            created_at: self
                .created_at
                .ok_or_else(|| BuildError::missing_field("created_at"))?,
        })
    }
}
