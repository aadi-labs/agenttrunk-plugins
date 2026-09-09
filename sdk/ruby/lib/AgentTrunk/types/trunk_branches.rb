# frozen_string_literal: true

module AgentTrunk
  module Types
    class TrunkBranches < Internal::Types::Model
      field :staging, -> { String }, optional: false, nullable: true

      field :production, -> { String }, optional: false, nullable: true
    end
  end
end
