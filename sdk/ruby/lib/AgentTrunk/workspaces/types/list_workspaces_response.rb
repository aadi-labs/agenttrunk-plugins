# frozen_string_literal: true

module AgentTrunk
  module Workspaces
    module Types
      class ListWorkspacesResponse < Internal::Types::Model
        field :next_cursor, -> { String }, optional: true, nullable: false, api_name: "nextCursor"

        field :data, -> { Internal::Types::Array[AgentTrunk::Types::Trunk] }, optional: false, nullable: false
      end
    end
  end
end
