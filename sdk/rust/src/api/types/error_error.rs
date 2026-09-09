pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct ErrorError {
    #[serde(default)]
    pub code: String,
    #[serde(default)]
    pub message: String,
    #[serde(rename = "requestId")]
    #[serde(default)]
    pub request_id: String,
}

impl ErrorError {
    pub fn builder() -> ErrorErrorBuilder {
        <ErrorErrorBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ErrorErrorBuilder {
    code: Option<String>,
    message: Option<String>,
    request_id: Option<String>,
}

impl ErrorErrorBuilder {
    pub fn code(mut self, value: impl Into<String>) -> Self {
        self.code = Some(value.into());
        self
    }

    pub fn message(mut self, value: impl Into<String>) -> Self {
        self.message = Some(value.into());
        self
    }

    pub fn request_id(mut self, value: impl Into<String>) -> Self {
        self.request_id = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`ErrorError`].
    /// This method will fail if any of the following fields are not set:
    /// - [`code`](ErrorErrorBuilder::code)
    /// - [`message`](ErrorErrorBuilder::message)
    /// - [`request_id`](ErrorErrorBuilder::request_id)
    pub fn build(self) -> Result<ErrorError, BuildError> {
        Ok(ErrorError {
            code: self.code.ok_or_else(|| BuildError::missing_field("code"))?,
            message: self
                .message
                .ok_or_else(|| BuildError::missing_field("message"))?,
            request_id: self
                .request_id
                .ok_or_else(|| BuildError::missing_field("request_id"))?,
        })
    }
}
