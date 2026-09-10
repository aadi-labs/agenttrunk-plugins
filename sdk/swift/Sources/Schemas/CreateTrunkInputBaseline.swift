import Foundation

/// Copy one authorized immutable context revision into the new workspace's staging environment. Copies verified files and current display metadata, not history, notes, permissions or production releases. The workspace name is reserved for this exact baseline; retry with identical inputs after a partial failure. Destination storage allowances apply. This is a snapshot copy, not a full Git repository fork.
public struct CreateTrunkInputBaseline: Codable, Hashable, Sendable {
    public let trunkId: String
    public let contextKey: String
    public let revisionId: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        trunkId: String,
        contextKey: String,
        revisionId: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.trunkId = trunkId
        self.contextKey = contextKey
        self.revisionId = revisionId
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trunkId = try container.decode(String.self, forKey: .trunkId)
        self.contextKey = try container.decode(String.self, forKey: .contextKey)
        self.revisionId = try container.decode(String.self, forKey: .revisionId)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.trunkId, forKey: .trunkId)
        try container.encode(self.contextKey, forKey: .contextKey)
        try container.encode(self.revisionId, forKey: .revisionId)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case trunkId
        case contextKey
        case revisionId
    }
}