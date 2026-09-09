# frozen_string_literal: true

module AgentTrunk
  module Workspaces
    module Types
      class ListWorkspacesRequest < Internal::Types::Model
        field :cursor, -> { String }, optional: true, nullable: false

        field :q, -> { String }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
