//! Service clients and API endpoints
//!
//! This module contains client implementations for:
//!
//! - **Privacy**
//! - **Contexts**
//! - **Billing**
//! - **Health**
//! - **Workspaces**
//! - **Webhooks**
//! - **Scopes**
//! - **ContextSets**
//! - **Releases**

use crate::{ApiError, ClientConfig};

pub mod billing;
pub mod context_sets;
pub mod contexts;
pub mod health;
pub mod privacy;
pub mod releases;
pub mod scopes;
pub mod webhooks;
pub mod workspaces;
pub struct AgentTrunk {
    pub config: ClientConfig,
    pub privacy: PrivacyClient,
    pub contexts: ContextsClient,
    pub billing: BillingClient,
    pub health: HealthClient,
    pub workspaces: WorkspacesClient,
    pub webhooks: WebhooksClient,
    pub scopes: ScopesClient,
    pub context_sets: ContextSetsClient,
    pub releases: ReleasesClient,
}

impl AgentTrunk {
    pub fn new(config: ClientConfig) -> Result<Self, ApiError> {
        Ok(Self {
            config: config.clone(),
            privacy: PrivacyClient::new(config.clone())?,
            contexts: ContextsClient::new(config.clone())?,
            billing: BillingClient::new(config.clone())?,
            health: HealthClient::new(config.clone())?,
            workspaces: WorkspacesClient::new(config.clone())?,
            webhooks: WebhooksClient::new(config.clone())?,
            scopes: ScopesClient::new(config.clone())?,
            context_sets: ContextSetsClient::new(config.clone())?,
            releases: ReleasesClient::new(config.clone())?,
        })
    }
}

pub use billing::BillingClient;
pub use context_sets::ContextSetsClient;
pub use contexts::ContextsClient;
pub use health::HealthClient;
pub use privacy::PrivacyClient;
pub use releases::ReleasesClient;
pub use scopes::ScopesClient;
pub use webhooks::WebhooksClient;
pub use workspaces::WorkspacesClient;
