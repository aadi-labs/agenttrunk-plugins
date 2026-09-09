# frozen_string_literal: true

module AgentTrunk
  module ContextSets
    class Client
      # @param client [AgentTrunk::Internal::Http::RawClient]
      #
      # @return [void]
      def initialize(client:)
        @client = client
      end

      # Returns up to 20 candidates with current authorization checks and an opaque nextCursor. Snapshots expire after
      # 15 minutes; narrow the scope if the 10000-record or 8 MB snapshot limit is exceeded.
      #
      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String, nil] :cursor
      #
      # @example
      #   client.context_sets.sources
      #
      # @return [Hash[String, Object]]
      def sources(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["cursor"] = params[:cursor] if params.key?(:cursor)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/context-sources",
          query: query_params,
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

      # Snapshot-stable candidates with current WorkOS authorization rechecked on each page. Cursors expire after 15
      # minutes and are bound to the principal and filters.
      #
      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String, nil] :cursor
      # @option params [Integer, nil] :limit
      #
      # @example
      #   client.context_sets.list
      #
      # @return [Hash[String, Object]]
      def list(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["cursor"] = params[:cursor] if params.key?(:cursor)
        query_params["limit"] = params[:limit] if params.key?(:limit)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/context-sets",
          query: query_params,
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

      # @param request_options [Hash]
      # @param params [AgentTrunk::ContextSets::Types::CreateContextSetsRequest]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.context_sets.create(
      #     name: "name",
      #     sources: [{
      #       source_trunk_id: "sourceTrunkId",
      #       source_scope_id: "sourceScopeId",
      #       environment_id: "environmentId",
      #       context_key: "contextKey",
      #       revision_id: "revisionId",
      #       package_digest: "packageDigest",
      #       mount_path: "mountPath",
      #       required: true
      #     }]
      #   )
      #
      # @return [Hash[String, Object]]
      def create(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/context-sets",
          body: AgentTrunk::ContextSets::Types::CreateContextSetsRequest.new(params).to_h,
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

      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :context_set_id
      #
      # @example
      #   client.context_sets.resolve(context_set_id: "contextSetId")
      #
      # @return [Hash[String, Object]]
      def resolve(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/context-sets/#{URI.encode_uri_component(params[:context_set_id].to_s)}/resolve",
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
