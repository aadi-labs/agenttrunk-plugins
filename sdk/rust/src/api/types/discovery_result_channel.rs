pub use crate::prelude::*;

#[non_exhaustive]
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum DiscoveryResultChannel {
    Production,
    Staging,
    Latest,
    /// This variant is used for forward compatibility.
    /// If the server sends a value not recognized by the current SDK version,
    /// it will be captured here with the raw string value.
    __Unknown(String),
}
impl Serialize for DiscoveryResultChannel {
    fn serialize<S: serde::Serializer>(&self, serializer: S) -> Result<S::Ok, S::Error> {
        match self {
            Self::Production => serializer.serialize_str("production"),
            Self::Staging => serializer.serialize_str("staging"),
            Self::Latest => serializer.serialize_str("latest"),
            Self::__Unknown(val) => serializer.serialize_str(val),
        }
    }
}

impl<'de> Deserialize<'de> for DiscoveryResultChannel {
    fn deserialize<D: serde::Deserializer<'de>>(deserializer: D) -> Result<Self, D::Error> {
        let value = String::deserialize(deserializer)?;
        match value.as_str() {
            "production" => Ok(Self::Production),
            "staging" => Ok(Self::Staging),
            "latest" => Ok(Self::Latest),
            _ => Ok(Self::__Unknown(value)),
        }
    }
}

impl fmt::Display for DiscoveryResultChannel {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Production => write!(f, "production"),
            Self::Staging => write!(f, "staging"),
            Self::Latest => write!(f, "latest"),
            Self::__Unknown(val) => write!(f, "{}", val),
        }
    }
}
