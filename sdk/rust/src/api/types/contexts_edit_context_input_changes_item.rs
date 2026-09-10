pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
#[serde(tag = "operation")]
#[non_exhaustive]
pub enum EditContextInputChangesItem {
    #[serde(rename = "put")]
    #[non_exhaustive]
    Put {
        #[serde(default)]
        path: String,
        #[serde(rename = "contentBase64")]
        #[serde(default)]
        content_base64: String,
    },

    #[serde(rename = "delete")]
    #[non_exhaustive]
    Delete {
        #[serde(default)]
        path: String,
    },

    /// Catch-all variant for unrecognized discriminant values.
    /// If the server sends a discriminant not recognized by the current SDK
    /// version, the raw payload is captured here so callers can still inspect it.
    #[serde(untagged)]
    __Unknown(serde_json::Value),
}

impl EditContextInputChangesItem {
    pub fn put(path: String, content_base64: String) -> Self {
        Self::Put {
            path,
            content_base64,
        }
    }

    pub fn delete(path: String) -> Self {
        Self::Delete { path }
    }

    pub fn unknown(value: serde_json::Value) -> Self {
        Self::__Unknown(value)
    }
}
