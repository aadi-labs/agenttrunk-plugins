use agenttrunk::prelude::*;

mod wire_test_utils;

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_contexts_export_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .contexts
        .export(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &ExportQueryRequest {
                revision_id: "revisionId".to_string(),
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count(
        "GET",
        "/v1/trunks/trunkId/contexts/contextKey/export",
        Some(HashMap::from([(
            "revisionId".to_string(),
            json!("revisionId"),
        )])),
        1,
    )
    .await
    .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_contexts_get_rollback_plan_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .contexts
        .get_rollback_plan(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &GetRollbackPlanQueryRequest {
                revision_id: "revisionId".to_string(),
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count(
        "GET",
        "/v1/trunks/trunkId/contexts/contextKey/rollback",
        Some(HashMap::from([(
            "revisionId".to_string(),
            json!("revisionId"),
        )])),
        1,
    )
    .await
    .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_contexts_stage_rollback_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .contexts
        .stage_rollback(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &StageRollbackContextsRequest {
                revision_id: "revisionId".to_string(),
                expected_staging_revision_id: "expectedStagingRevisionId".to_string(),
                reason: "reason".to_string(),
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count(
        "POST",
        "/v1/trunks/trunkId/contexts/contextKey/rollback",
        None,
        1,
    )
    .await
    .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_contexts_publish_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .contexts
        .publish(
            &"trunkId".to_string(),
            &PublishInput {
                context_key: "contextKey".to_string(),
                title: "title".to_string(),
                kind: ContextKind::Skill,
                files: vec![FileInput {
                    path: "path".to_string(),
                    content_base64: "contentBase64".to_string(),
                    ..Default::default()
                }],
                summary: None,
                tags: None,
                claimed_digest: None,
                scope_id: None,
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count("POST", "/v1/trunks/trunkId/publications", None, 1)
        .await
        .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_contexts_share_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .contexts
        .share(&"trunkId".to_string(), &"contextKey".to_string(), None)
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count(
        "POST",
        "/v1/trunks/trunkId/contexts/contextKey/share",
        None,
        1,
    )
    .await
    .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_contexts_discover_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .contexts
        .discover(
            &DiscoverQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count("GET", "/v1/contexts", None, 1)
        .await
        .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_contexts_inspect_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .contexts
        .inspect(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &InspectQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count("GET", "/v1/trunks/trunkId/contexts/contextKey", None, 1)
        .await
        .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_contexts_edit_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .contexts
        .edit(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &EditContextInput {
                expected_revision_id: "expectedRevisionId".to_string(),
                changes: vec![EditContextInputChangesItem::Put {
                    data: EditContextInputChangesItemPut {
                        path: "path".to_string(),
                        content_base64: "contentBase64".to_string(),
                        ..Default::default()
                    },
                }],
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count(
        "PATCH",
        "/v1/trunks/trunkId/contexts/contextKey",
        None,
        1,
    )
    .await
    .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_contexts_history_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .contexts
        .history(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &HistoryQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count(
        "GET",
        "/v1/trunks/trunkId/contexts/contextKey/history",
        None,
        1,
    )
    .await
    .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_contexts_compare_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .contexts
        .compare(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &CompareQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count(
        "GET",
        "/v1/trunks/trunkId/contexts/contextKey/compare",
        None,
        1,
    )
    .await
    .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_contexts_get_provenance_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .contexts
        .get_provenance(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &GetProvenanceQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count(
        "GET",
        "/v1/trunks/trunkId/contexts/contextKey/provenance",
        None,
        1,
    )
    .await
    .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_contexts_put_provenance_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .contexts
        .put_provenance(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &PutProvenanceContextsRequest {
                revision_id: "revisionId".to_string(),
                text: "text".to_string(),
                expected_notes_commit_sha: None,
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count(
        "PUT",
        "/v1/trunks/trunkId/contexts/contextKey/provenance",
        None,
        1,
    )
    .await
    .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_contexts_read_file_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .contexts
        .read_file(
            &"trunkId".to_string(),
            &"contextKey".to_string(),
            &"resourcePath".to_string(),
            &ReadFileQueryRequest {
                r#ref: "ref".to_string(),
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count(
        "GET",
        "/v1/trunks/trunkId/contexts/contextKey/files/resourcePath",
        Some(HashMap::from([("ref".to_string(), json!("ref"))])),
        1,
    )
    .await
    .unwrap();
}
