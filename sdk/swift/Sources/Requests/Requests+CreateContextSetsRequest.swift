import Foundation

extension Requests {
    public struct CreateContextSetsRequest: Codable, Hashable, Sendable {
        public let name: String
        public let sources: [ContextSetSource]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            name: String,
            sources: [ContextSetSource],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.name = name
            self.sources = sources
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.sources = try container.decode([ContextSetSource].self, forKey: .sources)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.name, forKey: .name)
            try container.encode(self.sources, forKey: .sources)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case name
            case sources
        }
    }
}