import Foundation

public struct DiscoverContextsResponse: Codable, Hashable, Sendable {
    public let data: [DiscoveryResult]
    /// Continue until null, including after empty pages. At most 100 candidates are authorization-checked per request.
    public let nextCursor: Nullable<String>?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        data: [DiscoveryResult],
        nextCursor: Nullable<String>? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.data = data
        self.nextCursor = nextCursor
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([DiscoveryResult].self, forKey: .data)
        self.nextCursor = try container.decodeNullableIfPresent(String.self, forKey: .nextCursor)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.data, forKey: .data)
        try container.encodeNullableIfPresent(self.nextCursor, forKey: .nextCursor)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case data
        case nextCursor
    }
}