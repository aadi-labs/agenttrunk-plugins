import Foundation

public enum ListWebhooksResponseDataItemStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case pending
    case accepted
    case failed
}