pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct PutProvenanceContextsRequest {
    #[serde(rename = "revisionId")]
    #[serde(default)]
    pub revision_id: String,
    /// Maximum 16000 UTF-8 bytes; not 16000 arbitrary Unicode characters.
    #[serde(default)]
    pub text: String,
    /// Null for the first note; otherwise the notesCommitSha returned by GET.
    // Required nullable field: None must serialize as JSON null.
    #[serde(rename = "expectedNotesCommitSha")]
    pub expected_notes_commit_sha: Option<String>,
}

impl PutProvenanceContextsRequest {
    pub fn builder() -> PutProvenanceContextsRequestBuilder {
        <PutProvenanceContextsRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct PutProvenanceContextsRequestBuilder {
    revision_id: Option<String>,
    text: Option<String>,
    expected_notes_commit_sha: Option<String>,
}

impl PutProvenanceContextsRequestBuilder {
    pub fn revision_id(mut self, value: impl Into<String>) -> Self {
        self.revision_id = Some(value.into());
        self
    }

    pub fn text(mut self, value: impl Into<String>) -> Self {
        self.text = Some(value.into());
        self
    }

    pub fn expected_notes_commit_sha(mut self, value: impl Into<String>) -> Self {
        self.expected_notes_commit_sha = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`PutProvenanceContextsRequest`].
    /// This method will fail if any of the following fields are not set:
    /// - [`revision_id`](PutProvenanceContextsRequestBuilder::revision_id)
    /// - [`text`](PutProvenanceContextsRequestBuilder::text)
    pub fn build(self) -> Result<PutProvenanceContextsRequest, BuildError> {
        Ok(PutProvenanceContextsRequest {
            revision_id: self
                .revision_id
                .ok_or_else(|| BuildError::missing_field("revision_id"))?,
            text: self.text.ok_or_else(|| BuildError::missing_field("text"))?,
            expected_notes_commit_sha: self.expected_notes_commit_sha,
        })
    }
}
