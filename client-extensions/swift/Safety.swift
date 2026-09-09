import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

// Per-request delegates reject redirects and bound decoded bytes before buffering.
private final class BoundedDelegate: NSObject, URLSessionDataDelegate, @unchecked Sendable {
    var data = Data()
    var response: URLResponse?
    let limit: Int
    let continuation: CheckedContinuation<(Data, URLResponse), Swift.Error>
    init(limit: Int, continuation: CheckedContinuation<(Data, URLResponse), Swift.Error>) {
        self.limit = limit; self.continuation = continuation
    }
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) { completionHandler(nil) }
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        self.response = response
        if response.expectedContentLength > limit || !((response as? HTTPURLResponse).map { (200...299).contains($0.statusCode) } ?? false) { completionHandler(.cancel) }
        else { completionHandler(.allow) }
    }
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive chunk: Data) {
        if data.count + chunk.count > limit { dataTask.cancel() } else { data.append(chunk) }
    }
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Swift.Error?) {
        defer { session.finishTasksAndInvalidate() }
        if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
            continuation.resume(throwing: AgentTrunkError.httpError(HTTPError.from(statusCode: http.statusCode, data: Data(), jsonDecoder: Serde.jsonDecoder)))
        } else if error != nil { continuation.resume(throwing: AgentTrunkError.invalidResponse) }
        else if let response { continuation.resume(returning: (data, response)) }
        else { continuation.resume(throwing: AgentTrunkError.invalidResponse) }
    }
}

enum AgentTrunkSafety {
    static func validate(_ request: URLRequest) throws {
        guard let url = request.url,
              url.scheme == "https" || (url.scheme == "http" && ["localhost", "127.0.0.1", "[::1]"].contains(url.host ?? "")),
              url.user == nil, url.password == nil, url.fragment == nil else { throw AgentTrunkError.invalidResponse }
        if url.path.hasPrefix("/v1/") {
            guard let token = request.value(forHTTPHeaderField: "Authorization"), token.hasPrefix("Bearer "), token.count > 7 else { throw AgentTrunkError.invalidResponse }
        }
        if url.path.contains("/files/") {
            let refs = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.filter { $0.name == "ref" } ?? []
            guard refs.count == 1, let ref = refs.first?.value, ref.range(of: "^[a-f0-9]{64}$", options: .regularExpression) != nil else { throw AgentTrunkError.invalidResponse }
        }
    }
    static func data(for request: URLRequest, session: URLSession) async throws -> (Data, URLResponse) {
        try validate(request)
        try Task.checkCancellation()
        return try await withCheckedThrowingContinuation { continuation in
            let delegate = BoundedDelegate(limit: request.url!.path.contains("/files/") ? 1_000_000 : 24_000_000, continuation: continuation)
            let config = session.configuration
            config.httpCookieStorage = nil; config.urlCredentialStorage = nil
            let safe = URLSession(configuration: config, delegate: delegate, delegateQueue: nil)
            safe.dataTask(with: request).resume()
        }
    }
}
