from .conftest import get_client, verify_request_count

from agenttrunk import ContextSetSource


def test_contextSets_sources() -> None:
    """Test sources endpoint with WireMock"""
    test_id = "context_sets.sources.0"
    client = get_client(test_id)
    client.context_sets.sources()
    verify_request_count(test_id, "GET", "/v1/context-sources", None, 1)


def test_contextSets_list_() -> None:
    """Test list endpoint with WireMock"""
    test_id = "context_sets.list_.0"
    client = get_client(test_id)
    client.context_sets.list()
    verify_request_count(test_id, "GET", "/v1/context-sets", None, 1)


def test_contextSets_create() -> None:
    """Test create endpoint with WireMock"""
    test_id = "context_sets.create.0"
    client = get_client(test_id)
    client.context_sets.create(
        name="name",
        sources=[
            ContextSetSource(
                source_trunk_id="sourceTrunkId",
                source_scope_id="sourceScopeId",
                environment_id="environmentId",
                context_key="contextKey",
                revision_id="revisionId",
                package_digest="packageDigest",
                mount_path="mountPath",
                required=True,
            )
        ],
    )
    verify_request_count(test_id, "POST", "/v1/context-sets", None, 1)


def test_contextSets_resolve() -> None:
    """Test resolve endpoint with WireMock"""
    test_id = "context_sets.resolve.0"
    client = get_client(test_id)
    client.context_sets.resolve(
        context_set_id="contextSetId",
    )
    verify_request_count(test_id, "POST", "/v1/context-sets/contextSetId/resolve", None, 1)
