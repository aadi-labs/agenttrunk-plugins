# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      class EditContextInput < Internal::Types::Model
        field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

        field :context_key, -> { String }, optional: false, nullable: false, api_name: "contextKey"

        field :expected_revision_id, -> { String }, optional: false, nullable: false, api_name: "expectedRevisionId"

        field :changes, -> { Internal::Types::Array[AgentTrunk::Contexts::Types::EditContextInputChangesItem] }, optional: false, nullable: false
      end
    end
  end
end
