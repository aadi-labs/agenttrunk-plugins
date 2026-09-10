# frozen_string_literal: true

module AgentTrunk
  module Workspaces
    module Types
      # Copy one authorized immutable context revision into the new workspace's staging environment. Copies verified
      # files and current display metadata, not history, notes, permissions or production releases. The workspace name
      # is reserved for this exact baseline; retry with identical inputs after a partial failure. Destination storage
      # allowances apply. This is a snapshot copy, not a full Git repository fork.
      class CreateTrunkInputBaseline < Internal::Types::Model
        field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

        field :context_key, -> { String }, optional: false, nullable: false, api_name: "contextKey"

        field :revision_id, -> { String }, optional: false, nullable: false, api_name: "revisionId"
      end
    end
  end
end
