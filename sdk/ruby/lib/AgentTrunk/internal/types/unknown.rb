# frozen_string_literal: true

module AgentTrunk
  module Internal
    module Types
      module Unknown
        include AgentTrunk::Internal::Types::Type

        def coerce(value)
          value
        end
      end
    end
  end
end
