import Foundation

extension Requests {
    public struct CreatePrivacyRequest: Codable, Hashable, Sendable {
        public let kind: CreatePrivacyRequestKind
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            kind: CreatePrivacyRequestKind,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.kind = kind
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.kind = try container.decode(CreatePrivacyRequestKind.self, forKey: .kind)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.kind, forKey: .kind)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case kind
        }
    }
}