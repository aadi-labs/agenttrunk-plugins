import Foundation

public struct SetSpendLimitBillingResponse: Codable, Hashable, Sendable {
    public let spendLimitCents: Int
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        spendLimitCents: Int,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.spendLimitCents = spendLimitCents
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.spendLimitCents = try container.decode(Int.self, forKey: .spendLimitCents)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.spendLimitCents, forKey: .spendLimitCents)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case spendLimitCents
    }
}