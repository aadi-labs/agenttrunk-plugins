# frozen_string_literal: true

require_relative "wiremock_test_case"

class ContextSetsWireTest < WireMockTestCase
  def setup
    super

    @client = AgentTrunk::Client.new(
      access_token: "<token>",
      base_url: WIREMOCK_BASE_URL
    )
  end

  def test_context_sets_sources_with_wiremock
    test_id = "context_sets.sources.0"

    @client.context_sets.sources(request_options: {
      additional_headers: {
        "X-Test-Id" => "context_sets.sources.0"
      }
    })

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/context-sources",
      query_params: nil,
      expected: 1
    )
  end

  def test_context_sets_list_with_wiremock
    test_id = "context_sets.list.0"

    @client.context_sets.list(request_options: {
      additional_headers: {
        "X-Test-Id" => "context_sets.list.0"
      }
    })

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/context-sets",
      query_params: nil,
      expected: 1
    )
  end

  def test_context_sets_create_with_wiremock
    test_id = "context_sets.create.0"

    @client.context_sets.create(
      name: "name",
      sources: [{
        source_trunk_id: "sourceTrunkId",
        source_scope_id: "sourceScopeId",
        environment_id: "environmentId",
        context_key: "contextKey",
        revision_id: "revisionId",
        package_digest: "packageDigest",
        mount_path: "mountPath",
        required: true
      }],
      request_options: {
        additional_headers: {
          "X-Test-Id" => "context_sets.create.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "POST",
      url_path: "/v1/context-sets",
      query_params: nil,
      expected: 1
    )
  end

  def test_context_sets_resolve_with_wiremock
    test_id = "context_sets.resolve.0"

    @client.context_sets.resolve(
      context_set_id: "contextSetId",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "context_sets.resolve.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "POST",
      url_path: "/v1/context-sets/contextSetId/resolve",
      query_params: nil,
      expected: 1
    )
  end
end
