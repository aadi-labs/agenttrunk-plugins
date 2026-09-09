pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct Revision {
    #[serde(default)]
    pub id: String,
    #[serde(rename = "contextId")]
    #[serde(default)]
    pub context_id: String,
    #[serde(rename = "packageDigest")]
    #[serde(default)]
    pub package_digest: String,
    #[serde(rename = "parentRevisionId")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub parent_revision_id: Option<String>,
    #[serde(default)]
    pub files: Vec<FileRecord>,
    #[serde(rename = "createdAt")]
    #[serde(default)]
    #[serde(with = "crate::core::flexible_datetime::offset")]
    pub created_at: DateTime<FixedOffset>,
}

impl Revision {
    pub fn builder() -> RevisionBuilder {
        <RevisionBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct RevisionBuilder {
    id: Option<String>,
    context_id: Option<String>,
    package_digest: Option<String>,
    parent_revision_id: Option<String>,
    files: Option<Vec<FileRecord>>,
    created_at: Option<DateTime<FixedOffset>>,
}

impl RevisionBuilder {
    pub fn id(mut self, value: impl Into<String>) -> Self {
        self.id = Some(value.into());
        self
    }

    pub fn context_id(mut self, value: impl Into<String>) -> Self {
        self.context_id = Some(value.into());
        self
    }

    pub fn package_digest(mut self, value: impl Into<String>) -> Self {
        self.package_digest = Some(value.into());
        self
    }

    pub fn parent_revision_id(mut self, value: impl Into<String>) -> Self {
        self.parent_revision_id = Some(value.into());
        self
    }

    pub fn files(mut self, value: Vec<FileRecord>) -> Self {
        self.files = Some(value);
        self
    }

    pub fn created_at(mut self, value: DateTime<FixedOffset>) -> Self {
        self.created_at = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`Revision`].
    /// This method will fail if any of the following fields are not set:
    /// - [`id`](RevisionBuilder::id)
    /// - [`context_id`](RevisionBuilder::context_id)
    /// - [`package_digest`](RevisionBuilder::package_digest)
    /// - [`files`](RevisionBuilder::files)
    /// - [`created_at`](RevisionBuilder::created_at)
    pub fn build(self) -> Result<Revision, BuildError> {
        Ok(Revision {
            id: self.id.ok_or_else(|| BuildError::missing_field("id"))?,
            context_id: self
                .context_id
                .ok_or_else(|| BuildError::missing_field("context_id"))?,
            package_digest: self
                .package_digest
                .ok_or_else(|| BuildError::missing_field("package_digest"))?,
            parent_revision_id: self.parent_revision_id,
            files: self
                .files
                .ok_or_else(|| BuildError::missing_field("files"))?,
            created_at: self
                .created_at
                .ok_or_else(|| BuildError::missing_field("created_at"))?,
        })
    }
}
