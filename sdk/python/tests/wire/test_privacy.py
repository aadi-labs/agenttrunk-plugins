from .conftest import get_client, verify_request_count


def test_privacy_assign_review() -> None:
    """Test assignReview endpoint with WireMock"""
    test_id = "privacy.assign_review.0"
    client = get_client(test_id)
    client.privacy.assign_review(
        trunk_id="trunkId",
        request_id="requestId",
        request={"key": "value"},
    )
    verify_request_count(test_id, "POST", "/v1/trunks/trunkId/privacy-requests/requestId/review", None, 1)


def test_privacy_erasure_plan() -> None:
    """Test erasurePlan endpoint with WireMock"""
    test_id = "privacy.erasure_plan.0"
    client = get_client(test_id)
    client.privacy.erasure_plan(
        trunk_id="trunkId",
    )
    verify_request_count(test_id, "GET", "/v1/trunks/trunkId/erasure-plan", None, 1)


def test_privacy_list_() -> None:
    """Test list endpoint with WireMock"""
    test_id = "privacy.list_.0"
    client = get_client(test_id)
    client.privacy.list(
        trunk_id="trunkId",
    )
    verify_request_count(test_id, "GET", "/v1/trunks/trunkId/privacy-requests", None, 1)


def test_privacy_create() -> None:
    """Test create endpoint with WireMock"""
    test_id = "privacy.create.0"
    client = get_client(test_id)
    client.privacy.create(
        trunk_id="trunkId",
        kind="access",
    )
    verify_request_count(test_id, "POST", "/v1/trunks/trunkId/privacy-requests", None, 1)
