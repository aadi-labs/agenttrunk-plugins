# frozen_string_literal: true

module AgentTrunk
  module Workspaces
    module Types
      class CreateTrunkInput < Internal::Types::Model
        field :name, -> { String }, optional: false, nullable: false

        field :description, -> { String }, optional: true, nullable: false
      end
    end
  end
end
