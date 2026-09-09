# frozen_string_literal: true

module AgentTrunk
  module Types
    class Scope < Internal::Types::Model
      field :can_create_scope, -> { Internal::Types::Boolean }, optional: true, nullable: false, api_name: "canCreateScope"

      field :id, -> { String }, optional: false, nullable: false

      field :name, -> { String }, optional: false, nullable: false

      field :slug, -> { String }, optional: false, nullable: false

      field :created_by, -> { String }, optional: false, nullable: false, api_name: "createdBy"

      field :created_at, -> { String }, optional: false, nullable: false, api_name: "createdAt"

      field :environments, -> { Internal::Types::Array[AgentTrunk::Types::ScopeEnvironmentsItem] }, optional: false, nullable: false
    end
  end
end
