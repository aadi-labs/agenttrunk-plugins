# frozen_string_literal: true

module AgentTrunk
  module Types
    class DiscoveryResult < Internal::Types::Model
      field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

      field :scope_id, -> { String }, optional: false, nullable: false, api_name: "scopeId"

      field :context_key, -> { String }, optional: false, nullable: false, api_name: "contextKey"

      field :title, -> { String }, optional: false, nullable: false

      field :kind, -> { AgentTrunk::Types::ContextKind }, optional: false, nullable: false

      field :summary, -> { String }, optional: false, nullable: false

      field :tags, -> { Internal::Types::Array[String] }, optional: false, nullable: false

      field :revision_id, -> { String }, optional: false, nullable: false, api_name: "revisionId"

      field :package_digest, -> { String }, optional: false, nullable: false, api_name: "packageDigest"

      field :channel, -> { AgentTrunk::Types::DiscoveryResultChannel }, optional: false, nullable: false

      field :updated_at, -> { String }, optional: false, nullable: false, api_name: "updatedAt"
    end
  end
end
