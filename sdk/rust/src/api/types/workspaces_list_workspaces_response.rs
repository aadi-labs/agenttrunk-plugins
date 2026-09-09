pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct ListWorkspacesResponse {
    #[serde(rename = "nextCursor")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub next_cursor: Option<String>,
    #[serde(default)]
    pub data: Vec<Trunk>,
}

impl ListWorkspacesResponse {
    pub fn builder() -> ListWorkspacesResponseBuilder {
        <ListWorkspacesResponseBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ListWorkspacesResponseBuilder {
    next_cursor: Option<String>,
    data: Option<Vec<Trunk>>,
}

impl ListWorkspacesResponseBuilder {
    pub fn next_cursor(mut self, value: impl Into<String>) -> Self {
        self.next_cursor = Some(value.into());
        self
    }

    pub fn data(mut self, value: Vec<Trunk>) -> Self {
        self.data = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`ListWorkspacesResponse`].
    /// This method will fail if any of the following fields are not set:
    /// - [`data`](ListWorkspacesResponseBuilder::data)
    pub fn build(self) -> Result<ListWorkspacesResponse, BuildError> {
        Ok(ListWorkspacesResponse {
            next_cursor: self.next_cursor,
            data: self.data.ok_or_else(|| BuildError::missing_field("data"))?,
        })
    }
}
