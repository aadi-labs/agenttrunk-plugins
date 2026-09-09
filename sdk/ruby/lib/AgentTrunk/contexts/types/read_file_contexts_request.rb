# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      class ReadFileContextsRequest < Internal::Types::Model
        field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

        field :context_key, -> { String }, optional: false, nullable: false, api_name: "contextKey"

        field :resource_path, -> { String }, optional: false, nullable: false, api_name: "resourcePath"

        field :ref, -> { String }, optional: false, nullable: false
      end
    end
  end
end
