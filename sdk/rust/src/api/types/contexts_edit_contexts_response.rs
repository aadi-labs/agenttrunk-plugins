pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct EditContextsResponse {
    pub context: Context,
    #[serde(default)]
    pub revision: Revision,
}

impl EditContextsResponse {
    pub fn builder() -> EditContextsResponseBuilder {
        <EditContextsResponseBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct EditContextsResponseBuilder {
    context: Option<Context>,
    revision: Option<Revision>,
}

impl EditContextsResponseBuilder {
    pub fn context(mut self, value: Context) -> Self {
        self.context = Some(value);
        self
    }

    pub fn revision(mut self, value: Revision) -> Self {
        self.revision = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`EditContextsResponse`].
    /// This method will fail if any of the following fields are not set:
    /// - [`context`](EditContextsResponseBuilder::context)
    /// - [`revision`](EditContextsResponseBuilder::revision)
    pub fn build(self) -> Result<EditContextsResponse, BuildError> {
        Ok(EditContextsResponse {
            context: self
                .context
                .ok_or_else(|| BuildError::missing_field("context"))?,
            revision: self
                .revision
                .ok_or_else(|| BuildError::missing_field("revision"))?,
        })
    }
}
