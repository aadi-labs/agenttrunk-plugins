# frozen_string_literal: true

module AgentTrunk
  module Contexts
    class Client
      # @param client [AgentTrunk::Internal::Http::RawClient]
      #
      # @return [void]
      def initialize(client:)
        @client = client
      end

      # Reads require current context authorization. Includes verified files encoded as base64 and metadata; excludes
      # other history, notes, accounts, logs and backups. Not a complete personal-data export.
      #
      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      # @option params [String] :context_key
      # @option params [String] :revision_id
      #
      # @example
      #   client.contexts.export(
      #     trunk_id: "trunkId",
      #     context_key: "contextKey",
      #     revision_id: "revisionId"
      #   )
      #
      # @return [Hash[String, Object]]
      def export(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["revisionId"] = params[:revision_id] if params.key?(:revision_id)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/contexts/#{URI.encode_uri_component(params[:context_key].to_s)}/export",
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

      # Check whether an immutable revision can be restored to staging. This is advisory; the write rechecks
      # permissions, release evidence, and staging concurrency. Ineligible responses do not expose the current staging
      # revision.
      #
      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      # @option params [String] :context_key
      # @option params [String] :revision_id
      #
      # @example
      #   client.contexts.get_rollback_plan(
      #     trunk_id: "trunkId",
      #     context_key: "contextKey",
      #     revision_id: "revisionId"
      #   )
      #
      # @return [AgentTrunk::Contexts::Types::GetRollbackPlanContextsResponse]
      def get_rollback_plan(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["revisionId"] = params[:revision_id] if params.key?(:revision_id)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/contexts/#{URI.encode_uri_component(params[:context_key].to_s)}/rollback",
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
          AgentTrunk::Contexts::Types::GetRollbackPlanContextsResponse.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # Restore a previously released immutable revision into staging. Requires production rollback and staging deploy
      # permissions. Production only changes through a subsequent promotion PR.
      #
      # @param request_options [Hash]
      # @param params [AgentTrunk::Contexts::Types::StageRollbackContextsRequest]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      # @option params [String] :context_key
      #
      # @example
      #   client.contexts.stage_rollback(
      #     trunk_id: "trunkId",
      #     context_key: "contextKey",
      #     revision_id: "revisionId",
      #     expected_staging_revision_id: "expectedStagingRevisionId",
      #     reason: "reason"
      #   )
      #
      # @return [Hash[String, Object]]
      def stage_rollback(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request_data = AgentTrunk::Contexts::Types::StageRollbackContextsRequest.new(params).to_h
        non_body_param_names = %w[trunkId contextKey]
        body = request_data.except(*non_body_param_names)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/contexts/#{URI.encode_uri_component(params[:context_key].to_s)}/rollback",
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

      # @param request_options [Hash]
      # @param params [AgentTrunk::Contexts::Types::PublishInput]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      #
      # @example
      #   client.contexts.publish(
      #     trunk_id: "trunkId",
      #     context_key: "contextKey",
      #     title: "title",
      #     kind: "skill",
      #     files: [{
      #       path: "path",
      #       content_base64: "contentBase64"
      #     }]
      #   )
      #
      # @return [AgentTrunk::Contexts::Types::PublishContextsResponse]
      def publish(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request_data = AgentTrunk::Contexts::Types::PublishInput.new(params).to_h
        non_body_param_names = %w[trunkId]
        body = request_data.except(*non_body_param_names)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/publications",
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
          AgentTrunk::Contexts::Types::PublishContextsResponse.load(response.body)
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
      # @option params [String] :context_key
      #
      # @example
      #   client.contexts.share(
      #     trunk_id: "trunkId",
      #     context_key: "contextKey"
      #   )
      #
      # @return [Hash[String, Object]]
      def share(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/contexts/#{URI.encode_uri_component(params[:context_key].to_s)}/share",
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
      # @option params [String, nil] :scope_id
      # @option params [String, nil] :cursor
      # @option params [String, nil] :trunk_id
      # @option params [String, nil] :query
      # @option params [AgentTrunk::Contexts::Types::DiscoverContextsRequestChannel, nil] :channel
      # @option params [Integer, nil] :limit
      #
      # @example
      #   client.contexts.discover
      #
      # @return [AgentTrunk::Contexts::Types::DiscoverContextsResponse]
      def discover(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["scopeId"] = params[:scope_id] if params.key?(:scope_id)
        query_params["cursor"] = params[:cursor] if params.key?(:cursor)
        query_params["trunkId"] = params[:trunk_id] if params.key?(:trunk_id)
        query_params["query"] = params[:query] if params.key?(:query)
        query_params["channel"] = params[:channel] if params.key?(:channel)
        query_params["limit"] = params[:limit] if params.key?(:limit)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/contexts",
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
          AgentTrunk::Contexts::Types::DiscoverContextsResponse.load(response.body)
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
      # @option params [String] :context_key
      # @option params [String, nil] :ref
      #
      # @example
      #   client.contexts.inspect(
      #     trunk_id: "trunkId",
      #     context_key: "contextKey"
      #   )
      #
      # @return [AgentTrunk::Contexts::Types::InspectContextsResponse]
      def inspect(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["ref"] = params[:ref] if params.key?(:ref)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/contexts/#{URI.encode_uri_component(params[:context_key].to_s)}",
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
          AgentTrunk::Contexts::Types::InspectContextsResponse.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # Atomically add, replace, or delete files in staging, preserving metadata and unchanged files.
      # Requires staging read and deployment permission. expectedRevisionId must equal the current
      # staging revision. Concurrent branch changes return 409; reread and reconcile, never blindly
      # retry. Production is unchanged. The resulting package retains the 256-file, 1 MB per-file,
      # and 16 MB total limits and must not be empty. Each path may appear once. Deleting a missing
      # file is invalid. Identical content is a no-op; restoring historical content uses rollback.
      #
      # @param request_options [Hash]
      # @param params [AgentTrunk::Contexts::Types::EditContextInput]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      # @option params [String] :context_key
      #
      # @example
      #   client.contexts.edit(
      #     trunk_id: "trunkId",
      #     context_key: "contextKey",
      #     expected_revision_id: "expectedRevisionId",
      #     changes: []
      #   )
      #
      # @return [AgentTrunk::Contexts::Types::EditContextsResponse]
      def edit(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request_data = AgentTrunk::Contexts::Types::EditContextInput.new(params).to_h
        non_body_param_names = %w[trunkId contextKey]
        body = request_data.except(*non_body_param_names)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PATCH",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/contexts/#{URI.encode_uri_component(params[:context_key].to_s)}",
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
          AgentTrunk::Contexts::Types::EditContextsResponse.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # Follows immutable parent revisions, authorizing every revision. Historic IDs require staging read or
      # shared-context-item read access.
      #
      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      # @option params [String] :context_key
      # @option params [String, nil] :from
      # @option params [Integer, nil] :limit
      #
      # @example
      #   client.contexts.history(
      #     trunk_id: "trunkId",
      #     context_key: "contextKey"
      #   )
      #
      # @return [AgentTrunk::Contexts::Types::HistoryContextsResponse]
      def history(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["from"] = params[:from] if params.key?(:from)
        query_params["limit"] = params[:limit] if params.key?(:limit)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/contexts/#{URI.encode_uri_component(params[:context_key].to_s)}/history",
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
          AgentTrunk::Contexts::Types::HistoryContextsResponse.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # Authorizes both revisions and returns their manifests, per-file statuses,
      # and one selected file preview. Target defaults to latest; base defaults to
      # the target's parent, or an empty snapshot for the first revision. The
      # returned IDs are immutable; use them for subsequent file selections.
      # UTF-8 previews verify file digests and are capped at 128000 bytes per side.
      # reason is null, too_large, binary, or too_complex. Omitted previews have
      # empty content and zero counts, which must not be displayed as no changes.
      #
      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      # @option params [String] :context_key
      # @option params [String, nil] :base
      # @option params [String, nil] :target
      # @option params [String, nil] :path
      #
      # @example
      #   client.contexts.compare(
      #     trunk_id: "trunkId",
      #     context_key: "contextKey"
      #   )
      #
      # @return [Hash[String, Object]]
      def compare(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["base"] = params[:base] if params.key?(:base)
        query_params["target"] = params[:target] if params.key?(:target)
        query_params["path"] = params[:path] if params.key?(:path)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/contexts/#{URI.encode_uri_component(params[:context_key].to_s)}/compare",
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
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      # @option params [String] :context_key
      # @option params [String, nil] :ref
      #
      # @example
      #   client.contexts.get_provenance(
      #     trunk_id: "trunkId",
      #     context_key: "contextKey"
      #   )
      #
      # @return [Hash[String, Object]]
      def get_provenance(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["ref"] = params[:ref] if params.key?(:ref)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/contexts/#{URI.encode_uri_component(params[:context_key].to_s)}/provenance",
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

      # Requires revision read and staging environment deployment permission. Author identity is assigned server-side.
      # Does not modify content, channels, or PR approval. Concurrent updates return 409; reread and reconcile, never
      # blindly retry with a newer token.
      #
      # @param request_options [Hash]
      # @param params [AgentTrunk::Contexts::Types::PutProvenanceContextsRequest]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      # @option params [String] :context_key
      #
      # @example
      #   client.contexts.put_provenance(
      #     trunk_id: "trunkId",
      #     context_key: "contextKey",
      #     revision_id: "revisionId",
      #     text: "text"
      #   )
      #
      # @return [Hash[String, Object]]
      def put_provenance(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request_data = AgentTrunk::Contexts::Types::PutProvenanceContextsRequest.new(params).to_h
        non_body_param_names = %w[trunkId contextKey]
        body = request_data.except(*non_body_param_names)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "PUT",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/contexts/#{URI.encode_uri_component(params[:context_key].to_s)}/provenance",
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

      # @param request_options [Hash]
      # @param params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      # @option params [String] :trunk_id
      # @option params [String] :context_key
      # @option params [String] :resource_path
      # @option params [String] :ref
      #
      # @example
      #   client.contexts.read_file(
      #     trunk_id: "trunkId",
      #     context_key: "contextKey",
      #     resource_path: "resourcePath",
      #     ref: "ref"
      #   )
      #
      # @return [untyped]
      def read_file(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params["ref"] = params[:ref] if params.key?(:ref)

        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/trunks/#{URI.encode_uri_component(params[:trunk_id].to_s)}/contexts/#{URI.encode_uri_component(params[:context_key].to_s)}/files/#{URI.encode_uri_component(params[:resource_path].to_s)}",
          query: query_params,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise AgentTrunk::Errors::TimeoutError
        end
        code = response.code.to_i
        return response.body if code.between?(200, 299)

        error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
        raise error_class.new(response.body, code: code)
      end
    end
  end
end
