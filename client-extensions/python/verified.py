"""Verified immutable file helpers for sync and async generated clients."""
import hashlib
import re


def _manifest(inspected, revision_id, path):
    if not re.fullmatch(r'[a-f0-9]{64}', revision_id) or inspected.revision.id != revision_id:
        raise ValueError('Immutable revision mismatch')
    if not path or len(path.encode()) > 512 or '\\' in path or any(ord(c) < 32 or ord(c) == 127 for c in path) or any(part in ('', '.', '..') for part in path.split('/')):
        raise ValueError('Invalid resource path')
    file = next((file for file in inspected.revision.files if file.path == path), None)
    if file is None or not 0 <= file.size <= 1_000_000 or not re.fullmatch(r'[a-f0-9]{64}', file.sha256):
        raise ValueError('Invalid file manifest')
    return file


def _verify(content, file):
    if len(content) != file.size or hashlib.sha256(content).hexdigest() != file.sha256:
        raise ValueError('Context file integrity check failed')
    return content


def read_verified_file(client, workspace_id, context_key, revision_id, path):
    if not re.fullmatch(r'[a-f0-9]{64}', revision_id):
        raise ValueError('An immutable revision ID is required')
    inspected = client.contexts.inspect(workspace_id, context_key, ref=revision_id)
    file = _manifest(inspected, revision_id, path)
    chunks, size = [], 0
    for chunk in client.contexts.read_file(workspace_id, context_key, path, ref=revision_id):
        size += len(chunk)
        if size > 1_000_000:
            raise ValueError('Context file exceeds size limit')
        chunks.append(chunk)
    return _verify(b''.join(chunks), file)


async def async_read_verified_file(client, workspace_id, context_key, revision_id, path):
    if not re.fullmatch(r'[a-f0-9]{64}', revision_id):
        raise ValueError('An immutable revision ID is required')
    inspected = await client.contexts.inspect(workspace_id, context_key, ref=revision_id)
    file = _manifest(inspected, revision_id, path)
    chunks, size = [], 0
    async for chunk in client.contexts.read_file(workspace_id, context_key, path, ref=revision_id):
        size += len(chunk)
        if size > 1_000_000:
            raise ValueError('Context file exceeds size limit')
        chunks.append(chunk)
    return _verify(b''.join(chunks), file)
