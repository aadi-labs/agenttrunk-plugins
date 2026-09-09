# frozen_string_literal: true

require_relative "wiremock_test_case"

class ScopesWireTest < WireMockTestCase
  def setup
    super

    @client = AgentTrunk::Client.new(
      access_token: "<token>",
      base_url: WIREMOCK_BASE_URL
    )
  end

  def test_scopes_list_with_wiremock
    test_id = "scopes.list.0"

    @client.scopes.list(
      trunk_id: "trunkId",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "scopes.list.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks/trunkId/scopes",
      query_params: nil,
      expected: 1
    )
  end

  def test_scopes_create_with_wiremock
    test_id = "scopes.create.0"

    @client.scopes.create(
      trunk_id: "trunkId",
      name: "name",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "scopes.create.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "POST",
      url_path: "/v1/trunks/trunkId/scopes",
      query_params: nil,
      expected: 1
    )
  end
end
