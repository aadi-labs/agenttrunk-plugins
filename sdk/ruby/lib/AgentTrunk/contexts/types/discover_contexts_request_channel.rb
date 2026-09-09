# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      module DiscoverContextsRequestChannel
        extend AgentTrunk::Internal::Types::Enum

        PRODUCTION = "production"
        STAGING = "staging"
        LATEST = "latest"
      end
    end
  end
end
