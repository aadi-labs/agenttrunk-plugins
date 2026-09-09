# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      class PutProvenanceContextsRequest < Internal::Types::Model
        field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

        field :context_key, -> { String }, optional: false, nullable: false, api_name: "contextKey"

        field :revision_id, -> { String }, optional: false, nullable: false, api_name: "revisionId"

        field :text, -> { String }, optional: false, nullable: false

        field :expected_notes_commit_sha, -> { String }, optional: false, nullable: true, api_name: "expectedNotesCommitSha"
      end
    end
  end
end
