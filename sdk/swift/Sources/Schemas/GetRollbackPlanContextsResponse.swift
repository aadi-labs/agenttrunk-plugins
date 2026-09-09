import Foundation

public struct GetRollbackPlanContextsResponse: Codable, Hashable, Sendable {
    public let eligible: Bool
    public let expectedStagingRevisionId: Nullable<String>
    public let reason: String
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        eligible: Bool,
        expectedStagingRevisionId: Nullable<String>,
        reason: String,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.eligible = eligible
        self.expectedStagingRevisionId = expectedStagingRevisionId
        self.reason = reason
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eligible = try container.decode(Bool.self, forKey: .eligible)
        self.expectedStagingRevisionId = try container.decode(Nullable<String>.self, forKey: .expectedStagingRevisionId)
        self.reason = try container.decode(String.self, forKey: .reason)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.eligible, forKey: .eligible)
        try container.encode(self.expectedStagingRevisionId, forKey: .expectedStagingRevisionId)
        try container.encode(self.reason, forKey: .reason)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case eligible
        case expectedStagingRevisionId
        case reason
    }
}