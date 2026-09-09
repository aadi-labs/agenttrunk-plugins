pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct PublishContextsResponse {
    pub context: Context,
    #[serde(default)]
    pub revision: Revision,
}

impl PublishContextsResponse {
    pub fn builder() -> PublishContextsResponseBuilder {
        <PublishContextsResponseBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct PublishContextsResponseBuilder {
    context: Option<Context>,
    revision: Option<Revision>,
}

impl PublishContextsResponseBuilder {
    pub fn context(mut self, value: Context) -> Self {
        self.context = Some(value);
        self
    }

    pub fn revision(mut self, value: Revision) -> Self {
        self.revision = Some(value);
        self
    }

    /// Consumes the builder and constructs a [`PublishContextsResponse`].
    /// This method will fail if any of the following fields are not set:
    /// - [`context`](PublishContextsResponseBuilder::context)
    /// - [`revision`](PublishContextsResponseBuilder::revision)
    pub fn build(self) -> Result<PublishContextsResponse, BuildError> {
        Ok(PublishContextsResponse {
            context: self
                .context
                .ok_or_else(|| BuildError::missing_field("context"))?,
            revision: self
                .revision
                .ok_or_else(|| BuildError::missing_field("revision"))?,
        })
    }
}
