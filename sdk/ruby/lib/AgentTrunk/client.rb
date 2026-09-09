# frozen_string_literal: true

module AgentTrunk
  class Client
    # @param base_url [String, nil]
    # @param token [String]
    # @param max_retries [Integer]
    #
    # @return [void]
    def initialize(base_url: nil, token: ENV.fetch("AGENTTRUNK_ACCESS_TOKEN", nil), max_retries: 0)
      @raw_client = AgentTrunk::Internal::Http::RawClient.new(
        base_url: base_url || AgentTrunk::Environment::DEFAULT,
        headers: {
          "X-Fern-Language" => "Ruby",
          Authorization: "Bearer #{token}"
        },
        max_retries: max_retries
      )
    end

    # @return [AgentTrunk::Privacy::Client]
    def privacy
      @privacy ||= AgentTrunk::Privacy::Client.new(client: @raw_client)
    end

    # @return [AgentTrunk::Contexts::Client]
    def contexts
      @contexts ||= AgentTrunk::Contexts::Client.new(client: @raw_client)
    end

    # @return [AgentTrunk::Billing::Client]
    def billing
      @billing ||= AgentTrunk::Billing::Client.new(client: @raw_client)
    end

    # @return [AgentTrunk::Health::Client]
    def health
      @health ||= AgentTrunk::Health::Client.new(client: @raw_client)
    end

    # @return [AgentTrunk::Workspaces::Client]
    def workspaces
      @workspaces ||= AgentTrunk::Workspaces::Client.new(client: @raw_client)
    end

    # @return [AgentTrunk::Webhooks::Client]
    def webhooks
      @webhooks ||= AgentTrunk::Webhooks::Client.new(client: @raw_client)
    end

    # @return [AgentTrunk::Scopes::Client]
    def scopes
      @scopes ||= AgentTrunk::Scopes::Client.new(client: @raw_client)
    end

    # @return [AgentTrunk::ContextSets::Client]
    def context_sets
      @context_sets ||= AgentTrunk::ContextSets::Client.new(client: @raw_client)
    end

    # @return [AgentTrunk::Releases::Client]
    def releases
      @releases ||= AgentTrunk::Releases::Client.new(client: @raw_client)
    end
  end
end
