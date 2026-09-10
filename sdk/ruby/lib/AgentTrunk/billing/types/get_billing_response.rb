# frozen_string_literal: true

module AgentTrunk
  module Billing
    module Types
      class GetBillingResponse < Internal::Types::Model
        field :plan, -> { AgentTrunk::Billing::Types::GetBillingResponsePlan }, optional: false, nullable: false

        field :accesses, -> { Integer }, optional: false, nullable: false

        field :included_accesses, -> { Integer }, optional: false, nullable: true, api_name: "includedAccesses"

        field :included_storage_bytes, -> { Integer }, optional: true, nullable: false, api_name: "includedStorageBytes"

        field :spend_limit_cents, -> { Integer }, optional: false, nullable: false, api_name: "spendLimitCents"

        field :metering_active, -> { Internal::Types::Boolean }, optional: false, nullable: false, api_name: "meteringActive"

        field :can_manage, -> { Internal::Types::Boolean }, optional: false, nullable: false, api_name: "canManage"

        field :subscription_status, -> { String }, optional: true, nullable: false, api_name: "subscriptionStatus"

        field :monthly_price_cents, -> { Integer }, optional: true, nullable: false, api_name: "monthlyPriceCents"

        field :overage_cents, -> { Integer }, optional: true, nullable: false, api_name: "overageCents"

        field :overage_cents_per_thousand, -> { Integer }, optional: true, nullable: false, api_name: "overageCentsPerThousand"

        field :period, -> { String }, optional: true, nullable: false

        field :has_customer, -> { Internal::Types::Boolean }, optional: true, nullable: false, api_name: "hasCustomer"
      end
    end
  end
end
