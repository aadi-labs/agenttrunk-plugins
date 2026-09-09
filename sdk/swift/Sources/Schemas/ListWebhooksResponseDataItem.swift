import Foundation

public struct ListWebhooksResponseDataItem: Codable, Hashable, Sendable {
    public let sequence: String?
    public let eventId: String?
    public let status: ListWebhooksResponseDataItemStatus?
    public let attempts: Int?
    public let lastError: Nullable<String>?
    public let svixMessageId: Nullable<String>?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        sequence: String? = nil,
        eventId: String? = nil,
        status: ListWebhooksResponseDataItemStatus? = nil,
        attempts: Int? = nil,
        lastError: Nullable<String>? = nil,
        svixMessageId: Nullable<String>? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.sequence = sequence
        self.eventId = eventId
        self.status = status
        self.attempts = attempts
        self.lastError = lastError
        self.svixMessageId = svixMessageId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sequence = try container.decodeIfPresent(String.self, forKey: .sequence)
        self.eventId = try container.decodeIfPresent(String.self, forKey: .eventId)
        self.status = try container.decodeIfPresent(ListWebhooksResponseDataItemStatus.self, forKey: .status)
        self.attempts = try container.decodeIfPresent(Int.self, forKey: .attempts)
        self.lastError = try container.decodeNullableIfPresent(String.self, forKey: .lastError)
        self.svixMessageId = try container.decodeNullableIfPresent(String.self, forKey: .svixMessageId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.sequence, forKey: .sequence)
        try container.encodeIfPresent(self.eventId, forKey: .eventId)
        try container.encodeIfPresent(self.status, forKey: .status)
        try container.encodeIfPresent(self.attempts, forKey: .attempts)
        try container.encodeNullableIfPresent(self.lastError, forKey: .lastError)
        try container.encodeNullableIfPresent(self.svixMessageId, forKey: .svixMessageId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case sequence
        case eventId
        case status
        case attempts
        case lastError
        case svixMessageId
    }
}