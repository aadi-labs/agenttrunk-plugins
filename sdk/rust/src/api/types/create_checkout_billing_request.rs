pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct CreateCheckoutBillingRequest {
    pub plan: CreateCheckoutBillingRequestPlan,
}

impl CreateCheckoutBillingRequest {
    pub fn builder() -> CreateCheckoutBillingRequestBuilder {
        <CreateCheckoutBillingRequestBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct CreateCheckoutBillingRequestBuilder {
    plan: Option<CreateCheckoutBillingRequestPlan>,
}

impl CreateCheckoutBillingRequestBuilder {
    pub fn plan(mut self, value: CreateCheckoutBillingRequestPlan) -> Self {
        self.plan = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`CreateCheckoutBillingRequest`].
    /// This method will fail if any of the following fields are not set:
    /// - [`plan`](CreateCheckoutBillingRequestBuilder::plan)
    pub fn build(self) -> Result<CreateCheckoutBillingRequest, BuildError> {
        Ok(CreateCheckoutBillingRequest {
            plan: self.plan.ok_or_else(|| BuildError::missing_field("plan"))?,
        })
    }
}
