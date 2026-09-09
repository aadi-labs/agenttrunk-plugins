import Foundation

extension Requests {
    public struct OpenPromotionRequestInput: Codable, Hashable, Sendable {
        public let evidenceReference: String?
        /// Defaults to the trunk General scope.
        public let scopeId: String?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            evidenceReference: String? = nil,
            scopeId: String? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.evidenceReference = evidenceReference
            self.scopeId = scopeId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.evidenceReference = try container.decodeIfPresent(String.self, forKey: .evidenceReference)
            self.scopeId = try container.decodeIfPresent(String.self, forKey: .scopeId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encodeIfPresent(self.evidenceReference, forKey: .evidenceReference)
            try container.encodeIfPresent(self.scopeId, forKey: .scopeId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case evidenceReference
            case scopeId
        }
    }
}