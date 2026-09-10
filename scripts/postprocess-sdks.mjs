import {readFile, writeFile, copyFile, mkdir, readdir} from 'node:fs/promises';
import {dirname, resolve} from 'node:path';
import {execFileSync} from 'node:child_process';

// Fail closed if a pinned generator changes a patch point. Never edit generated methods by hand.
async function replace(path, before, after, expected = 1) {
  const text = await readFile(path, 'utf8');
  const normalized = value => value.replace(/\s+/g, ' ').trim();
  if (after && normalized(text).includes(normalized(after))) return;
  const count = text.split(before).length - 1;
  if (count !== expected) throw new Error(`Generator patch drift in ${path}: expected ${expected} matches, found ${count}`);
  await writeFile(path, text.split(before).join(after));
}
async function copy(from, to) {await mkdir(dirname(to), {recursive:true}); await copyFile(from, to);}
for (const language of ['typescript','python','go']) await copy('LICENSE', `sdk/${language}/LICENSE`);
await copy('client-extensions/typescript/safety.ts', 'sdk/typescript/src/core/fetcher/safety.ts');
await copy('client-extensions/python/safety.py', 'sdk/python/src/agenttrunk/core/safety.py');
await copy('client-extensions/python/verified.py', 'sdk/python/src/agenttrunk/verified.py');
await copy('client-extensions/python/agent_auth.py', 'sdk/python/src/agenttrunk/agent_auth.py');
await copy('client-extensions/go/safety.go', 'sdk/go/internal/safety.go');
await copy('client-extensions/go/verified.go', 'sdk/go/verified/verified.go');
await copy('client-extensions/go/agent_auth.go', 'sdk/go/agentauth/agent_auth.go');
await copy('client-extensions/go/agent_auth_test.go', 'sdk/go/agentauth/agent_auth_test.go');
await copy('client-extensions/go/verified_test.go', 'sdk/go/verified/verified_test.go');
await copy('client-extensions/go/quickstart.go', 'sdk/go/examples/quickstart/main.go');

// The root ESM package compiles these generated sources, so NodeNext must also see ESM here.
const tsPackage = JSON.parse(await readFile('sdk/typescript/package.json', 'utf8'));
tsPackage.type = 'module'; tsPackage.private = true;
await writeFile('sdk/typescript/package.json', JSON.stringify(tsPackage, null, 2) + '\n');

const ts = 'sdk/typescript/src/';
await replace(ts+'core/fetcher/makeRequest.ts', 'import { anySignal', 'import { validateRequest, boundedResponse } from "./safety.js";\nimport { anySignal');
await replace(ts+'core/fetcher/makeRequest.ts', '    const signals: AbortSignal[] = [];', '    validateRequest(url, headers);\n    const signals: AbortSignal[] = [];');
await replace(ts+'core/fetcher/makeRequest.ts', '        method: method,', '        method: method,\n        redirect: "error",');
await replace(ts+'core/fetcher/makeRequest.ts', '    const response = await fetchFn(url, {', '    try {\n    const response = await fetchFn(url, {');
await replace(ts+'core/fetcher/makeRequest.ts', '    if (timeoutAbortId != null) {\n        clearTimeout(timeoutAbortId);\n    }\n\n    return response;', '    return await boundedResponse(response, url);\n    } finally {\n        if (timeoutAbortId != null) clearTimeout(timeoutAbortId);\n    }');

await replace(ts+'core/fetcher/Fetcher.ts', 'response.status < 400', 'response.status < 300');
await replace(ts+'core/fetcher/Fetcher.ts', '            args.maxRetries,', '            ["GET", "HEAD"].includes(args.method.toUpperCase()) ? (args.maxRetries ?? 0) : 0,');
await replace(ts+'core/fetcher/requestWithRetries.ts', 'const DEFAULT_MAX_RETRIES = 2;', 'const DEFAULT_MAX_RETRIES = 0;');
await replace(ts+'BaseClient.ts', 'Defaults to 2.', 'Defaults to 0; mutations are never retried.', 2);
await replace(ts+'errors/AgentTrunkApiError.ts', 'super(buildMessage({ message, statusCode, body }));', 'super(`AgentTrunk request failed${statusCode == null ? "" : ` (HTTP ${statusCode})`}`);');

