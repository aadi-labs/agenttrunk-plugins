# frozen_string_literal: true

require_relative "wiremock_test_case"

class WebhooksWireTest < WireMockTestCase
  def setup
    super

    @client = AgentTrunk::Client.new(
      access_token: "<token>",
      base_url: WIREMOCK_BASE_URL
    )
  end

  def test_webhooks_list_with_wiremock
    test_id = "webhooks.list.0"

    @client.webhooks.list(
      trunk_id: "trunkId",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "webhooks.list.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks/trunkId/webhooks",
      query_params: nil,
      expected: 1
    )
  end

  def test_webhooks_create_portal_with_wiremock
    test_id = "webhooks.create_portal.0"

    @client.webhooks.create_portal(
      trunk_id: "trunkId",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "webhooks.create_portal.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "POST",
      url_path: "/v1/trunks/trunkId/webhooks/portal",
      query_params: nil,
      expected: 1
    )
  end

  def test_webhooks_retry__with_wiremock
    test_id = "webhooks.retry_.0"

    @client.webhooks.retry_(
      trunk_id: "trunkId",
      event_id: "eventId",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "webhooks.retry_.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "POST",
      url_path: "/v1/trunks/trunkId/webhooks/eventId/retry",
      query_params: nil,
      expected: 1
    )
  end
end
