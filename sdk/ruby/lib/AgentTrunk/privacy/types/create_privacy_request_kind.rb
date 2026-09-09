# frozen_string_literal: true

module AgentTrunk
  module Privacy
    module Types
      module CreatePrivacyRequestKind
        extend AgentTrunk::Internal::Types::Enum

        ACCESS = "access"
        ERASURE = "erasure"
      end
    end
  end
end
