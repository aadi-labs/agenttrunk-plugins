# frozen_string_literal: true

module AgentTrunk
  module Webhooks
    module Types
      class ListWebhooksResponseDataItem < Internal::Types::Model
        field :sequence, -> { String }, optional: true, nullable: false

        field :event_id, -> { String }, optional: true, nullable: false, api_name: "eventId"

        field :status, -> { AgentTrunk::Webhooks::Types::ListWebhooksResponseDataItemStatus }, optional: true, nullable: false

        field :attempts, -> { Integer }, optional: true, nullable: false

        field :last_error, -> { String }, optional: true, nullable: false, api_name: "lastError"

        field :svix_message_id, -> { String }, optional: true, nullable: false, api_name: "svixMessageId"
      end
    end
  end
end
