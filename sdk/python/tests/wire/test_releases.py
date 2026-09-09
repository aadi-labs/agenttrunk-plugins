from .conftest import get_client, verify_request_count


def test_releases_list_() -> None:
    """Test list endpoint with WireMock"""
    test_id = "releases.list_.0"
    client = get_client(test_id)
    client.releases.list(
        trunk_id="trunkId",
    )
    verify_request_count(test_id, "GET", "/v1/trunks/trunkId/promotion-requests", None, 1)


def test_releases_open() -> None:
    """Test open endpoint with WireMock"""
    test_id = "releases.open.0"
    client = get_client(test_id)
    client.releases.open(
        trunk_id="trunkId",
    )
    verify_request_count(test_id, "POST", "/v1/trunks/trunkId/promotion-requests", None, 1)


def test_releases_merge() -> None:
    """Test merge endpoint with WireMock"""
    test_id = "releases.merge.0"
    client = get_client(test_id)
    client.releases.merge(
        trunk_id="trunkId",
        promotion_id="promotionId",
    )
    verify_request_count(test_id, "POST", "/v1/trunks/trunkId/promotion-requests/promotionId/merge", None, 1)
