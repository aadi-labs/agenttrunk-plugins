import {readFile,writeFile,copyFile,mkdir} from 'node:fs/promises';
async function patch(path,before,after,count=1){let s=await readFile(path,'utf8');if(s.includes(after))return;let n=s.split(before).length-1;if(n!==count)throw new Error(`Patch drift ${path}: ${n} != ${count}`);await writeFile(path,s.split(before).join(after));}
for(const lang of ['rust','ruby','swift'])await copyFile('LICENSE',`sdk/${lang}/LICENSE`);
await copyFile('client-extensions/rust/agent_auth.rs','sdk/rust/src/agent_auth.rs');
// Normalize the earlier local insertion before applying the stable module patches.
{
 const path='sdk/rust/src/lib.rs'; let source=await readFile(path,'utf8');
 source=source.replace('pub mod verified;\npub mod agent_auth;\npub mod verified;','pub mod verified;');
 source=source.replace('pub mod agent_auth;\n','');
 await writeFile(path,source);
}
// Fern's Rust reference still renders the old nested enum shape. Match the actual public constructor.
await patch('sdk/rust/reference.md', `EditContextInputChangesItem::Put {
                    data: EditContextInputChangesItemPut {
                        path: "path".to_string(),
                        content_base64: "contentBase64".to_string(),
                        ..Default::default()
                    },
                }`, `EditContextInputChangesItem::put("path".to_string(), "contentBase64".to_string())`);
const rb='sdk/ruby/';
await copyFile('client-extensions/ruby/agent_auth.rb',rb+'lib/AgentTrunk/agent_auth.rb');
await copyFile('client-extensions/ruby/safety.rb',rb+'lib/AgentTrunk/safety.rb');
await patch(rb+'lib/AgentTrunk.rb','require "json"','require "set"\nrequire_relative "AgentTrunk/safety"\nrequire "json"');
await patch(rb+'lib/AgentTrunk/client.rb','max_retries: 2','max_retries: 0');
await patch(rb+'lib/AgentTrunk/internal/http/raw_client.rb','max_retries: 2','max_retries: 0');
await patch(rb+'lib/AgentTrunk/internal/http/raw_client.rb','          attempt = 0','          AgentTrunk::Safety.validate!(url, @default_headers.merge(auth_headers))\n          attempt = 0');
await patch(rb+'lib/AgentTrunk/internal/http/raw_client.rb','response = conn.request(http_request)','response = AgentTrunk::Safety.request(conn, http_request, url)');
await patch(rb+'lib/AgentTrunk/internal/http/raw_client.rb','break unless should_retry?(response, attempt)','break unless %w[GET HEAD].include?(request.method) && should_retry?(response, attempt)');
await patch(rb+'lib/AgentTrunk/errors/response_error.rb','super(msg)','super("AgentTrunk request failed (HTTP #{code})")');
await patch(rb+'lib/AgentTrunk/version.rb','"0.0.1"','"0.1.0"');
await patch(rb+'AgentTrunk.gemspec','spec.name = "AgentTrunk"','spec.name = "agenttrunk"');
const sw='sdk/swift/Sources/';
await copyFile('client-extensions/swift/AgentRegistration.swift',sw+'Public/AgentRegistration.swift');
await copyFile('client-extensions/swift/Safety.swift',sw+'Core/Networking/Safety.swift');
await patch(sw+'Public/ClientConfig.swift','static let maxRetries: Swift.Int = 2','static let maxRetries: Swift.Int = 0');
await patch(sw+'Core/Networking/HTTPClient.swift','let maxRetries = retriesDisabled ? 0 : (requestOptions?.maxRetries ?? clientConfig.maxRetries)','let maxRetries = (retriesDisabled || !["GET", "HEAD"].contains(request.httpMethod ?? "")) ? 0 : max(0, requestOptions?.maxRetries ?? clientConfig.maxRetries)');
await patch(sw+'Core/Networking/HTTPClient.swift','clientConfig.urlSession.data(for: request)','AgentTrunkSafety.data(for: request, session: clientConfig.urlSession)');
const rs='sdk/rust/';
// A required nullable concurrency token must serialize None as JSON null, not
// omission. Keep this guarded workaround until the pinned generator handles it.
await patch(rs+'src/api/types/put_provenance_contexts_request.rs',
 '    #[serde(rename = "expectedNotesCommitSha")]\n    #[serde(skip_serializing_if = "Option::is_none")]',
 '    // Required nullable field: None must serialize as JSON null.\n    #[serde(rename = "expectedNotesCommitSha")]');
