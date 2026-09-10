package agentauth

import (
	"context"
	"io"
	"net/http"
	"strings"
	"testing"
)

type transport func(*http.Request) (*http.Response, error)

func (f transport) RoundTrip(r *http.Request) (*http.Response, error) { return f(r) }
func TestAgentTrunkRegistration(t *testing.T) {
	calls := 0
	c := &http.Client{Transport: transport(func(r *http.Request) (*http.Response, error) {
		calls++
		if r.Header.Get("Authorization") != "" {
			t.Fatal("unexpected bearer header")
		}
		body := ""
		switch r.URL.Path {
		case "/.well-known/oauth-protected-resource":
			body = `{"resource":"https://api.example.com","authorization_servers":["https://auth.example.com"]}`
		case "/.well-known/oauth-authorization-server":
			body = `{"issuer":"https://auth.example.com","token_endpoint":"https://auth.example.com/token","agent_auth":{"identity_types_supported":["service_auth"],"skill":"https://auth.example.com/guide","identity_endpoint":"https://auth.example.com/identity","claim_endpoint":"https://auth.example.com/claim"}}`
		case "/identity":
			body = `{"claim":{"token":"claim","attempt":{"verification_uri":"https://auth.example.com/approve"}}}`
		case "/claim/complete":
			body = `{"identity":{"assertion":"identity","refresh_token":{"value":"refresh"}}}`
		case "/token":
			body = `{"access_token":"access","token_type":"Bearer","expires_in":300}`
		default:
			t.Fatal("unexpected request")
		}
		return &http.Response{StatusCode: 200, Body: io.NopCloser(strings.NewReader(body)), Header: make(http.Header)}, nil
	})}
	ctx := context.Background()
	r, e := Discover(ctx, "https://api.example.com", c)
	if e != nil {
		t.Fatal(e)
	}
	attempt, e := r.Start(ctx, "human@example.com")
	if e != nil {
		t.Fatal(e)
	}
	id, e := r.Complete(ctx, attempt.ClaimToken, "ABCD-EFGH")
	if e != nil {
		t.Fatal(e)
	}
	token, e := r.Exchange(ctx, id)
	if e != nil || token.AccessToken != "access" || calls != 5 {
		t.Fatal("registration failed", e)
	}
	if _, e = endpoint("https://other.example/identity", r.Issuer); e == nil {
		t.Fatal("untrusted issuer accepted")
	}
	c.Transport = transport(func(*http.Request) (*http.Response, error) {
		calls++
		return &http.Response{StatusCode: 503, Body: io.NopCloser(strings.NewReader("PRIVATE")), Header: make(http.Header)}, nil
	})
	r.client.Transport = c.Transport
	_, e = r.Start(ctx, "human@example.com")
	if e == nil || strings.Contains(e.Error(), "PRIVATE") || calls != 6 {
		t.Fatal("unsafe retry or error")
	}
}
