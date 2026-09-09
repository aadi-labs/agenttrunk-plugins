pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct CreatePrivacyRequest {
    pub kind: CreatePrivacyRequestKind,
}

impl CreatePrivacyRequest {
    pub fn builder() -> CreatePrivacyRequestBuilder {
        <CreatePrivacyRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct CreatePrivacyRequestBuilder {
    kind: Option<CreatePrivacyRequestKind>,
}

impl CreatePrivacyRequestBuilder {
    pub fn kind(mut self, value: CreatePrivacyRequestKind) -> Self {
        self.kind = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`CreatePrivacyRequest`].
    /// This method will fail if any of the following fields are not set:
    /// - [`kind`](CreatePrivacyRequestBuilder::kind)
    pub fn build(self) -> Result<CreatePrivacyRequest, BuildError> {
        Ok(CreatePrivacyRequest {
            kind: self.kind.ok_or_else(|| BuildError::missing_field("kind"))?,
        })
    }
}
