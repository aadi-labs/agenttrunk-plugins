package verified_test

import (
	"context"
	"crypto/sha256"
	"encoding/json"
	"fmt"
	api "github.com/aadi-labs/agenttrunk-plugins/sdk/go"
	"github.com/aadi-labs/agenttrunk-plugins/sdk/go/client"
	"github.com/aadi-labs/agenttrunk-plugins/sdk/go/option"
	"github.com/aadi-labs/agenttrunk-plugins/sdk/go/verified"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
)

func TestAgentTrunkNoMutationRetries(t *testing.T) {
	for _, status := range []int{401, 403, 409, 429, 503} {
		t.Run(fmt.Sprint(status), func(t *testing.T) {
			calls := 0
			server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				calls++
				w.WriteHeader(status)
				fmt.Fprint(w, "SENSITIVE_RESPONSE")
			}))
			defer server.Close()
			c := client.New(option.WithBaseURL(server.URL), option.WithAccessToken("test"), option.WithMaxAttempts(3))
			_, err := c.Workspaces.Create(context.Background(), &api.CreateTrunkInput{Name: "Support"})
			if err == nil || strings.Contains(err.Error(), "SENSITIVE") || calls != 1 {
				t.Fatalf("unsafe mutation behavior: calls=%d error=%v", calls, err)
			}
		})
	}
}
func TestAgentTrunkNoRedirects(t *testing.T) {
	calls := 0
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) { calls++; http.Redirect(w, r, "/target", 302) }))
	defer server.Close()
	c := client.New(option.WithBaseURL(server.URL), option.WithAccessToken("test"))
	_, err := c.Workspaces.List(context.Background(), &api.ListWorkspacesRequest{})
	if err == nil || calls != 1 {
		t.Fatalf("redirect followed: %d", calls)
	}
}
func TestAgentTrunkVerifiedRead(t *testing.T) {
	revision := strings.Repeat("a", 64)
	content := []byte("# verified context")
	for _, corrupt := range []bool{false, true} {
		server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			if r.URL.Query().Get("ref") != revision {
				t.Error("revision not pinned")
			}
			if strings.Contains(r.URL.Path, "/files/") {
				if corrupt {
					fmt.Fprint(w, "tampered")
				} else {
					w.Write(content)
				}
				return
			}
			json.NewEncoder(w).Encode(map[string]any{"context": map[string]any{"key": "support"}, "revision": map[string]any{"id": revision, "packageDigest": strings.Repeat("b", 64), "files": []any{map[string]any{"path": "SKILL.md", "size": len(content), "sha256": fmt.Sprintf("%x", sha256.Sum256(content))}}}})
		}))
		c := client.New(option.WithBaseURL(server.URL), option.WithAccessToken("test"))
		result, err := verified.ReadFile(context.Background(), c, "trunk_1", "support", revision, "SKILL.md")
		server.Close()
		if corrupt {
			if err == nil {
				t.Fatal("accepted corrupt bytes")
			}
		} else if err != nil || string(result) != string(content) {
			t.Fatalf("read failed: %v", err)
		}
	}
}
func TestAgentTrunkBoundsAndPin(t *testing.T) {
	calls := 0
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) { calls++; fmt.Fprint(w, strings.Repeat("x", 1_000_001)) }))
	defer server.Close()
	c := client.New(option.WithBaseURL(server.URL), option.WithAccessToken("test"))
	_, err := c.Contexts.ReadFile(context.Background(), "trunk_1", "support", "SKILL.md", &api.ReadFileContextsRequest{Ref: "production"})
	if err == nil || calls != 0 {
		t.Fatal("moving ref reached network")
	}
	_, err = c.Contexts.ReadFile(context.Background(), "trunk_1", "support", "SKILL.md", &api.ReadFileContextsRequest{Ref: strings.Repeat("a", 64)})
	if err == nil || !strings.Contains(err.Error(), "size limit") {
		t.Fatalf("size limit failed: %v", err)
	}
}
