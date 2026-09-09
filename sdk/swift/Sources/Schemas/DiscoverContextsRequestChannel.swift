import Foundation

public enum DiscoverContextsRequestChannel: String, Codable, Hashable, CaseIterable, Sendable {
    case production
    case staging
    case latest
}