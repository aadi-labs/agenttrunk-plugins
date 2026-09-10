pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq)]
pub struct EditContextInput {
    #[serde(rename = "expectedRevisionId")]
    #[serde(default)]
    pub expected_revision_id: String,
    #[serde(default)]
    pub changes: Vec<EditContextInputChangesItem>,
}

impl EditContextInput {
    pub fn builder() -> EditContextInputBuilder {
        <EditContextInputBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct EditContextInputBuilder {
    expected_revision_id: Option<String>,
    changes: Option<Vec<EditContextInputChangesItem>>,
}

impl EditContextInputBuilder {
    pub fn expected_revision_id(mut self, value: impl Into<String>) -> Self {
        self.expected_revision_id = Some(value.into());
        self
    }

    pub fn changes(mut self, value: Vec<EditContextInputChangesItem>) -> Self {
        self.changes = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`EditContextInput`].
    /// This method will fail if any of the following fields are not set:
    /// - [`expected_revision_id`](EditContextInputBuilder::expected_revision_id)
    /// - [`changes`](EditContextInputBuilder::changes)
    pub fn build(self) -> Result<EditContextInput, BuildError> {
        Ok(EditContextInput {
            expected_revision_id: self
                .expected_revision_id
                .ok_or_else(|| BuildError::missing_field("expected_revision_id"))?,
            changes: self
                .changes
                .ok_or_else(|| BuildError::missing_field("changes"))?,
        })
    }
}
