# frozen_string_literal: true

module AgentTrunk
  module Types
    class PromotionRequestChangesItem < Internal::Types::Model
      field :context_id, -> { String }, optional: false, nullable: false, api_name: "contextId"

      field :context_key, -> { String }, optional: false, nullable: false, api_name: "contextKey"

      field :source_revision_id, -> { String }, optional: false, nullable: false, api_name: "sourceRevisionId"

      field :target_revision_id, -> { String }, optional: false, nullable: true, api_name: "targetRevisionId"
    end
  end
end
