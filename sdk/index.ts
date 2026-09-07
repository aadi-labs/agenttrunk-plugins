export type ContextKind = "skill" | "docs" | "prompt" | "policy" | "memory-schema";
export type Channel = "production" | "staging" | "latest";
export interface Page<T> { data: T[]; nextCursor?: string | null }
export interface Workspace { id: string; name: string; organizationId: string; slug: string }
export interface Scope { id: string; name: string; slug: string }
export interface FileRecord { path: string; size: number; sha256: string }
export interface Revision { id: string; packageDigest: string; files: FileRecord[] }
export interface Context { id: string; trunkId: string; scopeId: string; key: string; title: string; kind: ContextKind }
export interface InspectedContext { context: Context; revision: Revision }
export interface DiscoveryResult {
  trunkId: string; scopeId: string; contextKey: string; title: string; kind: ContextKind;
  summary: string; tags: string[]; revisionId: string; packageDigest: string; channel: Channel; updatedAt: string;
}
export interface PublishInput {
  contextKey: string; title: string; kind: ContextKind; scopeId?: string;
  summary?: string; tags?: string[]; claimedDigest?: string;
  files: { path: string; contentBase64: string }[];
}
export interface Promotion { id: string; trunkId: string; scopeId: string; status: "open" | "merged" | "closed" }
export interface ClientOptions {
  token: string | (() => string | Promise<string>);
  baseUrl?: string;
  timeoutMs?: number;
  fetch?: typeof globalThis.fetch;
}
type Query = Record<string, string | number | undefined>;

export class AgentTrunkError extends Error {
  constructor(public readonly status: number, public readonly requestId: string | null) {
    super(`AgentTrunk request failed (HTTP ${status})`);
    this.name = "AgentTrunkError";
  }
}

const segment = (value: string) => {
  if (!/^[A-Za-z0-9][A-Za-z0-9_.:-]{0,199}$/.test(value) || value === "." || value === "..") {
    throw new Error("Invalid resource identifier");
  }
  return encodeURIComponent(value);
};
export function resourcePath(value: string): string {
  if (!value || new TextEncoder().encode(value).length > 512 || /[\\\u0000-\u001f\u007f]/.test(value)
      || /[\uD800-\uDFFF]/u.test(value) || value.split("/").some(p => !p || p === "." || p === "..")) {
    throw new Error("Invalid relative resource path");
  }
  return value.split("/").map(encodeURIComponent).join("/");
}
async function boundedBody(response: Response, limit: number): Promise<Uint8Array> {
  const reader = response.body?.getReader();
  if (!reader) return new Uint8Array();
  const chunks: Uint8Array[] = [];
  let size = 0;
  try {
    while (true) {
      const {done, value} = await reader.read();
      if (done) break;
      size += value.length;
      if (size > limit) throw new Error("AgentTrunk response exceeds size limit");
      chunks.push(value);
    }
  } finally { await reader.cancel().catch(() => {}); reader.releaseLock(); }
  const bytes = new Uint8Array(size);
  let offset = 0;
  for (const chunk of chunks) { bytes.set(chunk, offset); offset += chunk.length; }
  return bytes;
}

