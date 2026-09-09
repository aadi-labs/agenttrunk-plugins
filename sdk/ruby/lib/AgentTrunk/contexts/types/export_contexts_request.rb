# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      class ExportContextsRequest < Internal::Types::Model
        field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

        field :context_key, -> { String }, optional: false, nullable: false, api_name: "contextKey"

        field :revision_id, -> { String }, optional: false, nullable: false, api_name: "revisionId"
      end
    end
  end
end