const py = 'sdk/python/src/agenttrunk/';
await replace(py+'client.py', 'follow_redirects: typing.Optional[bool] = True,', 'follow_redirects: typing.Optional[bool] = False,', 2);
await replace(py+'client.py', '_defaulted_max_retries = max_retries if max_retries is not None else 2', '_defaulted_max_retries = max_retries if max_retries is not None else 0', 2);
await replace(py+'client.py', 'Defaults to 2.', 'Defaults to 0; mutations are never retried.', 2);
await replace(py+'core/http_client.py', 'import httpx\n', 'import httpx\nfrom .safety import bounded_request, async_bounded_request, bounded_stream, async_bounded_stream\n');
await replace(py+'core/http_client.py', 'response = self.httpx_client.request(', 'response = bounded_request(self.httpx_client,');
await replace(py+'core/http_client.py', 'response = await self.httpx_client.request(', 'response = await async_bounded_request(self.httpx_client,');
await replace(py+'core/http_client.py', 'async with self.httpx_client.stream(', 'async with async_bounded_stream(self.httpx_client,');
await replace(py+'core/http_client.py', 'with self.httpx_client.stream(', 'with bounded_stream(self.httpx_client,');
await replace(py+'core/http_client.py', '        try:\n            response =', '        if method.upper() not in ("GET", "HEAD"):\n            max_retries = 0\n\n        try:\n            response =', 2);
await replace(py+'core/api_error.py', 'return f"headers: {self.headers}, status_code: {self.status_code}, body: {self.body}"', 'return f"AgentTrunk request failed (HTTP {self.status_code})"');
await replace(py+'core/parse_error.py', 'return f"headers: {self.headers}, status_code: {self.status_code}, body: {self.body}{cause_str}"', 'return f"AgentTrunk response could not be parsed (HTTP {self.status_code})"');
let pyproject = await readFile('sdk/python/pyproject.toml', 'utf8');
pyproject = pyproject.replace('description = ""', 'description = "AgentTrunk Python SDK for versioned agent context."')
  .replace('authors = []', 'authors = ["Aadi Labs"]\nlicense = "MIT"\nrepository = "https://github.com/aadi-labs/agenttrunk-plugins"')
  .replace('keywords = []', 'keywords = ["agenttrunk", "agents", "context", "skills"]');
await writeFile('sdk/python/pyproject.toml', pyproject);

const go = 'sdk/go/';
await replace(go+'internal/caller.go', 'var httpClient core.HTTPClient = http.DefaultClient', 'var httpClient core.HTTPClient = safeClient(nil)');
await replace(go+'internal/caller.go', 'httpClient = params.Client', 'httpClient = safeClient(params.Client)');
await replace(go+'internal/caller.go', 'client = params.Client', 'client = safeClient(params.Client)');
await replace(go+'internal/caller.go', '\t// If the call has been cancelled,', '\tif err := validateRequest(req); err != nil { return nil, err }\n\n\t// If the call has been cancelled,');
await replace(go+'internal/caller.go', '\t\treturn nil, decodeError(resp, body, params.ErrorDecoder)', '\t\treturn nil, core.NewAPIError(resp.StatusCode, resp.Header, nil)');
await replace(go+'internal/caller.go', '\t// Mutate the response parameter in-place.', '\tbody, err = boundedBody(body, req.URL.Path)\n\tif err != nil { return nil, err }\n\n\t// Mutate the response parameter in-place.');
await replace(go+'internal/retrier.go', 'defaultRetryAttempts = 2', 'defaultRetryAttempts = 1');
await replace(go+'internal/retrier.go', '\tif disabled {\n\t\tmaxRetryAttempts = 1', '\tif disabled || (request.Method != http.MethodGet && request.Method != http.MethodHead) {\n\t\tmaxRetryAttempts = 1');
await replace(go+'internal/retrier.go', 'if r.shouldRetry(response) {', 'if r.shouldRetry(response) && retryAttempt+1 < maxRetryAttempts {');
await replace(go+'internal/retrier.go', '\t\tbody, err := decompressedResponseBody(response)\n\t\tif err != nil {\n\t\t\treturn nil, err\n\t\t}\n', '\t\t// AgentTrunk does not buffer provider errors for retries.\n');
await replace(go+'internal/retrier.go', '\t\t\tdecodeError(response, body, errorDecoder),', '\t\t\tnil, // AgentTrunk does not retain provider error bodies.');
await replace(go+'client/client.go', 'if options.AccessToken == "" {', 'if options.AccessToken == "" && options.AccessTokenFunc == nil {');

// Generated docs are replaced from authored sources when available, and restored on every generation.
for (const language of ['typescript','python','go']) {
  try {await copy(`client-extensions/${language}/README.md`, `sdk/${language}/README.md`);}
  catch (error) {if (error.code !== 'ENOENT') throw error;}
}
execFileSync('gofmt', ['-w', 'sdk/go/internal', 'sdk/go/client/client.go', 'sdk/go/verified', 'sdk/go/examples/quickstart'], {stdio:'pipe'});
console.log('Applied AgentTrunk no-mutation-retry, redirect, bounded-read and integrity extensions.');
await copy('client-extensions/typescript/workflows.ts','sdk/typescript/src/workflows.ts');
await copy('client-extensions/go/workflow.go','sdk/go/examples/workflow/main.go');
execFileSync('gofmt',['-w','sdk/go/examples/workflow'],{stdio:'pipe'});
execFileSync(process.execPath,['scripts/postprocess-extra.mjs'],{stdio:'inherit'});
execFileSync(process.execPath,['scripts/generate-cli.mjs'],{stdio:'inherit'});
