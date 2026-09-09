pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct Error {
    #[serde(default)]
    pub error: ErrorError,
}

impl Error {
    pub fn builder() -> ErrorBuilder {
        <ErrorBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ErrorBuilder {
    error: Option<ErrorError>,
}

impl ErrorBuilder {
    pub fn error(mut self, value: ErrorError) -> Self {
        self.error = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`Error`].
    /// This method will fail if any of the following fields are not set:
    /// - [`error`](ErrorBuilder::error)
    pub fn build(self) -> Result<Error, BuildError> {
        Ok(Error {
            error: self
                .error
                .ok_or_else(|| BuildError::missing_field("error"))?,
        })
    }
}