/** One request per operation: mutations are never automatically retried. */
export class AgentTrunk {
  private readonly base: URL;
  private readonly fetcher: typeof globalThis.fetch;
  private readonly timeoutMs: number;
  constructor(private readonly options: ClientOptions) {
    this.base = new URL(options.baseUrl ?? "https://api.agenttrunk.ai");
    const loopback = ["localhost", "127.0.0.1", "[::1]"].includes(this.base.hostname);
    if ((this.base.protocol !== "https:" && !(loopback && this.base.protocol === "http:"))
        || this.base.username || this.base.password || this.base.search || this.base.hash
        || this.base.pathname !== "/") throw new Error("Use an HTTPS API origin (HTTP is allowed only on loopback)");
    this.fetcher = options.fetch ?? globalThis.fetch;
    this.timeoutMs = options.timeoutMs ?? 20_000;
    if (!Number.isInteger(this.timeoutMs) || this.timeoutMs < 1 || this.timeoutMs > 120_000) throw new Error("Invalid timeout");
  }
  private async request<T>(path: string, method = "GET", body?: unknown, query: Query = {}, binary = false): Promise<T> {
    const token = typeof this.options.token === "function" ? await this.options.token() : this.options.token;
    if (!token || /\s/.test(token)) throw new Error("A valid AgentTrunk access token is required");
    const url = new URL(`/v1${path}`, this.base);
    for (const [key, value] of Object.entries(query)) if (value !== undefined) url.searchParams.set(key, String(value));
    const serialized = body === undefined ? undefined : JSON.stringify(body);
    if (serialized && new TextEncoder().encode(serialized).length > 23_000_000) throw new Error("Request exceeds publication size limit");
    const response = await this.fetcher(url, {
      method, redirect: "error", signal: AbortSignal.timeout(this.timeoutMs),
      headers: {authorization: `Bearer ${token}`, accept: binary ? "application/octet-stream" : "application/json", ...(body === undefined ? {} : {"content-type": "application/json"})},
      body: serialized,
    });
    if (!response.ok) {
      await response.body?.cancel();
      const requestId = response.headers.get("x-request-id");
      throw new AgentTrunkError(response.status, requestId && /^[A-Za-z0-9._:-]{1,200}$/.test(requestId) ? requestId : null);
    }
    const bytes = await boundedBody(response, binary ? 1_000_000 : 24_000_000);
    return (binary ? bytes : JSON.parse(new TextDecoder().decode(bytes))) as T;
  }
  listWorkspaces(query: {cursor?: string; q?: string; limit?: number} = {}) {
    return this.request<Page<Workspace>>("/trunks", "GET", undefined, query);
  }
  createWorkspace(input: {name: string; description?: string}) {
    return this.request<Workspace>("/trunks", "POST", input);
  }
  getWorkspace(id: string) { return this.request<Workspace>(`/trunks/${segment(id)}`); }
  listScopes(id: string) { return this.request<Page<Scope>>(`/trunks/${segment(id)}/scopes`); }
  discover(query: {query?: string; trunkId?: string; scopeId?: string; channel?: Channel; cursor?: string; limit?: number} = {}) {
    return this.request<Page<DiscoveryResult>>("/contexts", "GET", undefined, query);
  }
  inspect(workspace: string, key: string, ref: string = "production") {
    return this.request<InspectedContext>(`/trunks/${segment(workspace)}/contexts/${segment(key)}`, "GET", undefined, {ref});
  }
  publish(workspace: string, input: PublishInput) {
    if (!Array.isArray(input.files) || input.files.length < 1 || input.files.length > 256) throw new Error("Publish 1–256 files");
    const paths = new Set<string>();
    for (const file of input.files) {
      resourcePath(file.path);
      if (paths.has(file.path)) throw new Error("Duplicate resource path");
      paths.add(file.path);
    }
    return this.request<InspectedContext>(`/trunks/${segment(workspace)}/publications`, "POST", input);
  }
  async readFile(workspace: string, key: string, revisionId: string, file: FileRecord): Promise<Uint8Array> {
    if (!/^[a-f0-9]{64}$/.test(revisionId)) throw new Error("File reads require an immutable revision ID; inspect the context first");
    if (!/^[a-f0-9]{64}$/.test(file.sha256) || !Number.isInteger(file.size) || file.size < 0 || file.size > 1_000_000) throw new Error("Invalid file manifest");
    const bytes = await this.request<Uint8Array>(`/trunks/${segment(workspace)}/contexts/${segment(key)}/files/${resourcePath(file.path)}`, "GET", undefined, {ref: revisionId}, true);
    const hash = new Uint8Array(await crypto.subtle.digest("SHA-256", new Uint8Array(bytes).buffer));
    const digest = Array.from(hash, b => b.toString(16).padStart(2, "0")).join("");
    if (bytes.length !== file.size || digest !== file.sha256) throw new Error("Context file integrity check failed");
    return bytes;
  }
  openPromotion(workspace: string, input: {scopeId: string; evidenceReference?: string}) {
    return this.request<Promotion>(`/trunks/${segment(workspace)}/promotion-requests`, "POST", input);
  }
  mergePromotion(workspace: string, promotion: string) {
    return this.request<Promotion>(`/trunks/${segment(workspace)}/promotion-requests/${segment(promotion)}/merge`, "POST");
  }
}
