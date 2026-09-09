pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct FileInput {
    #[serde(default)]
    pub path: String,
    #[serde(rename = "contentBase64")]
    #[serde(default)]
    pub content_base64: String,
}

impl FileInput {
    pub fn builder() -> FileInputBuilder {
        <FileInputBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct FileInputBuilder {
    path: Option<String>,
    content_base64: Option<String>,
}

impl FileInputBuilder {
    pub fn path(mut self, value: impl Into<String>) -> Self {
        self.path = Some(value.into());
        self
    }

    pub fn content_base64(mut self, value: impl Into<String>) -> Self {
        self.content_base64 = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`FileInput`].
    /// This method will fail if any of the following fields are not set:
    /// - [`path`](FileInputBuilder::path)
    /// - [`content_base64`](FileInputBuilder::content_base64)
    pub fn build(self) -> Result<FileInput, BuildError> {
        Ok(FileInput {
            path: self.path.ok_or_else(|| BuildError::missing_field("path"))?,
            content_base64: self
                .content_base64
                .ok_or_else(|| BuildError::missing_field("content_base64"))?,
        })
    }
}
