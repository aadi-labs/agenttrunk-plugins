# frozen_string_literal: true

module AgentTrunk
  module Workspaces
    module Types
      class AuditWorkspacesRequest < Internal::Types::Model
        field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

        field :limit, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
