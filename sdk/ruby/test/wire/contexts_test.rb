# frozen_string_literal: true

require_relative "wiremock_test_case"

class ContextsWireTest < WireMockTestCase
  def setup
    super

    @client = AgentTrunk::Client.new(
      access_token: "<token>",
      base_url: WIREMOCK_BASE_URL
    )
  end

  def test_contexts_export_with_wiremock
    test_id = "contexts.export.0"

    @client.contexts.export(
      trunk_id: "trunkId",
      context_key: "contextKey",
      revision_id: "revisionId",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "contexts.export.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks/trunkId/contexts/contextKey/export",
      query_params: { "revisionId" => "revisionId" },
      expected: 1
    )
  end

  def test_contexts_get_rollback_plan_with_wiremock
    test_id = "contexts.get_rollback_plan.0"

    @client.contexts.get_rollback_plan(
      trunk_id: "trunkId",
      context_key: "contextKey",
      revision_id: "revisionId",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "contexts.get_rollback_plan.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks/trunkId/contexts/contextKey/rollback",
      query_params: { "revisionId" => "revisionId" },
      expected: 1
    )
  end

  def test_contexts_stage_rollback_with_wiremock
    test_id = "contexts.stage_rollback.0"

    @client.contexts.stage_rollback(
      trunk_id: "trunkId",
      context_key: "contextKey",
      revision_id: "revisionId",
      expected_staging_revision_id: "expectedStagingRevisionId",
      reason: "reason",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "contexts.stage_rollback.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "POST",
      url_path: "/v1/trunks/trunkId/contexts/contextKey/rollback",
      query_params: nil,
      expected: 1
    )
  end

  def test_contexts_publish_with_wiremock
    test_id = "contexts.publish.0"

    @client.contexts.publish(
      trunk_id: "trunkId",
      context_key: "contextKey",
      title: "title",
      kind: "skill",
      files: [{
        path: "path",
        content_base64: "contentBase64"
      }],
      request_options: {
        additional_headers: {
          "X-Test-Id" => "contexts.publish.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "POST",
      url_path: "/v1/trunks/trunkId/publications",
      query_params: nil,
      expected: 1
    )
  end

  def test_contexts_share_with_wiremock
    test_id = "contexts.share.0"

    @client.contexts.share(
      trunk_id: "trunkId",
      context_key: "contextKey",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "contexts.share.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "POST",
      url_path: "/v1/trunks/trunkId/contexts/contextKey/share",
      query_params: nil,
      expected: 1
    )
  end

  def test_contexts_discover_with_wiremock
    test_id = "contexts.discover.0"

    @client.contexts.discover(request_options: {
      additional_headers: {
        "X-Test-Id" => "contexts.discover.0"
      }
    })

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/contexts",
      query_params: nil,
      expected: 1
    )
  end

  def test_contexts_inspect_with_wiremock
    test_id = "contexts.inspect.0"

    @client.contexts.inspect(
      trunk_id: "trunkId",
      context_key: "contextKey",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "contexts.inspect.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks/trunkId/contexts/contextKey",
      query_params: nil,
      expected: 1
    )
  end

  def test_contexts_edit_with_wiremock
    test_id = "contexts.edit.0"

    @client.contexts.edit(
      trunk_id: "trunkId",
      context_key: "contextKey",
      expected_revision_id: "expectedRevisionId",
      changes: [],
      request_options: {
        additional_headers: {
          "X-Test-Id" => "contexts.edit.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "PATCH",
      url_path: "/v1/trunks/trunkId/contexts/contextKey",
      query_params: nil,
      expected: 1
    )
  end

  def test_contexts_history_with_wiremock
    test_id = "contexts.history.0"

    @client.contexts.history(
      trunk_id: "trunkId",
      context_key: "contextKey",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "contexts.history.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks/trunkId/contexts/contextKey/history",
      query_params: nil,
      expected: 1
    )
  end

  def test_contexts_compare_with_wiremock
    test_id = "contexts.compare.0"

    @client.contexts.compare(
      trunk_id: "trunkId",
      context_key: "contextKey",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "contexts.compare.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks/trunkId/contexts/contextKey/compare",
      query_params: nil,
      expected: 1
    )
  end

  def test_contexts_get_provenance_with_wiremock
    test_id = "contexts.get_provenance.0"

    @client.contexts.get_provenance(
      trunk_id: "trunkId",
      context_key: "contextKey",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "contexts.get_provenance.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks/trunkId/contexts/contextKey/provenance",
      query_params: nil,
      expected: 1
    )
  end

  def test_contexts_put_provenance_with_wiremock
    test_id = "contexts.put_provenance.0"

    @client.contexts.put_provenance(
      trunk_id: "trunkId",
      context_key: "contextKey",
      revision_id: "revisionId",
      text: "text",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "contexts.put_provenance.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "PUT",
      url_path: "/v1/trunks/trunkId/contexts/contextKey/provenance",
      query_params: nil,
      expected: 1
    )
  end

  def test_contexts_read_file_with_wiremock
    test_id = "contexts.read_file.0"

    @client.contexts.read_file(
      trunk_id: "trunkId",
      context_key: "contextKey",
      resource_path: "resourcePath",
      ref: "ref",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "contexts.read_file.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks/trunkId/contexts/contextKey/files/resourcePath",
      query_params: { "ref" => "ref" },
      expected: 1
    )
  end
end
