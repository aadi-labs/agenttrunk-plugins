# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      class HistoryContextsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[AgentTrunk::Types::Revision] }, optional: false, nullable: false

        field :next_, -> { String }, optional: true, nullable: false, api_name: "next"
      end
    end
  end
end
