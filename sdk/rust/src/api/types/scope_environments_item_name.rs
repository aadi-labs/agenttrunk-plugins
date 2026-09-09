pub use crate::prelude::*;

#[non_exhaustive]
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum ScopeEnvironmentsItemName {
    Staging,
    Production,
    /// This variant is used for forward compatibility.
    /// If the server sends a value not recognized by the current SDK version,
    /// it will be captured here with the raw string value.
    __Unknown(String),
}
impl Serialize for ScopeEnvironmentsItemName {
    fn serialize<S: serde::Serializer>(&self, serializer: S) -> Result<S::Ok, S::Error> {
        match self {
            Self::Staging => serializer.serialize_str("staging"),
            Self::Production => serializer.serialize_str("production"),
            Self::__Unknown(val) => serializer.serialize_str(val),
        }
    }
}

impl<'de> Deserialize<'de> for ScopeEnvironmentsItemName {
    fn deserialize<D: serde::Deserializer<'de>>(deserializer: D) -> Result<Self, D::Error> {
        let value = String::deserialize(deserializer)?;
        match value.as_str() {
            "staging" => Ok(Self::Staging),
            "production" => Ok(Self::Production),
            _ => Ok(Self::__Unknown(value)),
        }
    }
}

impl fmt::Display for ScopeEnvironmentsItemName {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Staging => write!(f, "staging"),
            Self::Production => write!(f, "production"),
            Self::__Unknown(val) => write!(f, "{}", val),
        }
    }
}
