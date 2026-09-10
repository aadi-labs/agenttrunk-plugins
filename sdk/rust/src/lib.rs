//! # AgentTrunk API SDK
//!
//! The official Rust SDK for the AgentTrunk API.
//!
//! ## Getting Started
//!
//! ```rust
//! use agenttrunk::prelude::*;
//!
//! #[tokio::main]
//! async fn main() {
//!     let config = ClientConfig {
//!         token: Some("<token>".to_string()),
//!         ..Default::default()
//!     };
//!     let client = AgentTrunk::new(config).expect("Failed to build client");
//!     client
//!         .privacy
//!         .assign_review(
//!             &"trunkId".to_string(),
//!             &"requestId".to_string(),
//!             &HashMap::from([("key".to_string(), serde_json::json!("value"))]),
//!             None,
//!         )
//!         .await;
//! }
//! ```
//!
//! ## Modules
//!
//! - [`api`] - Core API types and models
//! - [`client`] - Client implementations
//! - [`config`] - Configuration options
//! - [`core`] - Core utilities and infrastructure
//! - [`error`] - Error types and handling
//! - [`prelude`] - Common imports for convenience

pub mod api;
pub mod safety;
pub mod verified;
pub mod client;
pub mod config;
pub mod core;
pub mod environment;
pub mod error;
pub mod prelude;
pub mod agent_auth;

pub use api::*;
pub use client::*;
pub use config::*;
pub use core::*;
pub use environment::*;
pub use error::{ApiError, BuildError};
