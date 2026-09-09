import Foundation

public enum ContextKind: String, Codable, Hashable, CaseIterable, Sendable {
    case skill
    case docs
    case prompt
    case policy
    case memorySchema = "memory-schema"
}