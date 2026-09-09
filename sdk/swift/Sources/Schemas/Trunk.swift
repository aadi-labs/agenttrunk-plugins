import Foundation

public struct Trunk: Codable, Hashable, Sendable {
    public let id: String
    public let organizationId: String
    public let name: String
    public let slug: String
    public let createdBy: String
    public let branches: TrunkBranches
    public let createdAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: String,
        organizationId: String,
        name: String,
        slug: String,
        createdBy: String,
        branches: TrunkBranches,
        createdAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.organizationId = organizationId
        self.name = name
        self.slug = slug
        self.createdBy = createdBy
        self.branches = branches
        self.createdAt = createdAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.organizationId = try container.decode(String.self, forKey: .organizationId)
        self.name = try container.decode(String.self, forKey: .name)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.createdBy = try container.decode(String.self, forKey: .createdBy)
        self.branches = try container.decode(TrunkBranches.self, forKey: .branches)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.organizationId, forKey: .organizationId)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.slug, forKey: .slug)
        try container.encode(self.createdBy, forKey: .createdBy)
        try container.encode(self.branches, forKey: .branches)
        try container.encode(self.createdAt, forKey: .createdAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case organizationId
        case name
        case slug
        case createdBy
        case branches
        case createdAt
    }
}