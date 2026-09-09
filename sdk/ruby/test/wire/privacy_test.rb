# frozen_string_literal: true

require_relative "wiremock_test_case"

class PrivacyWireTest < WireMockTestCase
  def setup
    super

    @client = AgentTrunk::Client.new(
      access_token: "<token>",
      base_url: WIREMOCK_BASE_URL
    )
  end

  def test_privacy_assign_review_with_wiremock
    test_id = "privacy.assign_review.0"

    @client.privacy.assign_review(
      trunk_id: "trunkId",
      request_id: "requestId",
      request: {
        key: "value"
      },
      request_options: {
        additional_headers: {
          "X-Test-Id" => "privacy.assign_review.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "POST",
      url_path: "/v1/trunks/trunkId/privacy-requests/requestId/review",
      query_params: nil,
      expected: 1
    )
  end

  def test_privacy_erasure_plan_with_wiremock
    test_id = "privacy.erasure_plan.0"

    @client.privacy.erasure_plan(
      trunk_id: "trunkId",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "privacy.erasure_plan.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks/trunkId/erasure-plan",
      query_params: nil,
      expected: 1
    )
  end

  def test_privacy_list_with_wiremock
    test_id = "privacy.list.0"

    @client.privacy.list(
      trunk_id: "trunkId",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "privacy.list.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "GET",
      url_path: "/v1/trunks/trunkId/privacy-requests",
      query_params: nil,
      expected: 1
    )
  end

  def test_privacy_create_with_wiremock
    test_id = "privacy.create.0"

    @client.privacy.create(
      trunk_id: "trunkId",
      kind: "access",
      request_options: {
        additional_headers: {
          "X-Test-Id" => "privacy.create.0"
        }
      }
    )

    verify_request_count(
      test_id: test_id,
      method: "POST",
      url_path: "/v1/trunks/trunkId/privacy-requests",
      query_params: nil,
      expected: 1
    )
  end
end
