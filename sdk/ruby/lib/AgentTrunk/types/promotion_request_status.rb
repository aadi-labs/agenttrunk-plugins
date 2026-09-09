# frozen_string_literal: true

module AgentTrunk
  module Types
    module PromotionRequestStatus
      extend AgentTrunk::Internal::Types::Enum

      OPEN = "open"
      MERGED = "merged"
      CLOSED = "closed"
    end
  end
end
