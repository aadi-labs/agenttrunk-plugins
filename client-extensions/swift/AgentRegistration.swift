import Foundation

public enum AgentRegistrationError: Swift.Error { case invalidDiscovery, invalidCredentials, invalidInput, network, rejected(Int), oversizedResponse }
private final class NoAuthRedirects: NSObject, URLSessionTaskDelegate, @unchecked Sendable {
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) { completionHandler(nil) }
}
/// Human-approved registration. Callers retain credentials in their secret store.
public final class AgentRegistration: @unchecked Sendable {
    public let resource: String
    public let issuer: String
    public let guide: String
    private let identityURL: String
    private let claimURL: String
    private let tokenURL: String
    private let session: URLSession
    private static func origin(_ value: Any?) throws -> String {
        guard let s = value as? String, let u = URLComponents(string:s), u.scheme == "https", let host = u.host,
              !host.isEmpty, u.user == nil, u.password == nil, u.path.isEmpty || u.path == "/", u.query == nil, u.fragment == nil else {throw AgentRegistrationError.invalidDiscovery}
        var base = URLComponents(); base.scheme = "https"; base.host = host; base.port = u.port
        guard let result = base.string else {throw AgentRegistrationError.invalidDiscovery}; return result
    }
    private static func endpoint(_ value: Any?, _ issuer: String) throws -> String {
        guard let s=value as? String, var u=URLComponents(string:s), u.user == nil, u.password == nil, u.fragment == nil else {throw AgentRegistrationError.invalidDiscovery}
        u.path="";u.query=nil
        guard u.string == issuer else {throw AgentRegistrationError.invalidDiscovery};return s
    }
    private static func secret(_ value: Any?) throws -> String {
        guard let s=value as? String, !s.isEmpty, s.utf8.count <= 32768, s.rangeOfCharacter(from:.whitespacesAndNewlines) == nil else {throw AgentRegistrationError.invalidCredentials};return s
    }
    private static func request(_ session: URLSession, _ address: String, _ body: [String:Any]? = nil, form: Bool = false) async throws -> [String:Any] {
        guard let url=URL(string:address) else {throw AgentRegistrationError.invalidDiscovery}
        var req=URLRequest(url:url);req.timeoutInterval=15
        if let body {
            req.httpMethod="POST"
            req.setValue(form ? "application/x-www-form-urlencoded" : "application/json",forHTTPHeaderField:"Content-Type")
            if form {
                let allowed=CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
                req.httpBody=body.map { key,value in "\(key.addingPercentEncoding(withAllowedCharacters:allowed)!)=\(String(describing:value).addingPercentEncoding(withAllowedCharacters:allowed)!)" }.joined(separator:"&").data(using:.utf8)
            } else {req.httpBody=try JSONSerialization.data(withJSONObject:body)}
        }
        do {
            let (stream,response)=try await session.bytes(for:req)
            guard let response=response as? HTTPURLResponse else {throw AgentRegistrationError.network}
            guard (200..<300).contains(response.statusCode) else {throw AgentRegistrationError.rejected(response.statusCode)}
            var data=Data();for try await byte in stream {data.append(byte);if data.count>131072 {throw AgentRegistrationError.oversizedResponse}}
            guard let result=try JSONSerialization.jsonObject(with:data) as? [String:Any] else {throw AgentRegistrationError.invalidDiscovery};return result
        } catch let error as AgentRegistrationError {throw error} catch {throw AgentRegistrationError.network}
    }
    private init(resource:String, issuer:String, server:[String:Any], session:URLSession) throws {
        guard let a=server["agent_auth"] as? [String:Any] else {throw AgentRegistrationError.invalidDiscovery}
        self.resource=resource;self.issuer=issuer;self.session=session
        guide=try Self.endpoint(a["skill"],issuer);identityURL=try Self.endpoint(a["identity_endpoint"],issuer)
        claimURL=try Self.endpoint(a["claim_endpoint"],issuer);tokenURL=try Self.endpoint(server["token_endpoint"],issuer)
    }
    public static func discover(resource:String="https://api.agenttrunk.ai") async throws -> AgentRegistration {
        let api=try origin(resource);let config=URLSessionConfiguration.ephemeral
        config.httpShouldSetCookies=false;config.urlCredentialStorage=nil;config.timeoutIntervalForResource=15
        let session=URLSession(configuration:config,delegate:NoAuthRedirects(),delegateQueue:nil)
        do {
            let meta=try await request(session,api+"/.well-known/oauth-protected-resource")
            guard meta["resource"] as? String == api, let servers=meta["authorization_servers"] as? [String], servers.count==1 else {throw AgentRegistrationError.invalidDiscovery}
            let issuer=try origin(servers[0]);let server=try await request(session,issuer+"/.well-known/oauth-authorization-server")
            guard server["issuer"] as? String == issuer, let a=server["agent_auth"] as? [String:Any], let types=a["identity_types_supported"] as? [String],types.contains("service_auth") else {throw AgentRegistrationError.invalidDiscovery}
            return try AgentRegistration(resource:api,issuer:issuer,server:server,session:session)
        } catch {session.invalidateAndCancel();throw error}
    }
    public func start(email:String) async throws -> [String:String] {
        guard email.utf8.count<=254,email.range(of:"^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$",options:.regularExpression) != nil else {throw AgentRegistrationError.invalidInput}
        let result=try await Self.request(session,identityURL,["type":"service_auth","login_hint":email])
        guard let claim=result["claim"] as? [String:Any] else {throw AgentRegistrationError.invalidDiscovery}
        let token=try Self.secret(claim["token"]);var attempt=claim["attempt"] as? [String:Any]
        if attempt == nil {let r=try await Self.request(session,claimURL,["type":"service_auth","login_hint":email,"claim_token":token]);attempt=r["attempt"] as? [String:Any]}
        return ["claim_token":token,"verification_uri":try Self.endpoint(attempt?["verification_uri"],issuer)]
    }
    private static func identity(_ value:Any?) throws -> [String:Any] {
        guard let v=value as? [String:Any] else {throw AgentRegistrationError.invalidCredentials}
        var result:[String:Any] = ["assertion":try secret(v["assertion"])]
        if let refresh=v["refresh_token"] as? [String:Any] {result["refresh_token"]=["value":try secret(refresh["value"])]};return result
    }
    public func complete(claimToken:String,userCode:String) async throws -> [String:Any] {
        guard userCode.range(of:"^[A-Za-z0-9-]{4,32}$",options:.regularExpression) != nil else {throw AgentRegistrationError.invalidInput}
        let result=try await Self.request(session,claimURL+"/complete",["claim_token":try Self.secret(claimToken),"user_code":userCode]);return try Self.identity(result["identity"])
    }
    public func exchange(identity:[String:Any]) async throws -> [String:Any] {
        let result=try await Self.request(session,tokenURL,["grant_type":"urn:ietf:params:oauth:grant-type:jwt-bearer","assertion":try Self.secret(identity["assertion"]),"resource":resource],form:true)
        guard (result["token_type"] as? String)?.lowercased()=="bearer",let ttl=result["expires_in"] as? Double,ttl.isFinite,ttl>0 else {throw AgentRegistrationError.invalidCredentials}
        return ["access_token":try Self.secret(result["access_token"]),"expires_in":ttl]
    }
    public func refresh(identity:[String:Any]) async throws -> [String:Any] {
        let r=identity["refresh_token"] as? [String:Any]
        let result=try await Self.request(session,identityURL,["type":"refresh","refresh_token":try Self.secret(r?["value"])]);return try Self.identity(result["identity"])
    }
    public func close() {session.invalidateAndCancel()}
}
