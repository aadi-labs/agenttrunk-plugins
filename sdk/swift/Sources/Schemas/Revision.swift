import Foundation

public struct Revision: Codable, Hashable, Sendable {
    public let id: String
    public let contextId: String
    public let packageDigest: String
    public let parentRevisionId: Nullable<String>?
    public let files: [FileRecord]
    public let createdAt: Date
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: String,
        contextId: String,
        packageDigest: String,
        parentRevisionId: Nullable<String>? = nil,
        files: [FileRecord],
        createdAt: Date,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.contextId = contextId
        self.packageDigest = packageDigest
        self.parentRevisionId = parentRevisionId
        self.files = files
        self.createdAt = createdAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.contextId = try container.decode(String.self, forKey: .contextId)
        self.packageDigest = try container.decode(String.self, forKey: .packageDigest)
        self.parentRevisionId = try container.decodeNullableIfPresent(String.self, forKey: .parentRevisionId)
        self.files = try container.decode([FileRecord].self, forKey: .files)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.contextId, forKey: .contextId)
        try container.encode(self.packageDigest, forKey: .packageDigest)
        try container.encodeNullableIfPresent(self.parentRevisionId, forKey: .parentRevisionId)
        try container.encode(self.files, forKey: .files)
        try container.encode(self.createdAt, forKey: .createdAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case contextId
        case packageDigest
        case parentRevisionId
        case files
        case createdAt
    }
}