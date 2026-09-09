# frozen_string_literal: true

module AgentTrunk
  module Types
    class Revision < Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false

      field :context_id, -> { String }, optional: false, nullable: false, api_name: "contextId"

      field :package_digest, -> { String }, optional: false, nullable: false, api_name: "packageDigest"

      field :parent_revision_id, -> { String }, optional: true, nullable: false, api_name: "parentRevisionId"

      field :files, -> { Internal::Types::Array[AgentTrunk::Types::FileRecord] }, optional: false, nullable: false

      field :created_at, -> { String }, optional: false, nullable: false, api_name: "createdAt"
    end
  end
end
