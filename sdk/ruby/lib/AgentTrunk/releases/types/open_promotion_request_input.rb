# frozen_string_literal: true

module AgentTrunk
  module Releases
    module Types
      class OpenPromotionRequestInput < Internal::Types::Model
        field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

        field :evidence_reference, -> { String }, optional: true, nullable: false, api_name: "evidenceReference"

        field :scope_id, -> { String }, optional: true, nullable: false, api_name: "scopeId"
      end
    end
  end
end
