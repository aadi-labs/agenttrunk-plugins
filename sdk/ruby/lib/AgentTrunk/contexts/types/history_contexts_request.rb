# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      class HistoryContextsRequest < Internal::Types::Model
        field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

        field :context_key, -> { String }, optional: false, nullable: false, api_name: "contextKey"

        field :from, -> { String }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
