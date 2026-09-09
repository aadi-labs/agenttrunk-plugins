# frozen_string_literal: true

require_relative "wiremock_test_case"

class WorkspacesWireTest < WireMockTestCase
  def setup
    super

    @client = AgentTrunk::Client.new(
      access_token: "<token>",
      base_url: WIREMOCK_BASE_URL
    )
  end

  def test_workspaces_list_with_wiremock
    test_id = "workspaces.list.0"

    @client.workspaces.list(request_options: {
      additional_headers: {
        "X-Test-Id" => "workspaces.list.0"
      }
    })

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks",
      query_params: nil,
      expected: 1
    )
  end

  def test_workspaces_create_with_wiremock
    test_id = "workspaces.create.0"

    @client.workspaces.create(
      name: "name",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "workspaces.create.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "POST",
      url_path: "/v1/trunks",
      query_params: nil,
      expected: 1
    )
  end

  def test_workspaces_get_with_wiremock
    test_id = "workspaces.get.0"

    @client.workspaces.get(
      trunk_id: "trunkId",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "workspaces.get.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks/trunkId",
      query_params: nil,
      expected: 1
    )
  end

  def test_workspaces_audit_with_wiremock
    test_id = "workspaces.audit.0"

    @client.workspaces.audit(
      trunk_id: "trunkId",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "workspaces.audit.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks/trunkId/audit",
      query_params: nil,
      expected: 1
    )
  end
end
