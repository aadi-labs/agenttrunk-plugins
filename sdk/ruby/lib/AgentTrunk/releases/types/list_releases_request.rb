# frozen_string_literal: true

module AgentTrunk
  module Releases
    module Types
      class ListReleasesRequest < Internal::Types::Model
        field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

        field :cursor, -> { String }, optional: true, nullable: false

        field :scope_id, -> { String }, optional: true, nullable: false, api_name: "scopeId"

        field :status, -> { AgentTrunk::Releases::Types::ListReleasesRequestStatus }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
