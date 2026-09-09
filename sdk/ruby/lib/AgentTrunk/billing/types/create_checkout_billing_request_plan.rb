# frozen_string_literal: true

module AgentTrunk
  module Billing
    module Types
      module CreateCheckoutBillingRequestPlan
        extend AgentTrunk::Internal::Types::Enum

        STARTER = "starter"
        STARTUP = "startup"
        SCALE = "scale"
      end
    end
  end
end
