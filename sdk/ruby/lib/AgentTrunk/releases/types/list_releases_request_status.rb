# frozen_string_literal: true

module AgentTrunk
  module Releases
    module Types
      module ListReleasesRequestStatus
        extend AgentTrunk::Internal::Types::Enum

        OPEN = "open"
        MERGED = "merged"
        CLOSED = "closed"
      end
    end
  end
end
