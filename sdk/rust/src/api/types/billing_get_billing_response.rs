pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct GetBillingResponse {
    pub plan: GetBillingResponsePlan,
    #[serde(default)]
    pub accesses: i64,
    /// Null while new usage allowances are pending approval.
    #[serde(rename = "includedAccesses")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub included_accesses: Option<i64>,
    #[serde(rename = "spendLimitCents")]
    #[serde(default)]
    pub spend_limit_cents: i64,
    #[serde(rename = "meteringActive")]
    #[serde(default)]
    pub metering_active: String,
    #[serde(rename = "canManage")]
    #[serde(default)]
    pub can_manage: bool,
    #[serde(rename = "subscriptionStatus")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub subscription_status: Option<String>,
    #[serde(rename = "monthlyPriceCents")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub monthly_price_cents: Option<i64>,
    #[serde(rename = "overageCents")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub overage_cents: Option<i64>,
    #[serde(rename = "overageCentsPerThousand")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub overage_cents_per_thousand: Option<i64>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub period: Option<String>,
    #[serde(rename = "hasCustomer")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub has_customer: Option<bool>,
}

impl GetBillingResponse {
    pub fn builder() -> GetBillingResponseBuilder {
        <GetBillingResponseBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct GetBillingResponseBuilder {
    plan: Option<GetBillingResponsePlan>,
    accesses: Option<i64>,
    included_accesses: Option<i64>,
    spend_limit_cents: Option<i64>,
    metering_active: Option<String>,
    can_manage: Option<bool>,
    subscription_status: Option<String>,
    monthly_price_cents: Option<i64>,
    overage_cents: Option<i64>,
    overage_cents_per_thousand: Option<i64>,
    period: Option<String>,
    has_customer: Option<bool>,
}

impl GetBillingResponseBuilder {
    pub fn plan(mut self, value: GetBillingResponsePlan) -> Self {
        self.plan = Some(value);
        self
    }

    pub fn accesses(mut self, value: i64) -> Self {
        self.accesses = Some(value);
        self
    }

    pub fn included_accesses(mut self, value: i64) -> Self {
        self.included_accesses = Some(value);
        self
    }

    pub fn spend_limit_cents(mut self, value: i64) -> Self {
        self.spend_limit_cents = Some(value);
        self
    }

    pub fn metering_active(mut self, value: impl Into<String>) -> Self {
        self.metering_active = Some(value.into());
        self
    }

    pub fn can_manage(mut self, value: bool) -> Self {
        self.can_manage = Some(value);
        self
    }

    pub fn subscription_status(mut self, value: impl Into<String>) -> Self {
        self.subscription_status = Some(value.into());
        self
    }

    pub fn monthly_price_cents(mut self, value: i64) -> Self {
        self.monthly_price_cents = Some(value);
        self
    }

    pub fn overage_cents(mut self, value: i64) -> Self {
        self.overage_cents = Some(value);
        self
    }

    pub fn overage_cents_per_thousand(mut self, value: i64) -> Self {
        self.overage_cents_per_thousand = Some(value);
        self
    }

    pub fn period(mut self, value: impl Into<String>) -> Self {
        self.period = Some(value.into());
        self
    }

    pub fn has_customer(mut self, value: bool) -> Self {
        self.has_customer = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`GetBillingResponse`].
    /// This method will fail if any of the following fields are not set:
    /// - [`plan`](GetBillingResponseBuilder::plan)
    /// - [`accesses`](GetBillingResponseBuilder::accesses)
    /// - [`spend_limit_cents`](GetBillingResponseBuilder::spend_limit_cents)
    /// - [`metering_active`](GetBillingResponseBuilder::metering_active)
    /// - [`can_manage`](GetBillingResponseBuilder::can_manage)
    pub fn build(self) -> Result<GetBillingResponse, BuildError> {
        Ok(GetBillingResponse {
            plan: self.plan.ok_or_else(|| BuildError::missing_field("plan"))?,
            accesses: self
                .accesses
                .ok_or_else(|| BuildError::missing_field("accesses"))?,
            included_accesses: self.included_accesses,
            spend_limit_cents: self
                .spend_limit_cents
                .ok_or_else(|| BuildError::missing_field("spend_limit_cents"))?,
            metering_active: self
                .metering_active
                .ok_or_else(|| BuildError::missing_field("metering_active"))?,
            can_manage: self
                .can_manage
                .ok_or_else(|| BuildError::missing_field("can_manage"))?,
            subscription_status: self.subscription_status,
            monthly_price_cents: self.monthly_price_cents,
            overage_cents: self.overage_cents,
            overage_cents_per_thousand: self.overage_cents_per_thousand,
            period: self.period,
            has_customer: self.has_customer,
        })
    }
}
