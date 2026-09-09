import asyncio
import hashlib
import unittest
import httpx
from agenttrunk import AgentTrunk, AsyncAgentTrunk
from agenttrunk.verified import read_verified_file, async_read_verified_file

REVISION = 'a' * 64
CONTENT = b'# verified context'
MANIFEST = {'context': {'id':'context_1','trunkId':'trunk_1','scopeId':'scope_1','key':'support','title':'Support','kind':'skill','summary':'Support guide','tags':[],'createdAt':'2026-09-08T00:00:00Z','updatedAt':'2026-09-08T00:00:00Z'}, 'revision': {'id': REVISION, 'contextId':'context_1','createdAt':'2026-09-08T00:00:00Z', 'packageDigest': 'b'*64, 'files': [{'path': 'SKILL.md', 'size': len(CONTENT), 'sha256': hashlib.sha256(CONTENT).hexdigest()}]}}

class SDKTests(unittest.TestCase):
    def test_discovery_continuation_and_callback(self):
        calls = []
        def handler(request):
            calls.append(request)
            self.assertEqual(request.url.params['trunkId'], 'trunk_1')
            self.assertEqual(request.headers['authorization'], f'Bearer test-{len(calls)}')
            return httpx.Response(200, json={'data': [], 'nextCursor': 'continue'})
        with httpx.Client(transport=httpx.MockTransport(handler)) as http:
            c = AgentTrunk(access_token=lambda: f'test-{len(calls)+1}', httpx_client=http)
            self.assertEqual(c.contexts.discover(trunk_id='trunk_1', channel='production').next_cursor, 'continue')
            c.contexts.discover(trunk_id='trunk_1', cursor='continue')
        self.assertEqual(len(calls), 2)

    def test_mutations_never_retry_or_expose_error_bodies(self):
        for status in (401,403,409,429,503):
            calls = []
            def handler(request):
                calls.append(request)
                return httpx.Response(status, text='SENSITIVE_RESPONSE')
            with httpx.Client(transport=httpx.MockTransport(handler)) as http:
                c = AgentTrunk(access_token='test', httpx_client=http, max_retries=3)
                with self.assertRaises(Exception) as caught:
                    c.workspaces.create(name='Support')
                self.assertNotIn('SENSITIVE', str(caught.exception))
                self.assertEqual(caught.exception.status_code, status)
            self.assertEqual(len(calls), 1)

    def test_redirect_and_lost_response_not_retried(self):
        for failure in ('redirect','network'):
            calls = []
            def handler(request):
                calls.append(request)
                if failure == 'network': raise httpx.ConnectError('failed', request=request)
                return httpx.Response(302, headers={'location': 'https://other.example/target'})
            with httpx.Client(transport=httpx.MockTransport(handler), follow_redirects=True) as http:
                c = AgentTrunk(access_token='test', httpx_client=http, max_retries=3)
                with self.assertRaises(Exception): c.workspaces.create(name='Support')
            self.assertEqual(len(calls), 1)

    def test_verified_read_and_integrity_failure(self):
        for corrupt in (False, True):
            def handler(request):
                self.assertEqual(request.url.params['ref'], REVISION)
                if '/files/' in request.url.path:
                    return httpx.Response(200, content=b'tampered' if corrupt else CONTENT)
                return httpx.Response(200, json=MANIFEST)
            with httpx.Client(transport=httpx.MockTransport(handler)) as http:
                c = AgentTrunk(access_token='test', httpx_client=http)
                if corrupt:
                    with self.assertRaisesRegex(ValueError, 'integrity'): read_verified_file(c, 'trunk_1', 'support', REVISION, 'SKILL.md')
                else: self.assertEqual(read_verified_file(c, 'trunk_1', 'support', REVISION, 'SKILL.md'), CONTENT)

    def test_unpinned_and_oversized_reads(self):
        calls = []
        def handler(request):
            calls.append(request)
            return httpx.Response(200, content=b'x'*1_000_001)
        with httpx.Client(transport=httpx.MockTransport(handler)) as http:
            c = AgentTrunk(access_token='test', httpx_client=http)
            with self.assertRaisesRegex(ValueError, 'immutable'): list(c.contexts.read_file('trunk_1','support','SKILL.md',ref='production'))
            self.assertEqual(len(calls),0)
            with self.assertRaisesRegex(ValueError, 'size limit'): list(c.contexts.read_file('trunk_1','support','SKILL.md',ref=REVISION))

    def test_async_verified_read(self):
        async def run():
            def handler(request):
                return httpx.Response(200, content=CONTENT) if '/files/' in request.url.path else httpx.Response(200,json=MANIFEST)
            async with httpx.AsyncClient(transport=httpx.MockTransport(handler)) as http:
                c = AsyncAgentTrunk(access_token='test',httpx_client=http)
                self.assertEqual(await async_read_verified_file(c,'trunk_1','support',REVISION,'SKILL.md'),CONTENT)
        asyncio.run(run())

if __name__ == '__main__': unittest.main()
