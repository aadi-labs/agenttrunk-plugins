# frozen_string_literal: true

module AgentTrunk
  module Types
    class Error < Internal::Types::Model
      field :error, -> { AgentTrunk::Types::ErrorError }, optional: false, nullable: false
    end
  end
end
