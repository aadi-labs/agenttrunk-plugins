# frozen_string_literal: true

module AgentTrunk
  module Billing
    module Types
      class SetSpendLimitBillingRequest < Internal::Types::Model
        field :cents, -> { Integer }, optional: false, nullable: false
      end
    end
  end
end
