pub use crate::prelude::*;

/// Query parameters for compare
#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct CompareQueryRequest {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub base: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub target: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub path: Option<String>,
}

impl CompareQueryRequest {
    pub fn builder() -> CompareQueryRequestBuilder {
        <CompareQueryRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct CompareQueryRequestBuilder {
    base: Option<String>,
    target: Option<String>,
    path: Option<String>,
}

impl CompareQueryRequestBuilder {
    pub fn base(mut self, value: impl Into<String>) -> Self {
        self.base = Some(value.into());
        self
    }

    pub fn target(mut self, value: impl Into<String>) -> Self {
        self.target = Some(value.into());
        self
    }

    pub fn path(mut self, value: impl Into<String>) -> Self {
        self.path = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`CompareQueryRequest`].
    pub fn build(self) -> Result<CompareQueryRequest, BuildError> {
        Ok(CompareQueryRequest {
            base: self.base,
            target: self.target,
            path: self.path,
        })
    }
}
