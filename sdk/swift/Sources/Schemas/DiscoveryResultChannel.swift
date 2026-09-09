import Foundation

public enum DiscoveryResultChannel: String, Codable, Hashable, CaseIterable, Sendable {
    case production
    case staging
    case latest
}