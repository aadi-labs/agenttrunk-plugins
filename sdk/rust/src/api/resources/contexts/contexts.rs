use crate::api::*;
use crate::{ApiError, ByteStream, ClientConfig, HttpClient, QueryBuilder, RequestOptions};
use reqwest::Method;
use std::collections::HashMap;

pub struct ContextsClient {
    pub http_client: HttpClient,
}

impl ContextsClient {
    pub fn new(config: ClientConfig) -> Result<Self, ApiError> {
        Ok(Self {
            http_client: HttpClient::new(config.clone())?,
        })
    }

    /// Reads require current context authorization. Includes verified files encoded as base64 and metadata; excludes other history, notes, accounts, logs and backups. Not a complete personal-data export.
    ///
    /// # Arguments
    ///
    /// * `options` - Additional request options such as headers, timeout, etc.
    ///
    /// # Returns
    ///
    /// JSON response from the API
    ///
    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .contexts
    ///         .export(
    ///             &"trunkId".to_string(),
    ///             &"contextKey".to_string(),
    ///             &ExportQueryRequest {
    ///                 revision_id: "revisionId".to_string(),
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn export(
        &self,
        trunk_id: &str,
        context_key: &str,
        request: &ExportQueryRequest,
        options: Option<RequestOptions>,
    ) -> Result<HashMap<String, serde_json::Value>, ApiError> {
        self.http_client
            .execute_request(
                Method::GET,
                &format!("v1/trunks/{}/contexts/{}/export", crate::safety::path_param(trunk_id)?, crate::safety::path_param(context_key)?),
                None,
                QueryBuilder::new()
                    .string("revisionId", request.revision_id.clone())
                    .build(),
                options,
            )
            .await
    }

    /// Check whether an immutable revision can be restored to staging. This is advisory; the write rechecks permissions, release evidence, and staging concurrency. Ineligible responses do not expose the current staging revision.
    ///
    /// # Arguments
    ///
    /// * `options` - Additional request options such as headers, timeout, etc.
    ///
    /// # Returns
    ///
    /// JSON response from the API
    ///
    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .contexts
    ///         .get_rollback_plan(
    ///             &"trunkId".to_string(),
    ///             &"contextKey".to_string(),
    ///             &GetRollbackPlanQueryRequest {
    ///                 revision_id: "revisionId".to_string(),
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn get_rollback_plan(
        &self,
        trunk_id: &str,
        context_key: &str,
        request: &GetRollbackPlanQueryRequest,
        options: Option<RequestOptions>,
    ) -> Result<GetRollbackPlanContextsResponse, ApiError> {
        self.http_client
            .execute_request(
                Method::GET,
                &format!("v1/trunks/{}/contexts/{}/rollback", crate::safety::path_param(trunk_id)?, crate::safety::path_param(context_key)?),
                None,
                QueryBuilder::new()
                    .string("revisionId", request.revision_id.clone())
                    .build(),
                options,
            )
            .await
    }

