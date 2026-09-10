import Foundation

extension Requests {
    public struct EditContextInput: Codable, Hashable, Sendable {
        public let expectedRevisionId: String
        public let changes: [EditContextInputChangesItem]
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            expectedRevisionId: String,
            changes: [EditContextInputChangesItem],
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.expectedRevisionId = expectedRevisionId
            self.changes = changes
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.expectedRevisionId = try container.decode(String.self, forKey: .expectedRevisionId)
            self.changes = try container.decode([EditContextInputChangesItem].self, forKey: .changes)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.expectedRevisionId, forKey: .expectedRevisionId)
            try container.encode(self.changes, forKey: .changes)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case expectedRevisionId
            case changes
        }
    }
}