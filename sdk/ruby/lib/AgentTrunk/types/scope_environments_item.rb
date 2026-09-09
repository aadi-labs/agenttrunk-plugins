# frozen_string_literal: true

module AgentTrunk
  module Types
    class ScopeEnvironmentsItem < Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false

      field :name, -> { AgentTrunk::Types::ScopeEnvironmentsItemName }, optional: false, nullable: false

      field :commit_sha, -> { String }, optional: false, nullable: true, api_name: "commitSha"

      field :can_deploy, -> { Internal::Types::Boolean }, optional: true, nullable: false, api_name: "canDeploy"

      field :can_propose, -> { Internal::Types::Boolean }, optional: true, nullable: false, api_name: "canPropose"

      field :can_publish, -> { Internal::Types::Boolean }, optional: true, nullable: false, api_name: "canPublish"
    end
  end
end
