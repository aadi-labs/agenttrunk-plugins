# frozen_string_literal: true

module AgentTrunk
  module Types
    module ContextKind
      extend AgentTrunk::Internal::Types::Enum

      SKILL = "skill"
      DOCS = "docs"
      PROMPT = "prompt"
      POLICY = "policy"
      MEMORY_SCHEMA = "memory-schema"
    end
  end
end
