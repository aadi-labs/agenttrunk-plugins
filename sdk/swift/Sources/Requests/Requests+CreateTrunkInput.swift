import Foundation

extension Requests {
    public struct CreateTrunkInput: Codable, Hashable, Sendable {
        public let name: String
        public let description: String?
        /// Copy one authorized immutable context revision into the new workspace's staging environment. Copies verified files and current display metadata, not history, notes, permissions or production releases. The workspace name is reserved for this exact baseline; retry with identical inputs after a partial failure. Destination storage allowances apply. This is a snapshot copy, not a full Git repository fork.
        public let baseline: CreateTrunkInputBaseline?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            name: String,
            description: String? = nil,
            baseline: CreateTrunkInputBaseline? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.name = name
            self.description = description
            self.baseline = baseline
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.baseline = try container.decodeIfPresent(CreateTrunkInputBaseline.self, forKey: .baseline)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.name, forKey: .name)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.baseline, forKey: .baseline)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case name
            case description
            case baseline
        }
    }
}