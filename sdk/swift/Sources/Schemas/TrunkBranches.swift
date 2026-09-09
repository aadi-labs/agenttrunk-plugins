import Foundation

public struct TrunkBranches: Codable, Hashable, Sendable {
    public let staging: Nullable<String>
    public let production: Nullable<String>
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        staging: Nullable<String>,
        production: Nullable<String>,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.staging = staging
        self.production = production
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.staging = try container.decode(Nullable<String>.self, forKey: .staging)
        self.production = try container.decode(Nullable<String>.self, forKey: .production)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.staging, forKey: .staging)
        try container.encode(self.production, forKey: .production)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case staging
        case production
    }
}