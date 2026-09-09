# frozen_string_literal: true

module AgentTrunk
  module Webhooks
    module Types
      class ListWebhooksResponse < Internal::Types::Model
        field :next_cursor, -> { String }, optional: false, nullable: true, api_name: "nextCursor"

        field :data, -> { Internal::Types::Array[AgentTrunk::Webhooks::Types::ListWebhooksResponseDataItem] }, optional: false, nullable: false
      end
    end
  end
end
