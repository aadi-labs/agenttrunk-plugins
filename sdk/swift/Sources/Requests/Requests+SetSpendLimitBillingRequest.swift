import Foundation

extension Requests {
    public struct SetSpendLimitBillingRequest: Codable, Hashable, Sendable {
        public let cents: Int
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            cents: Int,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.cents = cents
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.cents = try container.decode(Int.self, forKey: .cents)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.cents, forKey: .cents)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case cents
        }
    }
}