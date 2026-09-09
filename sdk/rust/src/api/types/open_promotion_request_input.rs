pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct OpenPromotionRequestInput {
    #[serde(rename = "evidenceReference")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub evidence_reference: Option<String>,
    /// Defaults to the trunk General scope.
    #[serde(rename = "scopeId")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub scope_id: Option<String>,
}

impl OpenPromotionRequestInput {
    pub fn builder() -> OpenPromotionRequestInputBuilder {
        <OpenPromotionRequestInputBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct OpenPromotionRequestInputBuilder {
    evidence_reference: Option<String>,
    scope_id: Option<String>,
}

impl OpenPromotionRequestInputBuilder {
    pub fn evidence_reference(mut self, value: impl Into<String>) -> Self {
        self.evidence_reference = Some(value.into());
        self
    }

    pub fn scope_id(mut self, value: impl Into<String>) -> Self {
        self.scope_id = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`OpenPromotionRequestInput`].
    pub fn build(self) -> Result<OpenPromotionRequestInput, BuildError> {
        Ok(OpenPromotionRequestInput {
            evidence_reference: self.evidence_reference,
            scope_id: self.scope_id,
        })
    }
}
