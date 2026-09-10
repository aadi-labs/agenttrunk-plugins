import Foundation

public enum EditContextInputChangesItem: Codable, Hashable, Sendable {
    case delete(EditContextInputChangesItemDelete)
    case put(EditContextInputChangesItemPut)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .operation)
        switch discriminant {
        case "delete":
            self = .delete(try EditContextInputChangesItemDelete(from: decoder))
        case "put":
            self = .put(try EditContextInputChangesItemPut(from: decoder))
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown shape discriminant value: \(discriminant)"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .delete(let data):
            try container.encode("delete", forKey: .operation)
            try data.encode(to: encoder)
        case .put(let data):
            try container.encode("put", forKey: .operation)
            try data.encode(to: encoder)
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case operation
    }
}