pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct HistoryContextsResponse {
    #[serde(default)]
    pub data: Vec<Revision>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub next: Option<String>,
}

impl HistoryContextsResponse {
    pub fn builder() -> HistoryContextsResponseBuilder {
        <HistoryContextsResponseBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct HistoryContextsResponseBuilder {
    data: Option<Vec<Revision>>,
    next: Option<String>,
}

impl HistoryContextsResponseBuilder {
    pub fn data(mut self, value: Vec<Revision>) -> Self {
        self.data = Some(value);
        self
    }

    pub fn next(mut self, value: impl Into<String>) -> Self {
        self.next = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`HistoryContextsResponse`].
    /// This method will fail if any of the following fields are not set:
    /// - [`data`](HistoryContextsResponseBuilder::data)
    pub fn build(self) -> Result<HistoryContextsResponse, BuildError> {
        Ok(HistoryContextsResponse {
            data: self.data.ok_or_else(|| BuildError::missing_field("data"))?,
            next: self.next,
        })
    }
}
