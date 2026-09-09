use agenttrunk::prelude::*;

mod wire_test_utils;

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_context_sets_sources_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .context_sets
        .sources(
            &SourcesQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count("GET", "/v1/context-sources", None, 1)
        .await
        .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_context_sets_list_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .context_sets
        .list(
            &ContextSetsListQueryRequest {
                ..Default::default()
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count("GET", "/v1/context-sets", None, 1)
        .await
        .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_context_sets_create_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .context_sets
        .create(
            &CreateContextSetsRequest {
                name: "name".to_string(),
                sources: vec![ContextSetSource {
                    source_trunk_id: "sourceTrunkId".to_string(),
                    source_scope_id: "sourceScopeId".to_string(),
                    environment_id: "environmentId".to_string(),
                    context_key: "contextKey".to_string(),
                    revision_id: "revisionId".to_string(),
                    package_digest: "packageDigest".to_string(),
                    mount_path: "mountPath".to_string(),
                    required: true,
                    ..Default::default()
                }],
            },
            None,
        )
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count("POST", "/v1/context-sets", None, 1)
        .await
        .unwrap();
}

#[tokio::test]
#[allow(unused_variables, unreachable_code)]
async fn test_context_sets_resolve_with_wiremock() {
    wire_test_utils::reset_wiremock_requests().await.unwrap();
    let wiremock_base_url = wire_test_utils::get_wiremock_base_url();

    let mut config = ClientConfig {
        token: Some("<token>".to_string()),
        ..Default::default()
    };
    config.base_url = wiremock_base_url.to_string();
    let client = AgentTrunk::new(config).expect("Failed to build client");

    let result = client
        .context_sets
        .resolve(&"contextSetId".to_string(), None)
        .await;

    assert!(result.is_ok(), "Client method call should succeed");

    wire_test_utils::verify_request_count("POST", "/v1/context-sets/contextSetId/resolve", None, 1)
        .await
        .unwrap();
}
