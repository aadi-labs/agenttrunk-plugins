# frozen_string_literal: true

module AgentTrunk
  module Webhooks
    class Client
      # @param client [AgentTrunk::Internal::Http::RawClient]
      #
      # @return [void]
      def initialize(client:)
        @client = client
      end

      # Requires trunk management permission. Lists at most 50 workspace submission receipts, not endpoint delivery
      # receipts. Pass nextCursor as before until null.
      #
      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      # @option params [String, nil] :before
      #
      # @example
      #   client.webhooks.list(trunk_id: "trunkId")
      #
      # @return [AgentTrunk::Webhooks::Types::ListWebhooksResponse]
      def list(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["before"] = params[:before] if params.key?(:before)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/webhooks",
          query: query_params,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise AgentTrunk::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          AgentTrunk::Webhooks::Types::ListWebhooksResponse.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # Requires trunk management permission. Enables future workspace events and returns a one-hour bearer access URL
      # for endpoint configuration, delivery inspection, and replay. Never cache or log the URL. Previously issued links
      # remain valid until expiry.
      #
      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      #
      # @example
      #   client.webhooks.create_portal(trunk_id: "trunkId")
      #
      # @return [AgentTrunk::Webhooks::Types::CreatePortalWebhooksResponse]
      def create_portal(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/webhooks/portal",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise AgentTrunk::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          AgentTrunk::Webhooks::Types::CreatePortalWebhooksResponse.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # Requires trunk management permission. Requeue a failed provider submission with the same event identity.
      # Accepted messages must be replayed through the Svix portal. Consumers must deduplicate events.
      #
      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      # @option params [String] :event_id
      #
      # @example
      #   client.webhooks.retry_(
      #     trunk_id: "trunkId",
      #     event_id: "eventId"
      #   )
      #
      # @return [Hash[String, Object]]
      def retry_(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/webhooks/#{URI.encode_uri_component(params[:event_id].to_s)}/retry",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise AgentTrunk::Errors::TimeoutError
        end
        code = response.code.to_i
        return response.body.to_s.empty? ? nil : JSON.parse(response.body) if code.between?(200, 299)

        error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
        raise error_class.new(response.body, code: code)
      end
    end
  end
end
