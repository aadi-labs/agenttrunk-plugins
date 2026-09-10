import Foundation

public struct GetBillingResponse: Codable, Hashable, Sendable {
    public let plan: GetBillingResponsePlan
    public let accesses: Int
    /// Included successful file reads per billing period. An export counts every delivered file.
    public let includedAccesses: Nullable<Int>
    /// Retained storage allowance in decimal bytes. Not a measured usage value.
    public let includedStorageBytes: Nullable<Int>?
    public let spendLimitCents: Int
    /// Whether successful context delivery metering is active.
    public let meteringActive: Bool
    public let canManage: Bool
    public let subscriptionStatus: String?
    public let monthlyPriceCents: Int?
    public let overageCents: Int?
    public let overageCentsPerThousand: Nullable<Int>?
    public let period: String?
    public let hasCustomer: Bool?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        plan: GetBillingResponsePlan,
        accesses: Int,
        includedAccesses: Nullable<Int>,
        includedStorageBytes: Nullable<Int>? = nil,
        spendLimitCents: Int,
        meteringActive: Bool,
        canManage: Bool,
        subscriptionStatus: String? = nil,
        monthlyPriceCents: Int? = nil,
        overageCents: Int? = nil,
        overageCentsPerThousand: Nullable<Int>? = nil,
        period: String? = nil,
        hasCustomer: Bool? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.plan = plan
        self.accesses = accesses
        self.includedAccesses = includedAccesses
        self.includedStorageBytes = includedStorageBytes
        self.spendLimitCents = spendLimitCents
        self.meteringActive = meteringActive
        self.canManage = canManage
        self.subscriptionStatus = subscriptionStatus
        self.monthlyPriceCents = monthlyPriceCents
        self.overageCents = overageCents
        self.overageCentsPerThousand = overageCentsPerThousand
        self.period = period
        self.hasCustomer = hasCustomer
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.plan = try container.decode(GetBillingResponsePlan.self, forKey: .plan)
        self.accesses = try container.decode(Int.self, forKey: .accesses)
        self.includedAccesses = try container.decode(Nullable<Int>.self, forKey: .includedAccesses)
        self.includedStorageBytes = try container.decodeNullableIfPresent(Int.self, forKey: .includedStorageBytes)
        self.spendLimitCents = try container.decode(Int.self, forKey: .spendLimitCents)
        self.meteringActive = try container.decode(Bool.self, forKey: .meteringActive)
        self.canManage = try container.decode(Bool.self, forKey: .canManage)
        self.subscriptionStatus = try container.decodeIfPresent(String.self, forKey: .subscriptionStatus)
        self.monthlyPriceCents = try container.decodeIfPresent(Int.self, forKey: .monthlyPriceCents)
        self.overageCents = try container.decodeIfPresent(Int.self, forKey: .overageCents)
        self.overageCentsPerThousand = try container.decodeNullableIfPresent(Int.self, forKey: .overageCentsPerThousand)
        self.period = try container.decodeIfPresent(String.self, forKey: .period)
        self.hasCustomer = try container.decodeIfPresent(Bool.self, forKey: .hasCustomer)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.plan, forKey: .plan)
        try container.encode(self.accesses, forKey: .accesses)
        try container.encode(self.includedAccesses, forKey: .includedAccesses)
        try container.encodeNullableIfPresent(self.includedStorageBytes, forKey: .includedStorageBytes)
        try container.encode(self.spendLimitCents, forKey: .spendLimitCents)
        try container.encode(self.meteringActive, forKey: .meteringActive)
        try container.encode(self.canManage, forKey: .canManage)
        try container.encodeIfPresent(self.subscriptionStatus, forKey: .subscriptionStatus)
        try container.encodeIfPresent(self.monthlyPriceCents, forKey: .monthlyPriceCents)
        try container.encodeIfPresent(self.overageCents, forKey: .overageCents)
        try container.encodeNullableIfPresent(self.overageCentsPerThousand, forKey: .overageCentsPerThousand)
        try container.encodeIfPresent(self.period, forKey: .period)
        try container.encodeIfPresent(self.hasCustomer, forKey: .hasCustomer)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case plan
        case accesses
        case includedAccesses
        case includedStorageBytes
        case spendLimitCents
        case meteringActive
        case canManage
        case subscriptionStatus
        case monthlyPriceCents
        case overageCents
        case overageCentsPerThousand
        case period
        case hasCustomer
    }
}