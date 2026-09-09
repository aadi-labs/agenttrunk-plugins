pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct SetSpendLimitBillingRequest {
    #[serde(default)]
    pub cents: i64,
}

impl SetSpendLimitBillingRequest {
    pub fn builder() -> SetSpendLimitBillingRequestBuilder {
        <SetSpendLimitBillingRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct SetSpendLimitBillingRequestBuilder {
    cents: Option<i64>,
}

impl SetSpendLimitBillingRequestBuilder {
    pub fn cents(mut self, value: i64) -> Self {
        self.cents = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`SetSpendLimitBillingRequest`].
    /// This method will fail if any of the following fields are not set:
    /// - [`cents`](SetSpendLimitBillingRequestBuilder::cents)
    pub fn build(self) -> Result<SetSpendLimitBillingRequest, BuildError> {
        Ok(SetSpendLimitBillingRequest {
            cents: self
                .cents
                .ok_or_else(|| BuildError::missing_field("cents"))?,
        })
    }
}
