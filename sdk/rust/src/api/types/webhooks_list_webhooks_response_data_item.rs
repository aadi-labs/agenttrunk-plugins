pub use crate::prelude::*;

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, Eq, Hash)]
pub struct ListWebhooksResponseDataItem {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub sequence: Option<String>,
    #[serde(rename = "eventId")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub event_id: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub status: Option<ListWebhooksResponseDataItemStatus>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub attempts: Option<i64>,
    #[serde(rename = "lastError")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub last_error: Option<String>,
    #[serde(rename = "svixMessageId")]
    #[serde(skip_serializing_if = "Option::is_none")]
    pub svix_message_id: Option<String>,
}

impl ListWebhooksResponseDataItem {
    pub fn builder() -> ListWebhooksResponseDataItemBuilder {
        <ListWebhooksResponseDataItemBuilder as Default>::default()
    }
}

#[derive(Clone, PartialEq, Default, Debug)]
#[non_exhaustive]
pub struct ListWebhooksResponseDataItemBuilder {
    sequence: Option<String>,
    event_id: Option<String>,
    status: Option<ListWebhooksResponseDataItemStatus>,
    attempts: Option<i64>,
    last_error: Option<String>,
    svix_message_id: Option<String>,
}

impl ListWebhooksResponseDataItemBuilder {
    pub fn sequence(mut self, value: impl Into<String>) -> Self {
        self.sequence = Some(value.into());
        self
    }

    pub fn event_id(mut self, value: impl Into<String>) -> Self {
        self.event_id = Some(value.into());
        self
    }

    pub fn status(mut self, value: ListWebhooksResponseDataItemStatus) -> Self {
        self.status = Some(value);
        self
    }

    pub fn attempts(mut self, value: i64) -> Self {
        self.attempts = Some(value);
        self
    }

    pub fn last_error(mut self, value: impl Into<String>) -> Self {
        self.last_error = Some(value.into());
        self
    }

    pub fn svix_message_id(mut self, value: impl Into<String>) -> Self {
        self.svix_message_id = Some(value.into());
        self
    }

    /// Consumes the builder and constructs a [`ListWebhooksResponseDataItem`].
    pub fn build(self) -> Result<ListWebhooksResponseDataItem, BuildError> {
        Ok(ListWebhooksResponseDataItem {
            sequence: self.sequence,
            event_id: self.event_id,
            status: self.status,
            attempts: self.attempts,
            last_error: self.last_error,
            svix_message_id: self.svix_message_id,
        })
    }
}
