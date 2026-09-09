import Foundation

extension Requests {
    public struct CreateScopesRequest: Codable, Hashable, Sendable {
        public let name: String
        public let slug: String?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            name: String,
            slug: String? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.name = name
            self.slug = slug
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.slug = try container.decodeIfPresent(String.self, forKey: .slug)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.name, forKey: .name)
            try container.encodeIfPresent(self.slug, forKey: .slug)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case name
            case slug
        }
    }
}