await copyFile('client-extensions/rust/contract_regressions.rs',rs+'tests/contract_regressions.rs');
await patch(rs+'Cargo.toml','features = ["json", "stream", "gzip"]','features = ["json", "stream", "gzip", "rustls-tls"]');
await patch(rs+'src/config.rs','max_retries: 3','max_retries: 0');
await patch(rs+'src/core/http_client.rs','.timeout(config.timeout)','.redirect(reqwest::redirect::Policy::none())\n                .timeout(config.timeout)');
await patch(rs+'src/core/http_client.rs','        let mut last_error = None;','        let max_retries = if request.method() == Method::GET || request.method() == Method::HEAD { max_retries.min(5) } else { 0 };\n        let mut last_error = None;');
await patch(rs+'src/core/http_client.rs','        if let Some(executor) = &self.executor {',`        let url = req.url();
        if !(url.scheme() == "https" || (url.scheme() == "http" && ["localhost", "127.0.0.1", "[::1]"].contains(&url.host_str().unwrap_or("")))) || !url.username().is_empty() || url.password().is_some() || url.fragment().is_some() { return Err(ApiError::InvalidHeader); }
        if url.path().contains("/files/") {
            let refs: Vec<_> = url.query_pairs().filter(|(k,_)| k == "ref").collect();
            if refs.len() != 1 || refs[0].1.len() != 64 || !refs[0].1.bytes().all(|b| b.is_ascii_digit() || (b'a'..=b'f').contains(&b)) { return Err(ApiError::InvalidHeader); }
        }
        if let Some(executor) = &self.executor {`);
await patch(rs+'src/core/http_client.rs','            self.execute_with_retries(req, options).await','            if req.url().path().starts_with("/v1/") && !req.headers().get("authorization").and_then(|v|v.to_str().ok()).map(|s|s.starts_with("Bearer ") && s.len()>7).unwrap_or(false) { return Err(ApiError::InvalidHeader); }\n            self.execute_with_retries(req, options).await');
await patch(rs+'src/core/http_client.rs','let body = response.text().await.ok();\n                    return Err(ApiError::from_response(status_code, body.as_deref()));','return Err(ApiError::from_response(status_code, None));');
await patch(rs+'src/core/http_client.rs','let text = response.text().await.map_err(ApiError::Network)?;','let text = Self::bounded_text(response).await?;',2);
await patch(rs+'src/core/http_client.rs','    fn is_retryable_status(status_code: u16) -> bool {',`    async fn bounded_text(mut response: Response) -> Result<String, ApiError> {
        let mut bytes = Vec::new();
        while let Some(chunk) = response.chunk().await.map_err(ApiError::Network)? {
            if bytes.len() + chunk.len() > 24_000_000 { return Err(ApiError::InvalidHeader); }
            bytes.extend_from_slice(&chunk);
        }
        Ok(String::from_utf8_lossy(&bytes).into_owned())
    }
    fn is_retryable_status(status_code: u16) -> bool {`);
