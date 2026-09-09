import Foundation

public struct Context: Codable, Hashable, Sendable {
    public let id: String
    public let trunkId: String
    public let scopeId: String
    public let key: String
    public let title: String
    public let kind: ContextKind
    public let summary: String
    public let tags: [String]
    public let createdAt: Date
    public let updatedAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: String,
        trunkId: String,
        scopeId: String,
        key: String,
        title: String,
        kind: ContextKind,
        summary: String,
        tags: [String],
        createdAt: Date,
        updatedAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.trunkId = trunkId
        self.scopeId = scopeId
        self.key = key
        self.title = title
        self.kind = kind
        self.summary = summary
        self.tags = tags
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.trunkId = try container.decode(String.self, forKey: .trunkId)
        self.scopeId = try container.decode(String.self, forKey: .scopeId)
        self.key = try container.decode(String.self, forKey: .key)
        self.title = try container.decode(String.self, forKey: .title)
        self.kind = try container.decode(ContextKind.self, forKey: .kind)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.trunkId, forKey: .trunkId)
        try container.encode(self.scopeId, forKey: .scopeId)
        try container.encode(self.key, forKey: .key)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.kind, forKey: .kind)
        try container.encode(self.summary, forKey: .summary)
        try container.encode(self.tags, forKey: .tags)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.updatedAt, forKey: .updatedAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case trunkId
        case scopeId
        case key
        case title
        case kind
        case summary
        case tags
        case createdAt
        case updatedAt
    }
}