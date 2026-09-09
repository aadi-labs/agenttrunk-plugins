pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct InspectContextsResponse {
    pub context: Context,
    #[serde(default)]
    pub revision: Revision,
}

impl InspectContextsResponse {
    pub fn builder() -> InspectContextsResponseBuilder {
        <InspectContextsResponseBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct InspectContextsResponseBuilder {
    context: Option<Context>,
    revision: Option<Revision>,
}

impl InspectContextsResponseBuilder {
    pub fn context(mut self, value: Context) -> Self {
        self.context = Some(value);
        self
    }

    pub fn revision(mut self, value: Revision) -> Self {
        self.revision = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`InspectContextsResponse`].
    /// This method will fail if any of the following fields are not set:
    /// - [`context`](InspectContextsResponseBuilder::context)
    /// - [`revision`](InspectContextsResponseBuilder::revision)
    pub fn build(self) -> Result<InspectContextsResponse, BuildError> {
        Ok(InspectContextsResponse {
            context: self
                .context
                .ok_or_else(|| BuildError::missing_field("context"))?,
            revision: self
                .revision
                .ok_or_else(|| BuildError::missing_field("revision"))?,
        })
    }
}
