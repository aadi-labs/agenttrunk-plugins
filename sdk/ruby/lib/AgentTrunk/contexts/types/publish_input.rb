# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      class PublishInput < Internal::Types::Model
        field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

        field :context_key, -> { String }, optional: false, nullable: false, api_name: "contextKey"

        field :title, -> { String }, optional: false, nullable: false

        field :summary, -> { String }, optional: true, nullable: false

        field :kind, -> { AgentTrunk::Types::ContextKind }, optional: false, nullable: false

        field :tags, -> { Internal::Types::Array[String] }, optional: true, nullable: false

        field :files, -> { Internal::Types::Array[AgentTrunk::Types::FileInput] }, optional: false, nullable: false

        field :claimed_digest, -> { String }, optional: true, nullable: false, api_name: "claimedDigest"

        field :scope_id, -> { String }, optional: true, nullable: false, api_name: "scopeId"
      end
    end
  end
end
