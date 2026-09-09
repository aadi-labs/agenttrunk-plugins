import Foundation

public struct PromotionRequest: Codable, Hashable, Sendable {
    public let id: String
    public let trunkId: String
    public let scopeId: String
    public let sourceCommitSha: String
    public let targetCommitSha: Nullable<String>
    public let changes: [PromotionRequestChangesItem]
    public let status: PromotionRequestStatus
    public let evidenceReference: Nullable<String>?
    public let createdBy: String
    public let delegatedActorId: Nullable<String>?
    public let createdAt: Date
    public let mergedBy: Nullable<String>?
    public let mergedDelegatedActorId: Nullable<String>?
    public let mergedAt: Nullable<Date>?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: String,
        trunkId: String,
        scopeId: String,
        sourceCommitSha: String,
        targetCommitSha: Nullable<String>,
        changes: [PromotionRequestChangesItem],
        status: PromotionRequestStatus,
        evidenceReference: Nullable<String>? = nil,
        createdBy: String,
        delegatedActorId: Nullable<String>? = nil,
        createdAt: Date,
        mergedBy: Nullable<String>? = nil,
        mergedDelegatedActorId: Nullable<String>? = nil,
        mergedAt: Nullable<Date>? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.trunkId = trunkId
        self.scopeId = scopeId
        self.sourceCommitSha = sourceCommitSha
        self.targetCommitSha = targetCommitSha
        self.changes = changes
        self.status = status
        self.evidenceReference = evidenceReference
        self.createdBy = createdBy
        self.delegatedActorId = delegatedActorId
        self.createdAt = createdAt
        self.mergedBy = mergedBy
        self.mergedDelegatedActorId = mergedDelegatedActorId
        self.mergedAt = mergedAt
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.trunkId = try container.decode(String.self, forKey: .trunkId)
        self.scopeId = try container.decode(String.self, forKey: .scopeId)
        self.sourceCommitSha = try container.decode(String.self, forKey: .sourceCommitSha)
        self.targetCommitSha = try container.decode(Nullable<String>.self, forKey: .targetCommitSha)
        self.changes = try container.decode([PromotionRequestChangesItem].self, forKey: .changes)
        self.status = try container.decode(PromotionRequestStatus.self, forKey: .status)
        self.evidenceReference = try container.decodeNullableIfPresent(String.self, forKey: .evidenceReference)
        self.createdBy = try container.decode(String.self, forKey: .createdBy)
        self.delegatedActorId = try container.decodeNullableIfPresent(String.self, forKey: .delegatedActorId)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.mergedBy = try container.decodeNullableIfPresent(String.self, forKey: .mergedBy)
        self.mergedDelegatedActorId = try container.decodeNullableIfPresent(String.self, forKey: .mergedDelegatedActorId)
        self.mergedAt = try container.decodeNullableIfPresent(Date.self, forKey: .mergedAt)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.trunkId, forKey: .trunkId)
        try container.encode(self.scopeId, forKey: .scopeId)
        try container.encode(self.sourceCommitSha, forKey: .sourceCommitSha)
        try container.encode(self.targetCommitSha, forKey: .targetCommitSha)
        try container.encode(self.changes, forKey: .changes)
        try container.encode(self.status, forKey: .status)
        try container.encodeNullableIfPresent(self.evidenceReference, forKey: .evidenceReference)
        try container.encode(self.createdBy, forKey: .createdBy)
        try container.encodeNullableIfPresent(self.delegatedActorId, forKey: .delegatedActorId)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encodeNullableIfPresent(self.mergedBy, forKey: .mergedBy)
        try container.encodeNullableIfPresent(self.mergedDelegatedActorId, forKey: .mergedDelegatedActorId)
        try container.encodeNullableIfPresent(self.mergedAt, forKey: .mergedAt)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case trunkId
        case scopeId
        case sourceCommitSha
        case targetCommitSha
        case changes
        case status
        case evidenceReference
        case createdBy
        case delegatedActorId
        case createdAt
        case mergedBy
        case mergedDelegatedActorId
        case mergedAt
    }
}