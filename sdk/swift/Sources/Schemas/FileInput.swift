import Foundation

public struct FileInput: Codable, Hashable, Sendable {
    public let path: String
    public let contentBase64: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        path: String,
        contentBase64: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.path = path
        self.contentBase64 = contentBase64
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decode(String.self, forKey: .path)
        self.contentBase64 = try container.decode(String.self, forKey: .contentBase64)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.path, forKey: .path)
        try container.encode(self.contentBase64, forKey: .contentBase64)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case path
        case contentBase64
    }
}