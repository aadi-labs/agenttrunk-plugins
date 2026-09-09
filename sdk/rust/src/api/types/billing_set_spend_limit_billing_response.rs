pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct SetSpendLimitBillingResponse {
    #[serde(rename = "spendLimitCents")]
    #[serde(default)]
    pub spend_limit_cents: i64,
}

impl SetSpendLimitBillingResponse {
    pub fn builder() -> SetSpendLimitBillingResponseBuilder {
        <SetSpendLimitBillingResponseBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct SetSpendLimitBillingResponseBuilder {
    spend_limit_cents: Option<i64>,
}

impl SetSpendLimitBillingResponseBuilder {
    pub fn spend_limit_cents(mut self, value: i64) -> Self {
        self.spend_limit_cents = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`SetSpendLimitBillingResponse`].
    /// This method will fail if any of the following fields are not set:
    /// - [`spend_limit_cents`](SetSpendLimitBillingResponseBuilder::spend_limit_cents)
    pub fn build(self) -> Result<SetSpendLimitBillingResponse, BuildError> {
        Ok(SetSpendLimitBillingResponse {
            spend_limit_cents: self
                .spend_limit_cents
                .ok_or_else(|| BuildError::missing_field("spend_limit_cents"))?,
        })
    }
}
