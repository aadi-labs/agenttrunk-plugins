# frozen_string_literal: true

module AgentTrunk
  module Webhooks
    module Types
      module ListWebhooksResponseDataItemStatus
        extend AgentTrunk::Internal::Types::Enum

        PENDING = "pending"
        ACCEPTED = "accepted"
        FAILED = "failed"
      end
    end
  end
end
