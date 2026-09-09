# frozen_string_literal: true

module AgentTrunk
  module Scopes
    module Types
      class CreateScopesRequest < Internal::Types::Model
        field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

        field :name, -> { String }, optional: false, nullable: false

        field :slug, -> { String }, optional: true, nullable: false
      end
    end
  end
end
