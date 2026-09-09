pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct CreateContextSetsRequest {
    #[serde(default)]
    pub name: String,
    #[serde(default)]
    pub sources: Vec<ContextSetSource>,
}

impl CreateContextSetsRequest {
    pub fn builder() -> CreateContextSetsRequestBuilder {
        <CreateContextSetsRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct CreateContextSetsRequestBuilder {
    name: Option<String>,
    sources: Option<Vec<ContextSetSource>>,
}

impl CreateContextSetsRequestBuilder {
    pub fn name(mut self, value: impl Into<String>) -> Self {
        self.name = Some(value.into());
        self
    }

    pub fn sources(mut self, value: Vec<ContextSetSource>) -> Self {
        self.sources = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`CreateContextSetsRequest`].
    /// This method will fail if any of the following fields are not set:
    /// - [`name`](CreateContextSetsRequestBuilder::name)
    /// - [`sources`](CreateContextSetsRequestBuilder::sources)
    pub fn build(self) -> Result<CreateContextSetsRequest, BuildError> {
        Ok(CreateContextSetsRequest {
            name: self.name.ok_or_else(|| BuildError::missing_field("name"))?,
            sources: self
                .sources
                .ok_or_else(|| BuildError::missing_field("sources"))?,
        })
    }
}
