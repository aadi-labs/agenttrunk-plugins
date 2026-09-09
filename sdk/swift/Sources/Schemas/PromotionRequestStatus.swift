import Foundation

public enum PromotionRequestStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case open
    case merged
    case closed
}