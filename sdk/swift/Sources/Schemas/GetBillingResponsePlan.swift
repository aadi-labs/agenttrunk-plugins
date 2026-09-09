import Foundation

public enum GetBillingResponsePlan: String, Codable, Hashable, CaseIterable, Sendable {
    case free
    case developer
    case starter
    case startup
    case scale
}