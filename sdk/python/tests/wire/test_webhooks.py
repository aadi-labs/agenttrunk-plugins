from .conftest import get_client, verify_request_count


def test_webhooks_list_() -> None:
    """Test list endpoint with WireMock"""
    test_id = "webhooks.list_.0"
    client = get_client(test_id)
    client.webhooks.list(
        trunk_id="trunkId",
    )
    verify_request_count(test_id, "GET", "/v1/trunks/trunkId/webhooks", None, 1)


def test_webhooks_create_portal() -> None:
    """Test createPortal endpoint with WireMock"""
    test_id = "webhooks.create_portal.0"
    client = get_client(test_id)
    client.webhooks.create_portal(
        trunk_id="trunkId",
    )
    verify_request_count(test_id, "POST", "/v1/trunks/trunkId/webhooks/portal", None, 1)


def test_webhooks_retry() -> None:
    """Test retry endpoint with WireMock"""
    test_id = "webhooks.retry.0"
    client = get_client(test_id)
    client.webhooks.retry(
        trunk_id="trunkId",
        event_id="eventId",
    )
    verify_request_count(test_id, "POST", "/v1/trunks/trunkId/webhooks/eventId/retry", None, 1)
