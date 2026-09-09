from .conftest import get_client, verify_request_count


def test_health_get() -> None:
    """Test get endpoint with WireMock"""
    test_id = "health.get.0"
    client = get_client(test_id)
    client.health.get()
    verify_request_count(test_id, "GET", "/healthz", None, 1)
