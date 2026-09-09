pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct CreateScopesRequest {
    #[serde(default)]
    pub name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub slug: Option<String>,
}

impl CreateScopesRequest {
    pub fn builder() -> CreateScopesRequestBuilder {
        <CreateScopesRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct CreateScopesRequestBuilder {
    name: Option<String>,
    slug: Option<String>,
}

impl CreateScopesRequestBuilder {
    pub fn name(mut self, value: impl Into<String>) -> Self {
        self.name = Some(value.into());
        self
    }

    pub fn slug(mut self, value: impl Into<String>) -> Self {
        self.slug = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`CreateScopesRequest`].
    /// This method will fail if any of the following fields are not set:
    /// - [`name`](CreateScopesRequestBuilder::name)
    pub fn build(self) -> Result<CreateScopesRequest, BuildError> {
        Ok(CreateScopesRequest {
            name: self.name.ok_or_else(|| BuildError::missing_field("name"))?,
            slug: self.slug,
        })
    }
}
