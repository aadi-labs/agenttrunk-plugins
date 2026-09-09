# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      class DiscoverContextsRequest < Internal::Types::Model
        field :scope_id, -> { String }, optional: true, nullable: false, api_name: "scopeId"

        field :cursor, -> { String }, optional: true, nullable: false

        field :trunk_id, -> { String }, optional: true, nullable: false, api_name: "trunkId"

        field :query, -> { String }, optional: true, nullable: false

        field :channel, -> { AgentTrunk::Contexts::Types::DiscoverContextsRequestChannel }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
