pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct FileRecord {
    #[serde(default)]
    pub path: String,
    #[serde(default)]
    pub size: i64,
    #[serde(default)]
    pub sha256: String,
}

impl FileRecord {
    pub fn builder() -> FileRecordBuilder {
        <FileRecordBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct FileRecordBuilder {
    path: Option<String>,
    size: Option<i64>,
    sha256: Option<String>,
}

impl FileRecordBuilder {
    pub fn path(mut self, value: impl Into<String>) -> Self {
        self.path = Some(value.into());
        self
    }

    pub fn size(mut self, value: i64) -> Self {
        self.size = Some(value);
        self
    }

    pub fn sha256(mut self, value: impl Into<String>) -> Self {
        self.sha256 = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`FileRecord`].
    /// This method will fail if any of the following fields are not set:
    /// - [`path`](FileRecordBuilder::path)
    /// - [`size`](FileRecordBuilder::size)
    /// - [`sha256`](FileRecordBuilder::sha256)
    pub fn build(self) -> Result<FileRecord, BuildError> {
        Ok(FileRecord {
            path: self.path.ok_or_else(|| BuildError::missing_field("path"))?,
            size: self.size.ok_or_else(|| BuildError::missing_field("size"))?,
            sha256: self
                .sha256
                .ok_or_else(|| BuildError::missing_field("sha256"))?,
        })
    }
}
