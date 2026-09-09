from .conftest import get_client, verify_request_count


def test_scopes_list_() -> None:
    """Test list endpoint with WireMock"""
    test_id = "scopes.list_.0"
    client = get_client(test_id)
    client.scopes.list(
        trunk_id="trunkId",
    )
    verify_request_count(test_id, "GET", "/v1/trunks/trunkId/scopes", None, 1)


def test_scopes_create() -> None:
    """Test create endpoint with WireMock"""
    test_id = "scopes.create.0"
    client = get_client(test_id)
    client.scopes.create(
        trunk_id="trunkId",
        name="name",
    )
    verify_request_count(test_id, "POST", "/v1/trunks/trunkId/scopes", None, 1)
