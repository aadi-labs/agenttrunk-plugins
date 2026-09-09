# frozen_string_literal: true

module AgentTrunk
  module Scopes
    class Client
      # @param client [AgentTrunk::Internal::Http::RawClient]
      #
      # @return [void]
      def initialize(client:)
        @client = client
      end

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
      #   client.scopes.list(trunk_id: "trunkId")
      #
      # @return [AgentTrunk::Scopes::Types::ListScopesResponse]
      def list(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/scopes",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise AgentTrunk::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          AgentTrunk::Scopes::Types::ListScopesResponse.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [AgentTrunk::Scopes::Types::CreateScopesRequest]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      #
      # @example
      #   client.scopes.create(
      #     trunk_id: "trunkId",
      #     name: "name"
      #   )
      #
      # @return [AgentTrunk::Types::Scope]
      def create(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request_data = AgentTrunk::Scopes::Types::CreateScopesRequest.new(params).to_h
        non_body_param_names = %w[trunkId]
        body = request_data.except(*non_body_param_names)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/scopes",
          body: body,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise AgentTrunk::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          AgentTrunk::Types::Scope.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end
    end
  end
end
