# frozen_string_literal: true

module AgentTrunk
  module Billing
    module Types
      class SetSpendLimitBillingResponse < Internal::Types::Model
        field :spend_limit_cents, -> { Integer }, optional: false, nullable: false, api_name: "spendLimitCents"
      end
    end
  end
end
