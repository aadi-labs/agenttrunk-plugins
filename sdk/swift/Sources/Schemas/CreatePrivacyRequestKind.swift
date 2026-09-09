import Foundation

public enum CreatePrivacyRequestKind: String, Codable, Hashable, CaseIterable, Sendable {
    case access
    case erasure
}