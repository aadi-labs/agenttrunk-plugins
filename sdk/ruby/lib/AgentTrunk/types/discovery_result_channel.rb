# frozen_string_literal: true

module AgentTrunk
  module Types
    module DiscoveryResultChannel
      extend AgentTrunk::Internal::Types::Enum

      PRODUCTION = "production"
      STAGING = "staging"
      LATEST = "latest"
    end
  end
end
