import Foundation
import CryptoKit
public enum Verified {
    public static func readFile(client: AgentTrunk, workspace: String, key: String, revision: String, path: String) async throws -> Data {
        guard revision.range(of: "^[a-f0-9]{64}$", options: .regularExpression) != nil,
              !path.isEmpty, path.utf8.count <= 512, !path.contains("\\"),
              !path.unicodeScalars.contains(where: { $0.value < 32 || $0.value == 127 }),
              !path.components(separatedBy: "/").contains(where: { ["", ".", ".."].contains($0) }) else { throw AgentTrunkError.invalidResponse }
        let pin = try await client.contexts.inspect(trunkId: workspace, contextKey: key, ref: revision)
        guard pin.revision.id == revision, let file = pin.revision.files.first(where: { $0.path == path }),
              (0...1_000_000).contains(file.size) else { throw AgentTrunkError.invalidResponse }
        let data = try await client.contexts.readFile(trunkId: workspace, contextKey: key, resourcePath: path, ref: revision)
        let hash = SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
        guard data.count == file.size, hash == file.sha256 else { throw AgentTrunkError.invalidResponse }
        return data
    }
}
