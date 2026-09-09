pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct ListScopesResponse {
    #[serde(default)]
    pub data: Vec<Scope>,
}

impl ListScopesResponse {
    pub fn builder() -> ListScopesResponseBuilder {
        <ListScopesResponseBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ListScopesResponseBuilder {
    data: Option<Vec<Scope>>,
}

impl ListScopesResponseBuilder {
    pub fn data(mut self, value: Vec<Scope>) -> Self {
        self.data = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`ListScopesResponse`].
    /// This method will fail if any of the following fields are not set:
    /// - [`data`](ListScopesResponseBuilder::data)
    pub fn build(self) -> Result<ListScopesResponse, BuildError> {
        Ok(ListScopesResponse {
            data: self.data.ok_or_else(|| BuildError::missing_field("data"))?,
        })
    }
}
