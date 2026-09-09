/** AgentTrunk transport policy. Copied by scripts/postprocess-sdks.mjs. */
export function validateRequest(url: string, headers: Headers | Record<string, string>): void {
  const target = new URL(url);
  const loopback = ['localhost', '127.0.0.1', '[::1]'].includes(target.hostname);
  if ((target.protocol !== 'https:' && !(target.protocol === 'http:' && loopback)) || target.username || target.password || target.hash) {
    throw new Error('Use a trusted HTTPS API origin (HTTP loopback only for tests)');
  }
  const authorization = new globalThis.Headers(headers).get('authorization');
  if (target.pathname.startsWith('/v1/') && (!authorization || !/^Bearer \S+$/.test(authorization))) throw new Error('AgentTrunk access token required');
  if (target.pathname.includes('/files/') && !/^[a-f0-9]{64}$/.test(target.searchParams.get('ref') ?? '')) throw new Error('File reads require an immutable revision ID');
}

export async function boundedResponse(response: Response, url: string): Promise<Response> {
  if (!response.ok) {
    await response.body?.cancel();
    const requestId = response.headers.get('x-request-id');
    const headers = new Headers();
    if (requestId && /^[A-Za-z0-9._:-]{1,200}$/.test(requestId)) headers.set('x-request-id', requestId);
    return new Response(null, {status: response.status, headers});
  }
  if (!response.body) return response;
  const limit = new URL(url).pathname.includes('/files/') ? 1_000_000 : 24_000_000;
  const reader = response.body.getReader();
  const chunks: Uint8Array[] = [];
  let size = 0;
  try {
    while (true) {
      const {done, value} = await reader.read();
      if (done) break;
      size += value.length;
      if (size > limit) throw new Error('AgentTrunk response exceeds size limit');
      chunks.push(value);
    }
  } finally {await reader.cancel().catch(() => {}); reader.releaseLock();}
  const bytes = new Uint8Array(size);
  let offset = 0;
  for (const chunk of chunks) {bytes.set(chunk, offset); offset += chunk.length;}
  // Buffering is bounded and keeps the fetch timeout active until all bytes arrive.
  return new Response(bytes, {status: response.status, headers: response.headers});
}
