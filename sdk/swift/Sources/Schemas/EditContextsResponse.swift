import Foundation

public struct EditContextsResponse: Codable, Hashable, Sendable {
    public let context: Context
    public let revision: Revision
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        context: Context,
        revision: Revision,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.context = context
        self.revision = revision
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decode(Context.self, forKey: .context)
        self.revision = try container.decode(Revision.self, forKey: .revision)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.context, forKey: .context)
        try container.encode(self.revision, forKey: .revision)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case context
        case revision
    }
}