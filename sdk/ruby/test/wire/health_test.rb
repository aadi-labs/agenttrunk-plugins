# frozen_string_literal: true

require_relative "wiremock_test_case"

class HealthWireTest < WireMockTestCase
  def setup
    super

    @client = AgentTrunk::Client.new(
      access_token: "<token>",
      base_url: WIREMOCK_BASE_URL
    )
  end

  def test_health_get_with_wiremock
    test_id = "health.get.0"

    @client.health.get(request_options: {
      additional_headers: {
        "X-Test-Id" => "health.get.0"
      }
    })

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/healthz",
      query_params: nil,
      expected: 1
    )
  end
end
