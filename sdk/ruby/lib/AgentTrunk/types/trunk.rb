# frozen_string_literal: true

module AgentTrunk
  module Types
    class Trunk < Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false

      field :organization_id, -> { String }, optional: false, nullable: false, api_name: "organizationId"

      field :name, -> { String }, optional: false, nullable: false

      field :slug, -> { String }, optional: false, nullable: false

      field :created_by, -> { String }, optional: false, nullable: false, api_name: "createdBy"

      field :branches, -> { AgentTrunk::Types::TrunkBranches }, optional: false, nullable: false

      field :created_at, -> { String }, optional: false, nullable: false, api_name: "createdAt"
    end
  end
end
