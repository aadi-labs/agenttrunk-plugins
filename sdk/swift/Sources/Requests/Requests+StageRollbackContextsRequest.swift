import Foundation

extension Requests {
    public struct StageRollbackContextsRequest: Codable, Hashable, Sendable {
        public let revisionId: String
        public let expectedStagingRevisionId: String
        public let reason: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            revisionId: String,
            expectedStagingRevisionId: String,
            reason: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.revisionId = revisionId
            self.expectedStagingRevisionId = expectedStagingRevisionId
            self.reason = reason
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.revisionId = try container.decode(String.self, forKey: .revisionId)
            self.expectedStagingRevisionId = try container.decode(String.self, forKey: .expectedStagingRevisionId)
            self.reason = try container.decode(String.self, forKey: .reason)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.revisionId, forKey: .revisionId)
            try container.encode(self.expectedStagingRevisionId, forKey: .expectedStagingRevisionId)
            try container.encode(self.reason, forKey: .reason)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case revisionId
            case expectedStagingRevisionId
            case reason
        }
    }
}