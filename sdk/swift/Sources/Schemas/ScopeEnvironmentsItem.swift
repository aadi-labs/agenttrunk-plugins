import Foundation

public struct ScopeEnvironmentsItem: Codable, Hashable, Sendable {
    public let id: String
    public let name: ScopeEnvironmentsItemName
    public let commitSha: Nullable<String>
    public let canDeploy: Bool?
    public let canPropose: Bool?
    public let canPublish: Bool?
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        id: String,
        name: ScopeEnvironmentsItemName,
        commitSha: Nullable<String>,
        canDeploy: Bool? = nil,
        canPropose: Bool? = nil,
        canPublish: Bool? = nil,
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.id = id
        self.name = name
        self.commitSha = commitSha
        self.canDeploy = canDeploy
        self.canPropose = canPropose
        self.canPublish = canPublish
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(ScopeEnvironmentsItemName.self, forKey: .name)
        self.commitSha = try container.decode(Nullable<String>.self, forKey: .commitSha)
        self.canDeploy = try container.decodeIfPresent(Bool.self, forKey: .canDeploy)
        self.canPropose = try container.decodeIfPresent(Bool.self, forKey: .canPropose)
        self.canPublish = try container.decodeIfPresent(Bool.self, forKey: .canPublish)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.commitSha, forKey: .commitSha)
        try container.encodeIfPresent(self.canDeploy, forKey: .canDeploy)
        try container.encodeIfPresent(self.canPropose, forKey: .canPropose)
        try container.encodeIfPresent(self.canPublish, forKey: .canPublish)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case commitSha
        case canDeploy
        case canPropose
        case canPublish
    }
}