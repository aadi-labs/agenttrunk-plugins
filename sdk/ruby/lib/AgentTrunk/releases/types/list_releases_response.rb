# frozen_string_literal: true

module AgentTrunk
  module Releases
    module Types
      class ListReleasesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[AgentTrunk::Types::PromotionRequest] }, optional: false, nullable: false

        field :next_cursor, -> { String }, optional: true, nullable: false, api_name: "nextCursor"
      end
    end
  end
end
