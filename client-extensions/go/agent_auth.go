// Package agentauth implements human-approved registration; callers own secret storage.
package agentauth

import (
	"bytes"
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"math"
	"net/http"
	"net/url"
	"regexp"
	"strings"
	"time"
)

type Identity struct {
	Assertion    string        `json:"assertion"`
	RefreshToken *RefreshToken `json:"refresh_token,omitempty"`
}
type RefreshToken struct {
	Value string `json:"value"`
}
type Attempt struct {
	ClaimToken      string
	VerificationURI string
}
type Token struct {
	AccessToken string
	ExpiresIn   float64
}
type Registration struct {
	Resource, Issuer, Guide string
	identity, claim, token  string
	client                  *http.Client
}

func origin(value string) (string, error) {
	u, e := url.Parse(value)
	if e != nil || u.Scheme != "https" || u.Host == "" || u.User != nil || (u.Path != "" && u.Path != "/") || u.RawQuery != "" || u.Fragment != "" {
		return "", errors.New("invalid origin")
	}
	return "https://" + u.Host, nil
}
func endpoint(value, issuer string) (string, error) {
	u, e := url.Parse(value)
	if e != nil || u.Scheme+"://"+u.Host != issuer || u.User != nil || u.Fragment != "" {
		return "", errors.New("untrusted endpoint")
	}
	return value, nil
}
func secret(value string) error {
	if value == "" || len(value) > 32768 || strings.ContainsAny(value, " \t\r\n") {
		return errors.New("invalid credentials")
	}
	return nil
}
func (r *Registration) request(ctx context.Context, address string, body any, form bool) (map[string]json.RawMessage, error) {
	var data []byte
	var err error
	method := "GET"
	contentType := "application/json"
	if body != nil {
		method = "POST"
		if form {
			data = []byte(body.(url.Values).Encode())
			contentType = "application/x-www-form-urlencoded"
		} else {
			data, err = json.Marshal(body)
			if err != nil {
				return nil, errors.New("invalid request")
			}
		}
	}
	req, err := http.NewRequestWithContext(ctx, method, address, bytes.NewReader(data))
	if err != nil {
		return nil, errors.New("invalid request")
	}
	if body != nil {
		req.Header.Set("Content-Type", contentType)
	}
	response, err := r.client.Do(req)
	if err != nil {
		return nil, errors.New("authentication network failure")
	}
	defer response.Body.Close()
	if response.StatusCode < 200 || response.StatusCode >= 300 {
		return nil, fmt.Errorf("authentication rejected (HTTP %d)", response.StatusCode)
	}
	data, err = io.ReadAll(io.LimitReader(response.Body, 131073))
	if err != nil || len(data) > 131072 {
		return nil, errors.New("invalid authentication response")
	}
	var result map[string]json.RawMessage
	if json.Unmarshal(data, &result) != nil || result == nil {
		return nil, errors.New("invalid authentication response")
	}
	return result, nil
}
func field[T any](data map[string]json.RawMessage, key string) (T, error) {
	var value T
	raw, ok := data[key]
	if !ok || json.Unmarshal(raw, &value) != nil {
		return value, errors.New("invalid authentication response")
	}
	return value, nil
}
func Discover(ctx context.Context, resource string, client *http.Client) (*Registration, error) {
	api, err := origin(resource)
	if err != nil {
		return nil, err
	}
	c := http.Client{Timeout: 15 * time.Second}
	if client != nil {
		c = *client
	}
	c.CheckRedirect = func(*http.Request, []*http.Request) error { return http.ErrUseLastResponse }
	c.Jar = nil
	if c.Timeout == 0 {
		c.Timeout = 15 * time.Second
	}
	r := &Registration{Resource: api, client: &c}
	meta, err := r.request(ctx, api+"/.well-known/oauth-protected-resource", nil, false)
	if err != nil {
		return nil, err
	}
	named, err := field[string](meta, "resource")
	if err != nil || named != api {
		return nil, errors.New("invalid resource")
	}
	servers, err := field[[]string](meta, "authorization_servers")
	if err != nil || len(servers) != 1 {
		return nil, errors.New("invalid discovery")
	}
	r.Issuer, err = origin(servers[0])
	if err != nil {
		return nil, err
	}
	server, err := r.request(ctx, r.Issuer+"/.well-known/oauth-authorization-server", nil, false)
	if err != nil {
		return nil, err
	}
	named, err = field[string](server, "issuer")
	if err != nil || named != r.Issuer {
		return nil, errors.New("invalid issuer")
	}
	auth, err := field[map[string]json.RawMessage](server, "agent_auth")
	if err != nil {
		return nil, err
	}
	types, err := field[[]string](auth, "identity_types_supported")
	if err != nil {
		return nil, err
	}
	found := false
	for _, t := range types {
		if t == "service_auth" {
			found = true
		}
	}
	if !found {
		return nil, errors.New("registration unavailable")
	}
	for key, target := range map[string]*string{"skill": &r.Guide, "identity_endpoint": &r.identity, "claim_endpoint": &r.claim} {
		value, e := field[string](auth, key)
		if e != nil {
			return nil, e
		}
		*target, e = endpoint(value, r.Issuer)
		if e != nil {
			return nil, e
		}
	}
	value, err := field[string](server, "token_endpoint")
	if err != nil {
		return nil, err
	}
	r.token, err = endpoint(value, r.Issuer)
	return r, err
}
func (r *Registration) Start(ctx context.Context, email string) (Attempt, error) {
	if len(email) > 254 || !regexp.MustCompile(`^[^\s@]+@[^\s@]+\.[^\s@]+$`).MatchString(email) {
		return Attempt{}, errors.New("invalid email")
	}
	result, err := r.request(ctx, r.identity, map[string]string{"type": "service_auth", "login_hint": email}, false)
	if err != nil {
		return Attempt{}, err
	}
	claim, err := field[map[string]json.RawMessage](result, "claim")
	if err != nil {
		return Attempt{}, err
	}
	token, err := field[string](claim, "token")
	if err != nil {
		return Attempt{}, err
	}
	if err = secret(token); err != nil {
		return Attempt{}, err
	}
	var attempt map[string]json.RawMessage
	if raw, ok := claim["attempt"]; ok {
		if json.Unmarshal(raw, &attempt) != nil || attempt == nil {
			return Attempt{}, errors.New("invalid attempt")
		}
	} else {
		result, err = r.request(ctx, r.claim, map[string]string{"type": "service_auth", "login_hint": email, "claim_token": token}, false)
		if err != nil {
			return Attempt{}, err
		}
		attempt, err = field[map[string]json.RawMessage](result, "attempt")
		if err != nil {
			return Attempt{}, err
		}
	}
	uri, err := field[string](attempt, "verification_uri")
	if err != nil {
		return Attempt{}, err
	}
	uri, err = endpoint(uri, r.Issuer)
	return Attempt{token, uri}, err
}
func identity(result map[string]json.RawMessage) (Identity, error) {
	v, e := field[Identity](result, "identity")
	if e != nil {
		return v, e
	}
	if e = secret(v.Assertion); e != nil {
		return Identity{}, e
	}
	if v.RefreshToken != nil {
		e = secret(v.RefreshToken.Value)
	}
	return v, e
}
func (r *Registration) Complete(ctx context.Context, claim, code string) (Identity, error) {
	if secret(claim) != nil || !regexp.MustCompile(`^[A-Za-z0-9-]{4,32}$`).MatchString(code) {
		return Identity{}, errors.New("invalid claim or code")
	}
	result, err := r.request(ctx, r.claim+"/complete", map[string]string{"claim_token": claim, "user_code": code}, false)
	if err != nil {
		return Identity{}, err
	}
	return identity(result)
}
func (r *Registration) Exchange(ctx context.Context, id Identity) (Token, error) {
	if err := secret(id.Assertion); err != nil {
		return Token{}, err
	}
	result, err := r.request(ctx, r.token, url.Values{"grant_type": {"urn:ietf:params:oauth:grant-type:jwt-bearer"}, "assertion": {id.Assertion}, "resource": {r.Resource}}, true)
	if err != nil {
		return Token{}, err
	}
	kind, e := field[string](result, "token_type")
	if e != nil || strings.ToLower(kind) != "bearer" {
		return Token{}, errors.New("invalid token type")
	}
	ttl, e := field[float64](result, "expires_in")
	if e != nil || ttl <= 0 || math.IsInf(ttl, 0) || math.IsNaN(ttl) {
		return Token{}, errors.New("invalid token lifetime")
	}
	access, e := field[string](result, "access_token")
	if e != nil {
		return Token{}, e
	}
	return Token{access, ttl}, secret(access)
}
func (r *Registration) Refresh(ctx context.Context, id Identity) (Identity, error) {
	if id.RefreshToken == nil || secret(id.RefreshToken.Value) != nil {
		return Identity{}, errors.New("missing refresh token")
	}
	result, err := r.request(ctx, r.identity, map[string]string{"type": "refresh", "refresh_token": id.RefreshToken.Value}, false)
	if err != nil {
		return Identity{}, err
	}
	return identity(result)
}
