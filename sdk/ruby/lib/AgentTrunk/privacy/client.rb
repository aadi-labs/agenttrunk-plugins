# frozen_string_literal: true

module AgentTrunk
  module Privacy
    class Client
      # @param client [AgentTrunk::Internal::Http::RawClient]
      #
      # @return [void]
      def initialize(client:)
        @client = client
      end

      # Requires workspace management. Repeating the same assignment is safe; other owners and terminal cases conflict.
      # Does not verify identity or complete fulfillment.
      #
      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      # @option params [String] :request_id
      #
      # @example
      #   client.privacy.assign_review(
      #     trunk_id: "trunkId",
      #     request_id: "requestId",
      #     request: {
      #       key: "value"
      #     }
      #   )
      #
      # @return [Hash[String, Object]]
      def assign_review(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        path_param_names = %i[trunk_id request_id]
        body_params = params.except(*path_param_names)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/privacy-requests/#{URI.encode_uri_component(params[:request_id].to_s)}/review",
          body: body_params,
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

      # Requires workspace management. Counts selected database dependencies; explicitly not executable or a complete
      # provider inventory.
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
      #   client.privacy.erasure_plan(trunk_id: "trunkId")
      #
      # @return [Hash[String, Object]]
      def erasure_plan(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/erasure-plan",
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

      # Requires workspace management. This is not a personal-data export.
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
      #   client.privacy.list(trunk_id: "trunkId")
      #
      # @return [Hash[String, Object]]
      def list(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/privacy-requests",
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

      # Requires workspace management. Deduplicates open requests for the authorizing user. Does not export or delete
      # data.
      #
      # @param request_options [Hash]
      # @param params [AgentTrunk::Privacy::Types::CreatePrivacyRequest]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      #
      # @example
      #   client.privacy.create(
      #     trunk_id: "trunkId",
      #     kind: "access"
      #   )
      #
      # @return [Hash[String, Object]]
      def create(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request_data = AgentTrunk::Privacy::Types::CreatePrivacyRequest.new(params).to_h
        non_body_param_names = %w[trunkId]
        body = request_data.except(*non_body_param_names)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/privacy-requests",
          body: body,
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
