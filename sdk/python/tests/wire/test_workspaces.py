from .conftest import get_client, verify_request_count


def test_workspaces_list_() -> None:
    """Test list endpoint with WireMock"""
    test_id = "workspaces.list_.0"
    client = get_client(test_id)
    client.workspaces.list()
    verify_request_count(test_id, "GET", "/v1/trunks", None, 1)


def test_workspaces_create() -> None:
    """Test create endpoint with WireMock"""
    test_id = "workspaces.create.0"
    client = get_client(test_id)
    client.workspaces.create(
        name="name",
    )
    verify_request_count(test_id, "POST", "/v1/trunks", None, 1)


def test_workspaces_get() -> None:
    """Test get endpoint with WireMock"""
    test_id = "workspaces.get.0"
    client = get_client(test_id)
    client.workspaces.get(
        trunk_id="trunkId",
    )
    verify_request_count(test_id, "GET", "/v1/trunks/trunkId", None, 1)


def test_workspaces_audit() -> None:
    """Test audit endpoint with WireMock"""
    test_id = "workspaces.audit.0"
    client = get_client(test_id)
    client.workspaces.audit(
        trunk_id="trunkId",
    )
    verify_request_count(test_id, "GET", "/v1/trunks/trunkId/audit", None, 1)
