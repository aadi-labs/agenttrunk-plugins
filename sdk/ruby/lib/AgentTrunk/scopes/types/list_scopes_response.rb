# frozen_string_literal: true

module AgentTrunk
  module Scopes
    module Types
      class ListScopesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[AgentTrunk::Types::Scope] }, optional: false, nullable: false
      end
    end
  end
end
