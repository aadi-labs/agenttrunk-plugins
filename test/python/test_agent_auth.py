import unittest
import json
import httpx
from agenttrunk.agent_auth import AgentRegistration, AgentAuthError


class RegistrationTests(unittest.TestCase):
    def fixture(self, reject=False):
        calls = []
        issuer = "https://auth.example.com"
        def send(request):
            calls.append(request)
            path = request.url.path
            if path == "/.well-known/oauth-protected-resource":
                data = {"resource": "https://api.example.com", "authorization_servers": [issuer]}
            elif path == "/.well-known/oauth-authorization-server":
                data = {"issuer": issuer, "token_endpoint": issuer + "/token", "agent_auth": {
                    "identity_types_supported": ["service_auth"], "identity_endpoint": issuer + "/identity",
                    "claim_endpoint": issuer + "/claim", "skill": issuer + "/guide"}}
            elif reject:
                return httpx.Response(503, text="PRIVATE ERROR")
            elif path == "/identity":
                if b'refresh_token' in request.content:
                    data = {"identity": {"assertion": "new", "refresh_token": {"value": "rotated"}}}
                else:
                    data = {"claim": {"token": "claim", "attempt": {"verification_uri": issuer + "/approve"}}}
            elif path == "/claim/complete":
                data = {"identity": {"assertion": "identity", "refresh_token": {"value": "refresh"}}}
            elif path == "/token":
                data = {"access_token": "access", "token_type": "Bearer", "expires_in": 300}
            else:
                self.fail("unexpected request")
            return httpx.Response(200, json=data)
        return httpx.Client(transport=httpx.MockTransport(send)), calls

    def test_registration_exchange_rotation(self):
        client, calls = self.fixture()
        auth = AgentRegistration.discover("https://api.example.com", client=client)
        attempt = auth.start("human@example.com")
        self.assertEqual(attempt["verification_uri"], "https://auth.example.com/approve")
        identity = auth.complete(attempt["claim_token"], "ABCD-EFGH")
        self.assertEqual(auth.exchange(identity)["access_token"], "access")
        self.assertEqual(auth.refresh(identity)["refresh_token"]["value"], "rotated")
        self.assertEqual(len(calls), 6)
        auth.close()

    def test_failed_write_is_not_retried_or_exposed(self):
        client, calls = self.fixture(reject=True)
        auth = AgentRegistration.discover("https://api.example.com", client=client)
        with self.assertRaisesRegex(AgentAuthError, "request_rejected:503"):
            auth.start("human@example.com")
        self.assertEqual(len(calls), 3)
        with self.assertRaises(AgentAuthError):
            auth.complete("claim", "bad code")
        self.assertEqual(len(calls), 3)
        auth.close()

    def test_redirect_and_untrusted_endpoint(self):
        client = httpx.Client(transport=httpx.MockTransport(lambda request: httpx.Response(302, headers={"location":"https://evil.example"})))
        with self.assertRaisesRegex(AgentAuthError,"request_rejected:302"):
            AgentRegistration.discover("https://api.example.com",client=client)
        client.close()

    def test_claim_completion_removes_display_hyphens(self):
        for code in ("ABCD-EFGH", "ABCDEFGH"):
            with self.subTest(code=code):
                client, calls = self.fixture()
                auth = AgentRegistration.discover("https://api.example.com", client=client)
                identity = auth.complete("claim", code)
                self.assertEqual(identity["assertion"], "identity")
                self.assertEqual(json.loads(calls[-1].content)["user_code"], "ABCDEFGH")
                self.assertEqual(len(calls), 3)
                auth.close()

    def test_claim_completion_rejects_invalid_normalized_codes_before_request(self):
        client, calls = self.fixture()
        auth = AgentRegistration.discover("https://api.example.com", client=client)
        for code in ("----", "A---", "AB CD", "ABCD/EFGH", "ABCD\u2011EFGH"):
            with self.subTest(code=code), self.assertRaisesRegex(AgentAuthError, "invalid_user_code"):
                auth.complete("claim", code)
        self.assertEqual(len(calls), 2)
        auth.close()
