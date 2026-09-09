# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      class InspectContextsRequest < Internal::Types::Model
        field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

        field :context_key, -> { String }, optional: false, nullable: false, api_name: "contextKey"

        field :ref, -> { String }, optional: true, nullable: false
      end
    end
  end
end
