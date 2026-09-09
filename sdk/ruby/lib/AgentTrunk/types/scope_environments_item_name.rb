# frozen_string_literal: true

module AgentTrunk
  module Types
    module ScopeEnvironmentsItemName
      extend AgentTrunk::Internal::Types::Enum

      STAGING = "staging"
      PRODUCTION = "production"
    end
  end
end
