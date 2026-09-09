import Foundation

public struct ContextSetSource: Codable, Hashable, Sendable {
    public let sourceTrunkId: String
    public let sourceScopeId: String
    public let environmentId: String
    public let contextKey: String
    public let revisionId: String
    public let packageDigest: String
    public let mountPath: String
    public let required: Bool
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        sourceTrunkId: String,
        sourceScopeId: String,
        environmentId: String,
        contextKey: String,
        revisionId: String,
        packageDigest: String,
        mountPath: String,
        required: Bool,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.sourceTrunkId = sourceTrunkId
        self.sourceScopeId = sourceScopeId
        self.environmentId = environmentId
        self.contextKey = contextKey
        self.revisionId = revisionId
        self.packageDigest = packageDigest
        self.mountPath = mountPath
        self.required = required
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sourceTrunkId = try container.decode(String.self, forKey: .sourceTrunkId)
        self.sourceScopeId = try container.decode(String.self, forKey: .sourceScopeId)
        self.environmentId = try container.decode(String.self, forKey: .environmentId)
        self.contextKey = try container.decode(String.self, forKey: .contextKey)
        self.revisionId = try container.decode(String.self, forKey: .revisionId)
        self.packageDigest = try container.decode(String.self, forKey: .packageDigest)
        self.mountPath = try container.decode(String.self, forKey: .mountPath)
        self.required = try container.decode(Bool.self, forKey: .required)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.sourceTrunkId, forKey: .sourceTrunkId)
        try container.encode(self.sourceScopeId, forKey: .sourceScopeId)
        try container.encode(self.environmentId, forKey: .environmentId)
        try container.encode(self.contextKey, forKey: .contextKey)
        try container.encode(self.revisionId, forKey: .revisionId)
        try container.encode(self.packageDigest, forKey: .packageDigest)
        try container.encode(self.mountPath, forKey: .mountPath)
        try container.encode(self.required, forKey: .required)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case sourceTrunkId
        case sourceScopeId
        case environmentId
        case contextKey
        case revisionId
        case packageDigest
        case mountPath
        case required
    }
}