# frozen_string_literal: true

module AgentTrunk
  module Types
    class FileRecord < Internal::Types::Model
      field :path, -> { String }, optional: false, nullable: false

      field :size, -> { Integer }, optional: false, nullable: false

      field :sha256, -> { String }, optional: false, nullable: false
    end
  end
end