// All streaming interfaces consume the same bounded stream.
await patch(rs+'src/core/http_client.rs','inner: Pin<Box<dyn Stream<Item = Result<bytes::Bytes, reqwest::Error>> + Send>>,','inner: Pin<Box<dyn Stream<Item = Result<bytes::Bytes, reqwest::Error>> + Send>>,\n    received: usize,');
await patch(rs+'src/core/http_client.rs','            content_length,\n            inner:','            content_length,\n            received: 0,\n            inner:');
await patch(rs+'src/core/http_client.rs','while let Some(chunk) = self.inner.next().await {\n            result.extend_from_slice(&chunk.map_err(ApiError::Network)?);','while let Some(chunk) = self.try_next().await? {\n            result.extend_from_slice(&chunk);');
await patch(rs+'src/core/http_client.rs','Some(Ok(bytes)) => Ok(Some(bytes)),','Some(Ok(bytes)) => { self.received += bytes.len(); if self.received > 1_000_000 { return Err(ApiError::InvalidHeader); } Ok(Some(bytes)) },');
await patch(rs+'src/core/http_client.rs','Poll::Ready(Some(Ok(bytes))) => Poll::Ready(Some(Ok(bytes))),','Poll::Ready(Some(Ok(bytes))) => { self.received += bytes.len(); if self.received > 1_000_000 { return Poll::Ready(Some(Err(ApiError::InvalidHeader))); } Poll::Ready(Some(Ok(bytes))) },');
for(const lang of ['rust','ruby','swift']) {try {await copyFile(`client-extensions/${lang}/README.md`,`sdk/${lang}/README.md`);}catch(e){if(e.code!=='ENOENT')throw e;}}
console.log('Applied Rust, Ruby and Swift safety extensions.');
await copyFile('client-extensions/ruby/verified.rb',rb+'lib/AgentTrunk/verified.rb');
await patch(rb+'lib/AgentTrunk.rb','require "set"','require_relative "AgentTrunk/verified"\nrequire "set"');
await copyFile('client-extensions/rust/verified.rs',rs+'src/verified.rs');
await patch(rs+'src/lib.rs','pub mod client;','pub mod verified;\npub mod client;');
await patch(rs+'Cargo.toml','bytes = "1.0"','sha2 = "0.10"\nbytes = "1.0"');
await copyFile('client-extensions/swift/Verified.swift',sw+'Public/Verified.swift');
// Fern Ruby 1.23.2 drops untyped response bodies. Restore the wire contract for
// untyped JSON results and binary reads, without changing method signatures.
const {readdir}=await import('node:fs/promises');
for(const group of await readdir(rb+'lib/AgentTrunk',{withFileTypes:true})){
 if(!group.isDirectory())continue;
 const path=rb+'lib/AgentTrunk/'+group.name+'/client.rb';let s;try{s=await readFile(path,'utf8');}catch(e){if(e.code==='ENOENT')continue;throw e;}
 s=s.replaceAll('return if code.between?(200, 299)','return response.body.to_s.empty? ? nil : JSON.parse(response.body) if code.between?(200, 299)');
 if(group.name==='contexts'){
  const start=s.indexOf('      def read_file(');if(start<0)throw new Error('Ruby binary patch drift');
  s=s.slice(0,start)+s.slice(start).replace('return response.body.to_s.empty? ? nil : JSON.parse(response.body) if code.between?(200, 299)','return response.body if code.between?(200, 299)');
 }
 await writeFile(path,s);
}
await mkdir(rs+'examples',{recursive:true});await copyFile('client-extensions/rust/quickstart.rs',rs+'examples/quickstart.rs');
await copyFile('client-extensions/rust/agenttrunk_safety.rs',rs+'tests/agenttrunk_safety.rs');
await mkdir(rb+'examples',{recursive:true});await copyFile('client-extensions/ruby/quickstart.rb',rb+'examples/quickstart.rb');
await mkdir('sdk/swift/Tests/AgentTrunk',{recursive:true});await copyFile('client-extensions/swift/AgentTrunkSafetyTests.swift','sdk/swift/Tests/AgentTrunk/AgentTrunkSafetyTests.swift');
await copyFile('client-extensions/rust/safety.rs',rs+'src/safety.rs');
await patch(rs+'src/lib.rs','pub mod verified;','pub mod safety;\npub mod verified;');
await patch(rs+'src/lib.rs','pub mod prelude;','pub mod prelude;\npub mod agent_auth;');
async function encodeRustPaths(dir){for(const entry of await readdir(dir,{withFileTypes:true})){const path=dir+'/'+entry.name;if(entry.isDirectory()){await encodeRustPaths(path);continue;}if(!path.endsWith('.rs'))continue;let s=await readFile(path,'utf8');
 s=s.replace(/&format!\(\s*("v1\/[^"\n]+"),([\s\S]*?)\)/g,(full,format,args)=>{if(args.includes('crate::safety::path_param'))return full;const names=args.split(',').map(s=>s.trim()).filter(Boolean);if(names.some(n=>!/^\w+$/.test(n)))throw Error('Rust path template drift');return `&format!(${format}, ${names.map(n=>`crate::safety::path_param(${n})?`).join(', ')})`;});await writeFile(path,s);
}}
await encodeRustPaths(rs+'src/api/resources');
await patch(rb+'lib/AgentTrunk/internal/http/raw_client.rb','"X-Fern-SDK-Version": "0.0.1"','"X-Fern-SDK-Version": "0.1.0"');
await copyFile('client-extensions/ruby/custom.gemspec.rb',rb+'custom.gemspec.rb');
await copyFile('client-extensions/rust/manifest.json',rs+'tests/manifest.json');
await copyFile('client-extensions/swift/manifest.json','sdk/swift/Tests/AgentTrunk/manifest.json');

await patch('sdk/swift/Package.swift','path: "Tests"','path: "Tests",\n            exclude: ["AgentTrunk/manifest.json"]');
const swiftManifest=await readFile('sdk/swift/Package.swift','utf8');
await writeFile('Package.swift',swiftManifest.replace('path: "Sources"','path: "sdk/swift/Sources"').replace('path: "Tests"','path: "sdk/swift/Tests"'));

// Fern references contain whitespace-only code-block lines. Normalize these in
// the generator pipeline rather than hand-editing generated documentation.
for(const language of ['typescript','python','go','rust','ruby','swift']) {
 const path=`sdk/${language}/reference.md`;
 try {await writeFile(path,(await readFile(path,'utf8')).replace(/[\t ]+$/gm,''));}
 catch(error){if(error.code!=='ENOENT')throw error;}
}
