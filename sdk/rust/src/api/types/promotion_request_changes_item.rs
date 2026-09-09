pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct PromotionRequestChangesItem {
    #[serde(rename = "contextId")]
    #[serde(default)]
    pub context_id: String,
    #[serde(rename = "contextKey")]
    #[serde(default)]
    pub context_key: String,
    #[serde(rename = "sourceRevisionId")]
    #[serde(default)]
    pub source_revision_id: String,
    #[serde(rename = "targetRevisionId")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub target_revision_id: Option<String>,
}

impl PromotionRequestChangesItem {
    pub fn builder() -> PromotionRequestChangesItemBuilder {
        <PromotionRequestChangesItemBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct PromotionRequestChangesItemBuilder {
    context_id: Option<String>,
    context_key: Option<String>,
    source_revision_id: Option<String>,
    target_revision_id: Option<String>,
}

impl PromotionRequestChangesItemBuilder {
    pub fn context_id(mut self, value: impl Into<String>) -> Self {
        self.context_id = Some(value.into());
        self
    }

    pub fn context_key(mut self, value: impl Into<String>) -> Self {
        self.context_key = Some(value.into());
        self
    }

    pub fn source_revision_id(mut self, value: impl Into<String>) -> Self {
        self.source_revision_id = Some(value.into());
        self
    }

    pub fn target_revision_id(mut self, value: impl Into<String>) -> Self {
        self.target_revision_id = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`PromotionRequestChangesItem`].
    /// This method will fail if any of the following fields are not set:
    /// - [`context_id`](PromotionRequestChangesItemBuilder::context_id)
    /// - [`context_key`](PromotionRequestChangesItemBuilder::context_key)
    /// - [`source_revision_id`](PromotionRequestChangesItemBuilder::source_revision_id)
    pub fn build(self) -> Result<PromotionRequestChangesItem, BuildError> {
        Ok(PromotionRequestChangesItem {
            context_id: self
                .context_id
                .ok_or_else(|| BuildError::missing_field("context_id"))?,
            context_key: self
                .context_key
                .ok_or_else(|| BuildError::missing_field("context_key"))?,
            source_revision_id: self
                .source_revision_id
                .ok_or_else(|| BuildError::missing_field("source_revision_id"))?,
            target_revision_id: self.target_revision_id,
        })
    }
}
