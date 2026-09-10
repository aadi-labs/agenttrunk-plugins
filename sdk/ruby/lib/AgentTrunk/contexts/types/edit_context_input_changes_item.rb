# frozen_string_literal: true

module AgentTrunk
  module Contexts
    module Types
      class EditContextInputChangesItem < Internal::Types::Model
        extend AgentTrunk::Internal::Types::Union

        discriminant :operation

        member -> { AgentTrunk::Contexts::Types::EditContextInputChangesItemPut }, key: "PUT"

        member -> { AgentTrunk::Contexts::Types::EditContextInputChangesItemDelete }, key: "DELETE"
      end
    end
  end
end
