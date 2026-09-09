# frozen_string_literal: true

require_relative "wiremock_test_case"

class ReleasesWireTest < WireMockTestCase
  def setup
    super

    @client = AgentTrunk::Client.new(
      access_token: "<token>",
      base_url: WIREMOCK_BASE_URL
    )
  end

  def test_releases_list_with_wiremock
    test_id = "releases.list.0"

    @client.releases.list(
      trunk_id: "trunkId",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "releases.list.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks/trunkId/promotion-requests",
      query_params: nil,
      expected: 1
    )
  end

  def test_releases_open_with_wiremock
    test_id = "releases.open.0"

    @client.releases.open(
      trunk_id: "trunkId",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "releases.open.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "POST",
      url_path: "/v1/trunks/trunkId/promotion-requests",
      query_params: nil,
      expected: 1
    )
  end

  def test_releases_merge_with_wiremock
    test_id = "releases.merge.0"

    @client.releases.merge(
      trunk_id: "trunkId",
      promotion_id: "promotionId",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "releases.merge.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "POST",
      url_path: "/v1/trunks/trunkId/promotion-requests/promotionId/merge",
      query_params: nil,
      expected: 1
    )
  end
end
