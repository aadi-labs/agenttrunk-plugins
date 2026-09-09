# frozen_string_literal: true

module AgentTrunk
  module Types
    class ContextSetSource < Internal::Types::Model
      field :source_trunk_id, -> { String }, optional: false, nullable: false, api_name: "sourceTrunkId"

      field :source_scope_id, -> { String }, optional: false, nullable: false, api_name: "sourceScopeId"

      field :environment_id, -> { String }, optional: false, nullable: false, api_name: "environmentId"

      field :context_key, -> { String }, optional: false, nullable: false, api_name: "contextKey"

      field :revision_id, -> { String }, optional: false, nullable: false, api_name: "revisionId"

      field :package_digest, -> { String }, optional: false, nullable: false, api_name: "packageDigest"

      field :mount_path, -> { String }, optional: false, nullable: false, api_name: "mountPath"

      field :required, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
