import Foundation

public struct Scope: Codable, Hashable, Sendable {
    public let canCreateScope: Bool?
    public let id: String
    public let name: String
    public let slug: String
    public let createdBy: String
    public let createdAt: Date
    public let environments: [ScopeEnvironmentsItem]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        canCreateScope: Bool? = nil,
        id: String,
        name: String,
        slug: String,
        createdBy: String,
        createdAt: Date,
        environments: [ScopeEnvironmentsItem],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.canCreateScope = canCreateScope
        self.id = id
        self.name = name
        self.slug = slug
        self.createdBy = createdBy
        self.createdAt = createdAt
        self.environments = environments
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.canCreateScope = try container.decodeIfPresent(Bool.self, forKey: .canCreateScope)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.createdBy = try container.decode(String.self, forKey: .createdBy)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.environments = try container.decode([ScopeEnvironmentsItem].self, forKey: .environments)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.canCreateScope, forKey: .canCreateScope)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.slug, forKey: .slug)
        try container.encode(self.createdBy, forKey: .createdBy)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.environments, forKey: .environments)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case canCreateScope
        case id
        case name
        case slug
        case createdBy
        case createdAt
        case environments
    }
}