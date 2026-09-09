import Foundation

extension Requests {
    public struct PublishInput: Codable, Hashable, Sendable {
        public let contextKey: String
        public let title: String
        public let summary: String?
        public let kind: ContextKind
        public let tags: [String]?
        public let files: [FileInput]
        public let claimedDigest: String?
        public let scopeId: String?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            contextKey: String,
            title: String,
            summary: String? = nil,
            kind: ContextKind,
            tags: [String]? = nil,
            files: [FileInput],
            claimedDigest: String? = nil,
            scopeId: String? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.contextKey = contextKey
            self.title = title
            self.summary = summary
            self.kind = kind
            self.tags = tags
            self.files = files
            self.claimedDigest = claimedDigest
            self.scopeId = scopeId
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.contextKey = try container.decode(String.self, forKey: .contextKey)
            self.title = try container.decode(String.self, forKey: .title)
            self.summary = try container.decodeIfPresent(String.self, forKey: .summary)
            self.kind = try container.decode(ContextKind.self, forKey: .kind)
            self.tags = try container.decodeIfPresent([String].self, forKey: .tags)
            self.files = try container.decode([FileInput].self, forKey: .files)
            self.claimedDigest = try container.decodeIfPresent(String.self, forKey: .claimedDigest)
            self.scopeId = try container.decodeIfPresent(String.self, forKey: .scopeId)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.contextKey, forKey: .contextKey)
            try container.encode(self.title, forKey: .title)
            try container.encodeIfPresent(self.summary, forKey: .summary)
            try container.encode(self.kind, forKey: .kind)
            try container.encodeIfPresent(self.tags, forKey: .tags)
            try container.encode(self.files, forKey: .files)
            try container.encodeIfPresent(self.claimedDigest, forKey: .claimedDigest)
            try container.encodeIfPresent(self.scopeId, forKey: .scopeId)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case contextKey
            case title
            case summary
            case kind
            case tags
            case files
            case claimedDigest
            case scopeId
        }
    }
}