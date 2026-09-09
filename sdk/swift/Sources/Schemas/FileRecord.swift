import Foundation

public struct FileRecord: Codable, Hashable, Sendable {
    public let path: String
    public let size: Int
    public let sha256: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        path: String,
        size: Int,
        sha256: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.path = path
        self.size = size
        self.sha256 = sha256
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decode(String.self, forKey: .path)
        self.size = try container.decode(Int.self, forKey: .size)
        self.sha256 = try container.decode(String.self, forKey: .sha256)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.path, forKey: .path)
        try container.encode(self.size, forKey: .size)
        try container.encode(self.sha256, forKey: .sha256)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case path
        case size
        case sha256
    }
}