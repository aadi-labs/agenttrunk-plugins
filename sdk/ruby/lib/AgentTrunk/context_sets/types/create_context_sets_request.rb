# frozen_string_literal: true

module AgentTrunk
  module ContextSets
    module Types
      class CreateContextSetsRequest < Internal::Types::Model
        field :name, -> { String }, optional: false, nullable: false

        field :sources, -> { Internal::Types::Array[AgentTrunk::Types::ContextSetSource] }, optional: false, nullable: false
      end
    end
  end
end
