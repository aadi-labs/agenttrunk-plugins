import XCTest
@testable import AgentTrunk
import Foundation

final class AgentTrunkProtocol: URLProtocol {
    static var manifest: Data?
    static var count = 0
    static var status = 200
    static var body = Data("{\"data\":[]}".utf8)
    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    override func startLoading() {
        Self.count += 1
        let response = HTTPURLResponse(url: request.url!, statusCode: Self.status, httpVersion: nil, headerFields: nil)!
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: (Self.manifest != nil && !request.url!.path.contains("/files/")) ? Self.manifest! : Self.body)
        client?.urlProtocolDidFinishLoading(self)
    }
    override func stopLoading() {}
}
final class AgentTrunkSafetyTests: XCTestCase {
    func client() -> AgentTrunk {
        let config=URLSessionConfiguration.ephemeral;config.protocolClasses=[AgentTrunkProtocol.self]
        return AgentTrunk(baseURL:"https://api.agenttrunk.ai",accessToken:"test",maxRetries:3,urlSession:URLSession(configuration:config))
    }
    func testMutationsNeverRetry() async throws {
        for status in [401,403,409,429,503,302] {
            AgentTrunkProtocol.count=0;AgentTrunkProtocol.status=status;AgentTrunkProtocol.body=Data("SENSITIVE".utf8)
            do { _ = try await client().workspaces.create(request:.init(name:"test"));XCTFail("Expected rejection") } catch { XCTAssertFalse(String(describing:error).contains("SENSITIVE")) }
            XCTAssertEqual(AgentTrunkProtocol.count,1)
        }
    }
    func testPinAndLimit() async throws {
        AgentTrunkProtocol.count=0;AgentTrunkProtocol.status=200;AgentTrunkProtocol.body=Data(repeating:120,count:1_000_001)
        do { _ = try await client().contexts.readFile(trunkId:"w",contextKey:"k",resourcePath:"SKILL.md",ref:"latest");XCTFail("Expected pin rejection") } catch {}
        XCTAssertEqual(AgentTrunkProtocol.count,0)
        do { _ = try await client().contexts.readFile(trunkId:"w",contextKey:"k",resourcePath:"SKILL.md",ref:String(repeating:"a",count:64));XCTFail("Expected size rejection") } catch {}
    }
    func testReadAndMissingToken() async throws {
        AgentTrunkProtocol.count=0;AgentTrunkProtocol.status=200;AgentTrunkProtocol.body=Data("{\"data\":[]}".utf8)
        let page=try await client().workspaces.list();XCTAssertEqual(page.data.count,0)
        var request=URLRequest(url:URL(string:"https://api.agenttrunk.ai/v1/trunks")!);request.httpMethod="GET"
        XCTAssertThrowsError(try AgentTrunkSafety.validate(request))
    }
    func testVerifiedReadRejectsTampering() async throws {
        AgentTrunkProtocol.status=200
        AgentTrunkProtocol.manifest=try Data(contentsOf:URL(fileURLWithPath:#filePath).deletingLastPathComponent().appendingPathComponent("manifest.json"))
        defer { AgentTrunkProtocol.manifest=nil }
        for tamper in [false,true] {
            AgentTrunkProtocol.body=Data((tamper ? "tampered" : "verified").utf8)
            do {
                let data=try await Verified.readFile(client:client(),workspace:"w",key:"k",revision:String(repeating:"a",count:64),path:"SKILL.md")
                XCTAssertFalse(tamper);XCTAssertEqual(data,Data("verified".utf8))
            } catch { XCTAssertTrue(tamper) }
        }
    }

}
