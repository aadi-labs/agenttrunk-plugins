# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      class EditContextInputChangesItemDelete < Internal::Types::Model
        field :path, -> { String }, optional: false, nullable: false
      end
    end
  end
end
