# frozen_string_literal: true

module AgentTrunk
  module Releases
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
      # @option params [String, nil] :cursor
      # @option params [String, nil] :scope_id
      # @option params [AgentTrunk::Releases::Types::ListReleasesRequestStatus, nil] :status
      # @option params [Integer, nil] :limit
      #
      # @example
      #   client.releases.list(trunk_id: "trunkId")
      #
      # @return [AgentTrunk::Releases::Types::ListReleasesResponse]
      def list(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["cursor"] = params[:cursor] if params.key?(:cursor)
        query_params["scopeId"] = params[:scope_id] if params.key?(:scope_id)
        query_params["status"] = params[:status] if params.key?(:status)
        query_params["limit"] = params[:limit] if params.key?(:limit)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/promotion-requests",
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
          AgentTrunk::Releases::Types::ListReleasesResponse.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [AgentTrunk::Releases::Types::OpenPromotionRequestInput]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      #
      # @example
      #   client.releases.open(trunk_id: "trunkId")
      #
      # @return [AgentTrunk::Types::PromotionRequest]
      def open(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request_data = AgentTrunk::Releases::Types::OpenPromotionRequestInput.new(params).to_h
        non_body_param_names = %w[trunkId]
        body = request_data.except(*non_body_param_names)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/promotion-requests",
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
          AgentTrunk::Types::PromotionRequest.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      # @option params [String] :promotion_id
      #
      # @example
      #   client.releases.merge(
      #     trunk_id: "trunkId",
      #     promotion_id: "promotionId"
      #   )
      #
      # @return [AgentTrunk::Types::PromotionRequest]
      def merge(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/promotion-requests/#{URI.encode_uri_component(params[:promotion_id].to_s)}/merge",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise AgentTrunk::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          AgentTrunk::Types::PromotionRequest.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end
    end
  end
end
