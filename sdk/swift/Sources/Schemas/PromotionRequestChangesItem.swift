import Foundation

public struct PromotionRequestChangesItem: Codable, Hashable, Sendable {
    public let contextId: String
    public let contextKey: String
    public let sourceRevisionId: String
    public let targetRevisionId: Nullable<String>
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        contextId: String,
        contextKey: String,
        sourceRevisionId: String,
        targetRevisionId: Nullable<String>,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.contextId = contextId
        self.contextKey = contextKey
        self.sourceRevisionId = sourceRevisionId
        self.targetRevisionId = targetRevisionId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contextId = try container.decode(String.self, forKey: .contextId)
        self.contextKey = try container.decode(String.self, forKey: .contextKey)
        self.sourceRevisionId = try container.decode(String.self, forKey: .sourceRevisionId)
        self.targetRevisionId = try container.decode(Nullable<String>.self, forKey: .targetRevisionId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.contextId, forKey: .contextId)
        try container.encode(self.contextKey, forKey: .contextKey)
        try container.encode(self.sourceRevisionId, forKey: .sourceRevisionId)
        try container.encode(self.targetRevisionId, forKey: .targetRevisionId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case contextId
        case contextKey
        case sourceRevisionId
        case targetRevisionId
    }
}