    /// Restore a previously released immutable revision into staging. Requires production rollback and staging deploy permissions. Production only changes through a subsequent promotion PR.
    ///
    /// # Arguments
    ///
    /// * `options` - Additional request options such as headers, timeout, etc.
    ///
    /// # Returns
    ///
    /// JSON response from the API
    ///
    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .contexts
    ///         .stage_rollback(
    ///             &"trunkId".to_string(),
    ///             &"contextKey".to_string(),
    ///             &StageRollbackContextsRequest {
    ///                 revision_id: "revisionId".to_string(),
    ///                 expected_staging_revision_id: "expectedStagingRevisionId".to_string(),
    ///                 reason: "reason".to_string(),
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn stage_rollback(
        &self,
        trunk_id: &str,
        context_key: &str,
        request: &StageRollbackContextsRequest,
        options: Option<RequestOptions>,
    ) -> Result<HashMap<String, serde_json::Value>, ApiError> {
        self.http_client
            .execute_request(
                Method::POST,
                &format!("v1/trunks/{}/contexts/{}/rollback", crate::safety::path_param(trunk_id)?, crate::safety::path_param(context_key)?),
                Some(serde_json::to_value(request).map_err(ApiError::Serialization)?),
                None,
                options,
            )
            .await
    }

    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .contexts
    ///         .publish(
    ///             &"trunkId".to_string(),
    ///             &PublishInput {
    ///                 context_key: "contextKey".to_string(),
    ///                 title: "title".to_string(),
    ///                 kind: ContextKind::Skill,
    ///                 files: vec![FileInput {
    ///                     path: "path".to_string(),
    ///                     content_base64: "contentBase64".to_string(),
    ///                     ..Default::default()
    ///                 }],
    ///                 summary: None,
    ///                 tags: None,
    ///                 claimed_digest: None,
    ///                 scope_id: None,
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn publish(
        &self,
        trunk_id: &str,
        request: &PublishInput,
        options: Option<RequestOptions>,
    ) -> Result<PublishContextsResponse, ApiError> {
        self.http_client
            .execute_request(
                Method::POST,
                &format!("v1/trunks/{}/publications", crate::safety::path_param(trunk_id)?),
                Some(serde_json::to_value(request).map_err(ApiError::Serialization)?),
                None,
                options,
            )
            .await
    }

    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .contexts
    ///         .share(&"trunkId".to_string(), &"contextKey".to_string(), None)
    ///         .await;
    /// }
    /// ```
    pub async fn share(
        &self,
        trunk_id: &str,
        context_key: &str,
        options: Option<RequestOptions>,
    ) -> Result<HashMap<String, serde_json::Value>, ApiError> {
        self.http_client
            .execute_request(
                Method::POST,
                &format!("v1/trunks/{}/contexts/{}/share", crate::safety::path_param(trunk_id)?, crate::safety::path_param(context_key)?),
                None,
                None,
                options,
            )
            .await
    }

    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .contexts
    ///         .discover(
    ///             &DiscoverQueryRequest {
    ///                 ..Default::default()
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn discover(
        &self,
        request: &DiscoverQueryRequest,
        options: Option<RequestOptions>,
    ) -> Result<DiscoverContextsResponse, ApiError> {
        self.http_client
            .execute_request(
                Method::GET,
                "v1/contexts",
                None,
                QueryBuilder::new()
                    .string("scopeId", request.scope_id.clone())
                    .string("cursor", request.cursor.clone())
                    .string("trunkId", request.trunk_id.clone())
                    .structured_query("query", request.query.clone())
                    .serialize("channel", request.channel.clone())
                    .int("limit", request.limit.clone())
                    .build(),
                options,
            )
            .await
    }

    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .contexts
    ///         .inspect(
    ///             &"trunkId".to_string(),
    ///             &"contextKey".to_string(),
    ///             &InspectQueryRequest {
    ///                 ..Default::default()
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn inspect(
        &self,
        trunk_id: &str,
        context_key: &str,
        request: &InspectQueryRequest,
        options: Option<RequestOptions>,
    ) -> Result<InspectContextsResponse, ApiError> {
        self.http_client
            .execute_request(
                Method::GET,
                &format!("v1/trunks/{}/contexts/{}", crate::safety::path_param(trunk_id)?, crate::safety::path_param(context_key)?),
                None,
                QueryBuilder::new()
                    .string("ref", request.r#ref.clone())
                    .build(),
                options,
            )
            .await
    }

    /// Atomically add, replace, or delete files in staging, preserving metadata and unchanged files.
    /// Requires staging read and deployment permission. expectedRevisionId must equal the current
    /// staging revision. Concurrent branch changes return 409; reread and reconcile, never blindly
    /// retry. Production is unchanged. The resulting package retains the 256-file, 1 MB per-file,
    /// and 16 MB total limits and must not be empty. Each path may appear once. Deleting a missing
    /// file is invalid. Identical content is a no-op; restoring historical content uses rollback.
    ///
    /// # Arguments
    ///
    /// * `options` - Additional request options such as headers, timeout, etc.
    ///
    /// # Returns
    ///
    /// JSON response from the API
    ///
    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .contexts
    ///         .edit(
    ///             &"trunkId".to_string(),
    ///             &"contextKey".to_string(),
    ///             &EditContextInput {
    ///                 expected_revision_id: "expectedRevisionId".to_string(),
    ///                 changes: vec![EditContextInputChangesItem::Put {
    ///                     data: EditContextInputChangesItemPut {
    ///                         path: "path".to_string(),
    ///                         content_base64: "contentBase64".to_string(),
    ///                         ..Default::default()
    ///                     },
    ///                 }],
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn edit(
        &self,
        trunk_id: &str,
        context_key: &str,
        request: &EditContextInput,
        options: Option<RequestOptions>,
    ) -> Result<EditContextsResponse, ApiError> {
        self.http_client
            .execute_request(
                Method::PATCH,
                &format!("v1/trunks/{}/contexts/{}", crate::safety::path_param(trunk_id)?, crate::safety::path_param(context_key)?),
                Some(serde_json::to_value(request).map_err(ApiError::Serialization)?),
                None,
                options,
            )
            .await
    }

    /// Follows immutable parent revisions, authorizing every revision. Historic IDs require staging read or shared-context-item read access.
    ///
    /// # Arguments
    ///
    /// * `options` - Additional request options such as headers, timeout, etc.
    ///
    /// # Returns
    ///
    /// JSON response from the API
    ///
    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .contexts
    ///         .history(
    ///             &"trunkId".to_string(),
    ///             &"contextKey".to_string(),
    ///             &HistoryQueryRequest {
    ///                 ..Default::default()
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn history(
        &self,
        trunk_id: &str,
        context_key: &str,
        request: &HistoryQueryRequest,
        options: Option<RequestOptions>,
    ) -> Result<HistoryContextsResponse, ApiError> {
        self.http_client
            .execute_request(
                Method::GET,
                &format!("v1/trunks/{}/contexts/{}/history", crate::safety::path_param(trunk_id)?, crate::safety::path_param(context_key)?),
                None,
                QueryBuilder::new()
                    .string("from", request.from.clone())
                    .int("limit", request.limit.clone())
                    .build(),
                options,
            )
            .await
    }

    /// Authorizes both revisions and returns their manifests, per-file statuses,
    /// and one selected file preview. Target defaults to latest; base defaults to
    /// the target's parent, or an empty snapshot for the first revision. The
    /// returned IDs are immutable; use them for subsequent file selections.
    /// UTF-8 previews verify file digests and are capped at 128000 bytes per side.
    /// reason is null, too_large, binary, or too_complex. Omitted previews have
    /// empty content and zero counts, which must not be displayed as no changes.
    ///
    /// # Arguments
    ///
    /// * `options` - Additional request options such as headers, timeout, etc.
    ///
    /// # Returns
    ///
    /// JSON response from the API
    ///
    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .contexts
    ///         .compare(
    ///             &"trunkId".to_string(),
    ///             &"contextKey".to_string(),
    ///             &CompareQueryRequest {
    ///                 ..Default::default()
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn compare(
        &self,
        trunk_id: &str,
        context_key: &str,
        request: &CompareQueryRequest,
        options: Option<RequestOptions>,
    ) -> Result<HashMap<String, serde_json::Value>, ApiError> {
        self.http_client
            .execute_request(
                Method::GET,
                &format!("v1/trunks/{}/contexts/{}/compare", crate::safety::path_param(trunk_id)?, crate::safety::path_param(context_key)?),
                None,
                QueryBuilder::new()
                    .string("base", request.base.clone())
                    .string("target", request.target.clone())
                    .string("path", request.path.clone())
                    .build(),
                options,
            )
            .await
    }

    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .contexts
    ///         .get_provenance(
    ///             &"trunkId".to_string(),
    ///             &"contextKey".to_string(),
    ///             &GetProvenanceQueryRequest {
    ///                 ..Default::default()
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn get_provenance(
        &self,
        trunk_id: &str,
        context_key: &str,
        request: &GetProvenanceQueryRequest,
        options: Option<RequestOptions>,
    ) -> Result<HashMap<String, serde_json::Value>, ApiError> {
        self.http_client
            .execute_request(
                Method::GET,
                &format!("v1/trunks/{}/contexts/{}/provenance", crate::safety::path_param(trunk_id)?, crate::safety::path_param(context_key)?),
                None,
                QueryBuilder::new()
                    .string("ref", request.r#ref.clone())
                    .build(),
                options,
            )
            .await
    }

    /// Requires revision read and staging environment deployment permission. Author identity is assigned server-side. Does not modify content, channels, or PR approval. Concurrent updates return 409; reread and reconcile, never blindly retry with a newer token.
    ///
    /// # Arguments
    ///
    /// * `options` - Additional request options such as headers, timeout, etc.
    ///
    /// # Returns
    ///
    /// JSON response from the API
    ///
    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .contexts
    ///         .put_provenance(
    ///             &"trunkId".to_string(),
    ///             &"contextKey".to_string(),
    ///             &PutProvenanceContextsRequest {
    ///                 revision_id: "revisionId".to_string(),
    ///                 text: "text".to_string(),
    ///                 expected_notes_commit_sha: None,
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn put_provenance(
        &self,
        trunk_id: &str,
        context_key: &str,
        request: &PutProvenanceContextsRequest,
        options: Option<RequestOptions>,
    ) -> Result<HashMap<String, serde_json::Value>, ApiError> {
        self.http_client
            .execute_request(
                Method::PUT,
                &format!("v1/trunks/{}/contexts/{}/provenance", crate::safety::path_param(trunk_id)?, crate::safety::path_param(context_key)?),
                Some(serde_json::to_value(request).map_err(ApiError::Serialization)?),
                None,
                options,
            )
            .await
    }

    /// # Examples
    ///
    /// ```no_run
    /// use agenttrunk::prelude::*;
    ///
    /// #[tokio::main]
    /// async fn main() {
    ///     let config = ClientConfig {
    ///         token: Some("<token>".to_string()),
    ///         ..Default::default()
    ///     };
    ///     let client = AgentTrunk::new(config).expect("Failed to build client");
    ///     client
    ///         .contexts
    ///         .read_file(
    ///             &"trunkId".to_string(),
    ///             &"contextKey".to_string(),
    ///             &"resourcePath".to_string(),
    ///             &ReadFileQueryRequest {
    ///                 r#ref: "ref".to_string(),
    ///             },
    ///             None,
    ///         )
    ///         .await;
    /// }
    /// ```
    pub async fn read_file(
        &self,
        trunk_id: &str,
        context_key: &str,
        resource_path: &str,
        request: &ReadFileQueryRequest,
        options: Option<RequestOptions>,
    ) -> Result<ByteStream, ApiError> {
        self.http_client
            .execute_stream_request(
                Method::GET,
                &format!("v1/trunks/{}/contexts/{}/files/{}", crate::safety::path_param(trunk_id)?, crate::safety::path_param(context_key)?, crate::safety::path_param(resource_path)?),
                None,
                QueryBuilder::new()
                    .string("ref", request.r#ref.clone())
                    .build(),
                options,
            )
            .await
    }
}
