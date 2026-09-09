import Foundation

public enum ListReleasesRequestStatus: String, Codable, Hashable, CaseIterable, Sendable {
    case open
    case merged
    case closed
}