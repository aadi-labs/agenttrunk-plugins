# frozen_string_literal: true

module AgentTrunk
  module Privacy
    module Types
      class CreatePrivacyRequest < Internal::Types::Model
        field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

        field :kind, -> { AgentTrunk::Privacy::Types::CreatePrivacyRequestKind }, optional: false, nullable: false
      end
    end
  end
end
