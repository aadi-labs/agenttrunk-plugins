# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      class GetRollbackPlanContextsResponse < Internal::Types::Model
        field :eligible, -> { Internal::Types::Boolean }, optional: false, nullable: false

        field :expected_staging_revision_id, -> { String }, optional: false, nullable: true, api_name: "expectedStagingRevisionId"

        field :reason, -> { String }, optional: false, nullable: false
      end
    end
  end
end
