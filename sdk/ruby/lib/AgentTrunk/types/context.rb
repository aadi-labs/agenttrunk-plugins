# frozen_string_literal: true

module AgentTrunk
  module Types
    class Context < Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false

      field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

      field :scope_id, -> { String }, optional: false, nullable: false, api_name: "scopeId"

      field :key, -> { String }, optional: false, nullable: false

      field :title, -> { String }, optional: false, nullable: false

      field :kind, -> { AgentTrunk::Types::ContextKind }, optional: false, nullable: false

      field :summary, -> { String }, optional: false, nullable: false

      field :tags, -> { Internal::Types::Array[String] }, optional: false, nullable: false

      field :created_at, -> { String }, optional: false, nullable: false, api_name: "createdAt"

      field :updated_at, -> { String }, optional: false, nullable: false, api_name: "updatedAt"
    end
  end
end
