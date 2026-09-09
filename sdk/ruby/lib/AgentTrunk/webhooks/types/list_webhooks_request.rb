# frozen_string_literal: true

module AgentTrunk
  module Webhooks
    module Types
      class ListWebhooksRequest < Internal::Types::Model
        field :trunk_id, -> { String }, optional: false, nullable: false, api_name: "trunkId"

        field :before, -> { String }, optional: true, nullable: false
      end
    end
  end
end
