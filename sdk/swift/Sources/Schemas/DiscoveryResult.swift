import Foundation

public struct DiscoveryResult: Codable, Hashable, Sendable {
    public let trunkId: String
    public let scopeId: String
    public let contextKey: String
    public let title: String
    public let kind: ContextKind
    public let summary: String
    public let tags: [String]
    public let revisionId: String
    public let packageDigest: String
    public let channel: DiscoveryResultChannel
    public let updatedAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        trunkId: String,
        scopeId: String,
        contextKey: String,
        title: String,
        kind: ContextKind,
        summary: String,
        tags: [String],
        revisionId: String,
        packageDigest: String,
        channel: DiscoveryResultChannel,
        updatedAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.trunkId = trunkId
        self.scopeId = scopeId
        self.contextKey = contextKey
        self.title = title
        self.kind = kind
        self.summary = summary
        self.tags = tags
        self.revisionId = revisionId
        self.packageDigest = packageDigest
        self.channel = channel
        self.updatedAt = updatedAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trunkId = try container.decode(String.self, forKey: .trunkId)
        self.scopeId = try container.decode(String.self, forKey: .scopeId)
        self.contextKey = try container.decode(String.self, forKey: .contextKey)
        self.title = try container.decode(String.self, forKey: .title)
        self.kind = try container.decode(ContextKind.self, forKey: .kind)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.revisionId = try container.decode(String.self, forKey: .revisionId)
        self.packageDigest = try container.decode(String.self, forKey: .packageDigest)
        self.channel = try container.decode(DiscoveryResultChannel.self, forKey: .channel)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.trunkId, forKey: .trunkId)
        try container.encode(self.scopeId, forKey: .scopeId)
        try container.encode(self.contextKey, forKey: .contextKey)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.kind, forKey: .kind)
        try container.encode(self.summary, forKey: .summary)
        try container.encode(self.tags, forKey: .tags)
        try container.encode(self.revisionId, forKey: .revisionId)
        try container.encode(self.packageDigest, forKey: .packageDigest)
        try container.encode(self.channel, forKey: .channel)
        try container.encode(self.updatedAt, forKey: .updatedAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case trunkId
        case scopeId
        case contextKey
        case title
        case kind
        case summary
        case tags
        case revisionId
        case packageDigest
        case channel
        case updatedAt
    }
}