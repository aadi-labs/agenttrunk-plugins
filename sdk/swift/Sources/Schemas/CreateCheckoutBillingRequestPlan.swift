import Foundation

public enum CreateCheckoutBillingRequestPlan: String, Codable, Hashable, CaseIterable, Sendable {
    case starter
    case startup
    case scale
}