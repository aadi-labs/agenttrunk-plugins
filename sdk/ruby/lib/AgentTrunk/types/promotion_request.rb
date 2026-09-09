# frozen_string_literal: true

module AgentTrunk
  module Types
    class PromotionRequest < Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false

      field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

      field :scope_id, -> { String }, optional: false, nullable: false, api_name: "scopeId"

      field :source_commit_sha, -> { String }, optional: false, nullable: false, api_name: "sourceCommitSha"

      field :target_commit_sha, -> { String }, optional: false, nullable: true, api_name: "targetCommitSha"

      field :changes, -> { Internal::Types::Array[AgentTrunk::Types::PromotionRequestChangesItem] }, optional: false, nullable: false

      field :status, -> { AgentTrunk::Types::PromotionRequestStatus }, optional: false, nullable: false

      field :evidence_reference, -> { String }, optional: true, nullable: false, api_name: "evidenceReference"

      field :created_by, -> { String }, optional: false, nullable: false, api_name: "createdBy"

      field :delegated_actor_id, -> { String }, optional: true, nullable: false, api_name: "delegatedActorId"

      field :created_at, -> { String }, optional: false, nullable: false, api_name: "createdAt"

      field :merged_by, -> { String }, optional: true, nullable: false, api_name: "mergedBy"

      field :merged_delegated_actor_id, -> { String }, optional: true, nullable: false, api_name: "mergedDelegatedActorId"

      field :merged_at, -> { String }, optional: true, nullable: false, api_name: "mergedAt"
    end
  end
end
