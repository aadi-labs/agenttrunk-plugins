from .conftest import get_client, verify_request_count

from agenttrunk import FileInput


def test_contexts_export() -> None:
    """Test export endpoint with WireMock"""
    test_id = "contexts.export.0"
    client = get_client(test_id)
    client.contexts.export(
        trunk_id="trunkId",
        context_key="contextKey",
        revision_id="revisionId",
    )
    verify_request_count(
        test_id, "GET", "/v1/trunks/trunkId/contexts/contextKey/export", {"revisionId": "revisionId"}, 1
    )


def test_contexts_get_rollback_plan() -> None:
    """Test getRollbackPlan endpoint with WireMock"""
    test_id = "contexts.get_rollback_plan.0"
    client = get_client(test_id)
    client.contexts.get_rollback_plan(
        trunk_id="trunkId",
        context_key="contextKey",
        revision_id="revisionId",
    )
    verify_request_count(
        test_id, "GET", "/v1/trunks/trunkId/contexts/contextKey/rollback", {"revisionId": "revisionId"}, 1
    )


def test_contexts_stage_rollback() -> None:
    """Test stageRollback endpoint with WireMock"""
    test_id = "contexts.stage_rollback.0"
    client = get_client(test_id)
    client.contexts.stage_rollback(
        trunk_id="trunkId",
        context_key="contextKey",
        revision_id="revisionId",
        expected_staging_revision_id="expectedStagingRevisionId",
        reason="reason",
    )
    verify_request_count(test_id, "POST", "/v1/trunks/trunkId/contexts/contextKey/rollback", None, 1)


def test_contexts_publish() -> None:
    """Test publish endpoint with WireMock"""
    test_id = "contexts.publish.0"
    client = get_client(test_id)
    client.contexts.publish(
        trunk_id="trunkId",
        context_key="contextKey",
        title="title",
        kind="skill",
        files=[
            FileInput(
                path="path",
                content_base64="contentBase64",
            )
        ],
    )
    verify_request_count(test_id, "POST", "/v1/trunks/trunkId/publications", None, 1)


def test_contexts_share() -> None:
    """Test share endpoint with WireMock"""
    test_id = "contexts.share.0"
    client = get_client(test_id)
    client.contexts.share(
        trunk_id="trunkId",
        context_key="contextKey",
    )
    verify_request_count(test_id, "POST", "/v1/trunks/trunkId/contexts/contextKey/share", None, 1)


def test_contexts_discover() -> None:
    """Test discover endpoint with WireMock"""
    test_id = "contexts.discover.0"
    client = get_client(test_id)
    client.contexts.discover()
    verify_request_count(test_id, "GET", "/v1/contexts", None, 1)


def test_contexts_inspect() -> None:
    """Test inspect endpoint with WireMock"""
    test_id = "contexts.inspect.0"
    client = get_client(test_id)
    client.contexts.inspect(
        trunk_id="trunkId",
        context_key="contextKey",
    )
    verify_request_count(test_id, "GET", "/v1/trunks/trunkId/contexts/contextKey", None, 1)


def test_contexts_history() -> None:
    """Test history endpoint with WireMock"""
    test_id = "contexts.history.0"
    client = get_client(test_id)
    client.contexts.history(
        trunk_id="trunkId",
        context_key="contextKey",
    )
    verify_request_count(test_id, "GET", "/v1/trunks/trunkId/contexts/contextKey/history", None, 1)


def test_contexts_compare() -> None:
    """Test compare endpoint with WireMock"""
    test_id = "contexts.compare.0"
    client = get_client(test_id)
    client.contexts.compare(
        trunk_id="trunkId",
        context_key="contextKey",
    )
    verify_request_count(test_id, "GET", "/v1/trunks/trunkId/contexts/contextKey/compare", None, 1)


def test_contexts_get_provenance() -> None:
    """Test getProvenance endpoint with WireMock"""
    test_id = "contexts.get_provenance.0"
    client = get_client(test_id)
    client.contexts.get_provenance(
        trunk_id="trunkId",
        context_key="contextKey",
    )
    verify_request_count(test_id, "GET", "/v1/trunks/trunkId/contexts/contextKey/provenance", None, 1)


def test_contexts_put_provenance() -> None:
    """Test putProvenance endpoint with WireMock"""
    test_id = "contexts.put_provenance.0"
    client = get_client(test_id)
    client.contexts.put_provenance(
        trunk_id="trunkId",
        context_key="contextKey",
        revision_id="revisionId",
        text="text",
    )
    verify_request_count(test_id, "PUT", "/v1/trunks/trunkId/contexts/contextKey/provenance", None, 1)


def test_contexts_read_file() -> None:
    """Test readFile endpoint with WireMock"""
    test_id = "contexts.read_file.0"
    client = get_client(test_id)
    for _ in client.contexts.read_file(
        trunk_id="trunkId",
        context_key="contextKey",
        resource_path="resourcePath",
        ref="ref",
    ):
        pass
    verify_request_count(test_id, "GET", "/v1/trunks/trunkId/contexts/contextKey/files/resourcePath", {"ref": "ref"}, 1)
