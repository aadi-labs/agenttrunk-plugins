# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      class DiscoverContextsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[AgentTrunk::Types::DiscoveryResult] }, optional: false, nullable: false

        field :next_cursor, -> { String }, optional: true, nullable: false, api_name: "nextCursor"
      end
    end
  end
end
