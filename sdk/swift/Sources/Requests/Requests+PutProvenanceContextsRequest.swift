import Foundation

extension Requests {
    public struct PutProvenanceContextsRequest: Codable, Hashable, Sendable {
        public let revisionId: String
        /// Maximum 16000 UTF-8 bytes; not 16000 arbitrary Unicode characters.
        public let text: String
        /// Null for the first note; otherwise the notesCommitSha returned by GET.
        public let expectedNotesCommitSha: Nullable<String>
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            revisionId: String,
            text: String,
            expectedNotesCommitSha: Nullable<String>,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.revisionId = revisionId
            self.text = text
            self.expectedNotesCommitSha = expectedNotesCommitSha
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.revisionId = try container.decode(String.self, forKey: .revisionId)
            self.text = try container.decode(String.self, forKey: .text)
            self.expectedNotesCommitSha = try container.decode(Nullable<String>.self, forKey: .expectedNotesCommitSha)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.revisionId, forKey: .revisionId)
            try container.encode(self.text, forKey: .text)
            try container.encode(self.expectedNotesCommitSha, forKey: .expectedNotesCommitSha)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case revisionId
            case text
            case expectedNotesCommitSha
        }
    }
}