pub use crate::prelude::*;

#[non_exhaustive]
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum ContextKind {
    Skill,
    Docs,
    Prompt,
    Policy,
    MemorySchema,
    /// This variant is used for forward compatibility.
    /// If the server sends a value not recognized by the current SDK version,
    /// it will be captured here with the raw string value.
    __Unknown(String),
}
impl Serialize for ContextKind {
    fn serialize<S: serde::Serializer>(&self, serializer: S) -> Result<S::Ok, S::Error> {
        match self {
            Self::Skill => serializer.serialize_str("skill"),
            Self::Docs => serializer.serialize_str("docs"),
            Self::Prompt => serializer.serialize_str("prompt"),
            Self::Policy => serializer.serialize_str("policy"),
            Self::MemorySchema => serializer.serialize_str("memory-schema"),
            Self::__Unknown(val) => serializer.serialize_str(val),
        }
    }
}

impl<'de> Deserialize<'de> for ContextKind {
    fn deserialize<D: serde::Deserializer<'de>>(deserializer: D) -> Result<Self, D::Error> {
        let value = String::deserialize(deserializer)?;
        match value.as_str() {
            "skill" => Ok(Self::Skill),
            "docs" => Ok(Self::Docs),
            "prompt" => Ok(Self::Prompt),
            "policy" => Ok(Self::Policy),
            "memory-schema" => Ok(Self::MemorySchema),
            _ => Ok(Self::__Unknown(value)),
        }
    }
}

impl fmt::Display for ContextKind {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Skill => write!(f, "skill"),
            Self::Docs => write!(f, "docs"),
            Self::Prompt => write!(f, "prompt"),
            Self::Policy => write!(f, "policy"),
            Self::MemorySchema => write!(f, "memory-schema"),
            Self::__Unknown(val) => write!(f, "{}", val),
        }
    }
}
