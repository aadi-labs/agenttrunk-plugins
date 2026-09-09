pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct PromotionRequest {
    #[serde(default)]
    pub id: String,
    #[serde(rename = "trunkId")]
    #[serde(default)]
    pub trunk_id: String,
    #[serde(rename = "scopeId")]
    #[serde(default)]
    pub scope_id: String,
    #[serde(rename = "sourceCommitSha")]
    #[serde(default)]
    pub source_commit_sha: String,
    #[serde(rename = "targetCommitSha")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub target_commit_sha: Option<String>,
    #[serde(default)]
    pub changes: Vec<PromotionRequestChangesItem>,
    pub status: PromotionRequestStatus,
    #[serde(rename = "evidenceReference")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub evidence_reference: Option<String>,
    #[serde(rename = "createdBy")]
    #[serde(default)]
    pub created_by: String,
    #[serde(rename = "delegatedActorId")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub delegated_actor_id: Option<String>,
    #[serde(rename = "createdAt")]
    #[serde(default)]
    #[serde(with = "crate::core::flexible_datetime::offset")]
    pub created_at: DateTime<FixedOffset>,
    #[serde(rename = "mergedBy")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub merged_by: Option<String>,
    #[serde(rename = "mergedDelegatedActorId")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub merged_delegated_actor_id: Option<String>,
    #[serde(rename = "mergedAt")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub merged_at: Option<DateTime<FixedOffset>>,
}

impl PromotionRequest {
    pub fn builder() -> PromotionRequestBuilder {
        <PromotionRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct PromotionRequestBuilder {
    id: Option<String>,
    trunk_id: Option<String>,
    scope_id: Option<String>,
    source_commit_sha: Option<String>,
    target_commit_sha: Option<String>,
    changes: Option<Vec<PromotionRequestChangesItem>>,
    status: Option<PromotionRequestStatus>,
    evidence_reference: Option<String>,
    created_by: Option<String>,
    delegated_actor_id: Option<String>,
    created_at: Option<DateTime<FixedOffset>>,
    merged_by: Option<String>,
    merged_delegated_actor_id: Option<String>,
    merged_at: Option<DateTime<FixedOffset>>,
}

impl PromotionRequestBuilder {
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

    pub fn source_commit_sha(mut self, value: impl Into<String>) -> Self {
        self.source_commit_sha = Some(value.into());
        self
    }

    pub fn target_commit_sha(mut self, value: impl Into<String>) -> Self {
        self.target_commit_sha = Some(value.into());
        self
    }

    pub fn changes(mut self, value: Vec<PromotionRequestChangesItem>) -> Self {
        self.changes = Some(value);
        self
    }

    pub fn status(mut self, value: PromotionRequestStatus) -> Self {
        self.status = Some(value);
        self
    }

    pub fn evidence_reference(mut self, value: impl Into<String>) -> Self {
        self.evidence_reference = Some(value.into());
        self
    }

    pub fn created_by(mut self, value: impl Into<String>) -> Self {
        self.created_by = Some(value.into());
        self
    }

    pub fn delegated_actor_id(mut self, value: impl Into<String>) -> Self {
        self.delegated_actor_id = Some(value.into());
        self
    }

    pub fn created_at(mut self, value: DateTime<FixedOffset>) -> Self {
        self.created_at = Some(value);
        self
    }

    pub fn merged_by(mut self, value: impl Into<String>) -> Self {
        self.merged_by = Some(value.into());
        self
    }

    pub fn merged_delegated_actor_id(mut self, value: impl Into<String>) -> Self {
        self.merged_delegated_actor_id = Some(value.into());
        self
    }

    pub fn merged_at(mut self, value: DateTime<FixedOffset>) -> Self {
        self.merged_at = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`PromotionRequest`].
    /// This method will fail if any of the following fields are not set:
    /// - [`id`](PromotionRequestBuilder::id)
    /// - [`trunk_id`](PromotionRequestBuilder::trunk_id)
    /// - [`scope_id`](PromotionRequestBuilder::scope_id)
    /// - [`source_commit_sha`](PromotionRequestBuilder::source_commit_sha)
    /// - [`changes`](PromotionRequestBuilder::changes)
    /// - [`status`](PromotionRequestBuilder::status)
    /// - [`created_by`](PromotionRequestBuilder::created_by)
    /// - [`created_at`](PromotionRequestBuilder::created_at)
    pub fn build(self) -> Result<PromotionRequest, BuildError> {
        Ok(PromotionRequest {
            id: self.id.ok_or_else(|| BuildError::missing_field("id"))?,
            trunk_id: self
                .trunk_id
                .ok_or_else(|| BuildError::missing_field("trunk_id"))?,
            scope_id: self
                .scope_id
                .ok_or_else(|| BuildError::missing_field("scope_id"))?,
            source_commit_sha: self
                .source_commit_sha
                .ok_or_else(|| BuildError::missing_field("source_commit_sha"))?,
            target_commit_sha: self.target_commit_sha,
            changes: self
                .changes
                .ok_or_else(|| BuildError::missing_field("changes"))?,
            status: self
                .status
                .ok_or_else(|| BuildError::missing_field("status"))?,
            evidence_reference: self.evidence_reference,
            created_by: self
                .created_by
                .ok_or_else(|| BuildError::missing_field("created_by"))?,
            delegated_actor_id: self.delegated_actor_id,
            created_at: self
                .created_at
                .ok_or_else(|| BuildError::missing_field("created_at"))?,
            merged_by: self.merged_by,
            merged_delegated_actor_id: self.merged_delegated_actor_id,
            merged_at: self.merged_at,
        })
    }
}
