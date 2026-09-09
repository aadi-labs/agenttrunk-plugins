# frozen_string_literal: true

module AgentTrunk
  module Types
    class FileInput < Internal::Types::Model
      field :path, -> { String }, optional: false, nullable: false

      field :content_base64, -> { String }, optional: false, nullable: false, api_name: "contentBase64"
    end
  end
end
