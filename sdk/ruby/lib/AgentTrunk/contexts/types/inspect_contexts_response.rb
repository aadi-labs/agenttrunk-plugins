# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      class InspectContextsResponse < Internal::Types::Model
        field :context, -> { AgentTrunk::Types::Context }, optional: false, nullable: false

        field :revision, -> { AgentTrunk::Types::Revision }, optional: false, nullable: false
      end
    end
  end
end
