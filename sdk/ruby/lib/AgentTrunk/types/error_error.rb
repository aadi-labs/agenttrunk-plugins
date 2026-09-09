# frozen_string_literal: true

module AgentTrunk
  module Types
    class ErrorError < Internal::Types::Model
      field :code, -> { String }, optional: false, nullable: false

      field :message, -> { String }, optional: false, nullable: false

      field :request_id, -> { String }, optional: false, nullable: false, api_name: "requestId"
    end
  end
end
