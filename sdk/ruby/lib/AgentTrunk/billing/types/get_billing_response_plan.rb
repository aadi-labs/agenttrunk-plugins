# frozen_string_literal: true

module AgentTrunk
  module Billing
    module Types
      module GetBillingResponsePlan
        extend AgentTrunk::Internal::Types::Enum

        FREE = "free"
        DEVELOPER = "developer"
        STARTER = "starter"
        STARTUP = "startup"
        SCALE = "scale"
      end
    end
  end
end
