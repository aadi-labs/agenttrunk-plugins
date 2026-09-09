"""AgentTrunk transport policy; copied into generated core by postprocessing."""
from contextlib import contextmanager, asynccontextmanager
import re
import httpx


def _request(client, kwargs):
    request = client.build_request(**kwargs)
    target = request.url
    if (target.scheme != 'https' and not (target.scheme == 'http' and target.host in ('localhost', '127.0.0.1', '::1'))) or target.userinfo or target.fragment:
        raise ValueError('Use a trusted HTTPS API origin (HTTP loopback only for tests)')
    if target.path.startswith('/v1/') and not re.fullmatch(r'Bearer \S+', request.headers.get('authorization', '')):
        raise ValueError('AgentTrunk access token required')
    if '/files/' in target.path and not re.fullmatch(r'[a-f0-9]{64}', target.params.get('ref', '')):
        raise ValueError('File reads require an immutable revision ID')
    return request


def _limit(request):
    return 1_000_000 if '/files/' in request.url.path else 24_000_000


def _error(response):
    request_id = response.headers.get('x-request-id', '')
    headers = {'x-request-id': request_id} if re.fullmatch(r'[A-Za-z0-9._:-]{1,200}', request_id) else {}
    return httpx.Response(response.status_code, headers=headers, content=b'', request=response.request)


def bounded_request(client, **kwargs):
    request = _request(client, kwargs)
    response = client.send(request, stream=True, follow_redirects=False)
    try:
        if not response.is_success:
            return _error(response)
        chunks = []
        size = 0
        for chunk in response.iter_bytes():
            size += len(chunk)
            if size > _limit(request):
                raise ValueError('AgentTrunk response exceeds size limit')
            chunks.append(chunk)
        # Bytes have already been decoded by httpx; remove transport encodings.
        headers = {k: v for k, v in response.headers.items() if k not in ('content-encoding', 'content-length')}
        return httpx.Response(response.status_code, headers=headers, content=b''.join(chunks), request=request)
    finally:
        response.close()


async def async_bounded_request(client, **kwargs):
    request = _request(client, kwargs)
    response = await client.send(request, stream=True, follow_redirects=False)
    try:
        if not response.is_success:
            return _error(response)
        chunks = []
        size = 0
        async for chunk in response.aiter_bytes():
            size += len(chunk)
            if size > _limit(request):
                raise ValueError('AgentTrunk response exceeds size limit')
            chunks.append(chunk)
        headers = {k: v for k, v in response.headers.items() if k not in ('content-encoding', 'content-length')}
        return httpx.Response(response.status_code, headers=headers, content=b''.join(chunks), request=request)
    finally:
        await response.aclose()


# Files are at most 1 MB, so verified reads intentionally buffer before consumption.
@contextmanager
def bounded_stream(client, **kwargs):
    response = bounded_request(client, **kwargs)
    try:
        yield response
    finally:
        response.close()


@asynccontextmanager
async def async_bounded_stream(client, **kwargs):
    response = await async_bounded_request(client, **kwargs)
    try:
        yield response
    finally:
        await response.aclose()
