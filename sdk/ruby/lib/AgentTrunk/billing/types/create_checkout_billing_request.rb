# frozen_string_literal: true

module AgentTrunk
  module Billing
    module Types
      class CreateCheckoutBillingRequest < Internal::Types::Model
        field :plan, -> { AgentTrunk::Billing::Types::CreateCheckoutBillingRequestPlan }, optional: false, nullable: false
      end
    end
  end
end
