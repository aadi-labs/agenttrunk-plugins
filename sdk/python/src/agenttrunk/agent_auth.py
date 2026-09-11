"""Human-approved agent registration. Caller owns secret persistence and approval."""
import json
import math
import re
from urllib.parse import urlsplit, urlencode
import httpx


class AgentAuthError(Exception):
    pass


def _origin(value):
    if not isinstance(value, str):
        raise AgentAuthError("invalid_origin")
    u = urlsplit(value)
    if u.scheme != "https" or not u.netloc or u.username or u.password or u.path not in ("", "/") or u.query or u.fragment:
        raise AgentAuthError("invalid_origin")
    return f"https://{u.netloc}"


def _endpoint(value, issuer):
    if not isinstance(value, str):
        raise AgentAuthError("invalid_discovery")
    u = urlsplit(value)
    if f"{u.scheme}://{u.netloc}" != issuer or u.username or u.password or u.fragment:
        raise AgentAuthError("untrusted_endpoint")
    return value


def _secret(value):
    if not isinstance(value, str) or not value or len(value) > 32768 or re.search(r"\s", value):
        raise AgentAuthError("invalid_credentials")
    return value


class AgentRegistration:
    def __init__(self, resource, issuer, server, client):
        self.resource, self.issuer, self._client = resource, issuer, client
        auth = server["agent_auth"]
        self.guide = _endpoint(auth.get("skill"), issuer)
        self._identity = _endpoint(auth.get("identity_endpoint"), issuer)
        self._claim = _endpoint(auth.get("claim_endpoint"), issuer)
        self._token = _endpoint(server.get("token_endpoint"), issuer)

    @staticmethod
    def _json(client, url, body=None, form=False):
        headers = {} if body is None else {"content-type": "application/x-www-form-urlencoded" if form else "application/json"}
        content = None if body is None else (urlencode(body) if form else json.dumps(body))
        try:
            with client.stream("GET" if body is None else "POST", url, headers=headers,
                               content=content, follow_redirects=False, timeout=15) as response:
                if not 200 <= response.status_code < 300:
                    raise AgentAuthError(f"request_rejected:{response.status_code}")
                data = bytearray()
                for chunk in response.iter_bytes():
                    data.extend(chunk)
                    if len(data) > 131072:
                        raise AgentAuthError("response_too_large")
                result = json.loads(data)
                if not isinstance(result, dict):
                    raise AgentAuthError("invalid_response")
                return result
        except AgentAuthError:
            raise
        except Exception:
            raise AgentAuthError("invalid_response_or_network") from None

    @classmethod
    def discover(cls, resource="https://api.agenttrunk.ai", *, client=None):
        client = client or httpx.Client(follow_redirects=False, timeout=15)
        api = _origin(resource)
        metadata = cls._json(client, api + "/.well-known/oauth-protected-resource")
        servers = metadata.get("authorization_servers")
        if metadata.get("resource") != api or not isinstance(servers, list) or len(servers) != 1:
            raise AgentAuthError("invalid_discovery")
        issuer = _origin(servers[0])
        server = cls._json(client, issuer + "/.well-known/oauth-authorization-server")
        if server.get("issuer") != issuer or "service_auth" not in server.get("agent_auth", {}).get("identity_types_supported", []):
            raise AgentAuthError("registration_unavailable")
        return cls(api, issuer, server, client)

    def start(self, email):
        if not isinstance(email, str) or len(email) > 254 or not re.fullmatch(r"[^\s@]+@[^\s@]+\.[^\s@]+", email):
            raise AgentAuthError("invalid_email")
        result = self._json(self._client, self._identity, {"type": "service_auth", "login_hint": email})
        claim = result.get("claim", {})
        token = _secret(claim.get("token"))
        attempt = claim.get("attempt")
        if attempt is None:
            attempt = self._json(self._client, self._claim, {"type": "service_auth", "login_hint": email, "claim_token": token}).get("attempt", {})
        return {"claim_token": token, "verification_uri": _endpoint(attempt.get("verification_uri"), self.issuer)}

    @staticmethod
    def _parse_identity(value):
        if not isinstance(value, dict):
            raise AgentAuthError("invalid_credentials")
        result = {"assertion": _secret(value.get("assertion"))}
        if value.get("refresh_token") is not None:
            result["refresh_token"] = {"value": _secret(value["refresh_token"].get("value"))}
        return result

    def complete(self, claim_token, user_code):
        if not isinstance(user_code, str) or not re.fullmatch(r"[A-Za-z0-9-]{4,32}", user_code):
            raise AgentAuthError("invalid_user_code")
        # WorkOS displays separators, but its completion endpoint expects raw code characters.
        user_code = user_code.replace("-", "")
        if not re.fullmatch(r"[A-Za-z0-9]{4,32}", user_code):
            raise AgentAuthError("invalid_user_code")
        result = self._json(self._client, self._claim + "/complete", {"claim_token": _secret(claim_token), "user_code": user_code})
        return self._parse_identity(result.get("identity"))

    def exchange(self, identity):
        result = self._json(self._client, self._token, {"grant_type": "urn:ietf:params:oauth:grant-type:jwt-bearer", "assertion": _secret(identity.get("assertion")), "resource": self.resource}, form=True)
        ttl = result.get("expires_in")
        if str(result.get("token_type", "")).lower() != "bearer" or isinstance(ttl, bool) or not isinstance(ttl, (int, float)) or not math.isfinite(ttl) or ttl <= 0:
            raise AgentAuthError("invalid_credentials")
        return {"access_token": _secret(result.get("access_token")), "expires_in": ttl}

    def refresh(self, identity):
        result = self._json(self._client, self._identity, {"type": "refresh", "refresh_token": _secret(identity.get("refresh_token", {}).get("value"))})
        return self._parse_identity(result.get("identity"))

    def close(self):
        self._client.close()
