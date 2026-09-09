// Run from sdk/go: go run ./examples/workflow [publish|releases|read] [--execute]
package main

import (
	"context"
	"encoding/base64"
	"encoding/json"
	"fmt"
	api "github.com/aadi-labs/agenttrunk-plugins/sdk/go"
	"github.com/aadi-labs/agenttrunk-plugins/sdk/go/client"
	"github.com/aadi-labs/agenttrunk-plugins/sdk/go/option"
	"github.com/aadi-labs/agenttrunk-plugins/sdk/go/verified"
	"os"
)

func run() error {
	args := os.Args[1:]
	if len(args) == 0 {
		return fmt.Errorf("select publish, releases or read")
	}
	mode := args[0]
	execute, yes := false, false
	for _, arg := range args[1:] {
		switch arg {
		case "--execute":
			execute = true
		case "--yes":
			yes = true
		default:
			return fmt.Errorf("invalid flag")
		}
	}
	if mode != "publish" && mode != "releases" && mode != "read" {
		return fmt.Errorf("invalid workflow")
	}
	if !execute {
		return json.NewEncoder(os.Stdout).Encode(map[string]any{"workflow": mode, "preview": true, "note": "Set workspace, scope, key and runtime token; writes require --yes."})
	}
	need := func(key string) (string, error) {
		v := os.Getenv(key)
		if v == "" {
			return "", fmt.Errorf("missing configuration")
		}
		return v, nil
	}
	token, err := need("AGENTTRUNK_ACCESS_TOKEN")
	if err != nil {
		return err
	}
	workspace, err := need("AGENTTRUNK_WORKSPACE_ID")
	if err != nil {
		return err
	}
	opts := []option.RequestOption{option.WithAccessToken(token)}
	if url := os.Getenv("AGENTTRUNK_API_URL"); url != "" {
		opts = append(opts, option.WithBaseURL(url))
	}
	c := client.New(opts...)
	ctx := context.Background()
	if mode == "read" {
		key, err := need("AGENTTRUNK_CONTEXT_KEY")
		if err != nil {
			return err
		}
		rev, err := need("AGENTTRUNK_REVISION_ID")
		if err != nil {
			return err
		}
		path, err := need("AGENTTRUNK_RESOURCE_PATH")
		if err != nil {
			return err
		}
		data, err := verified.ReadFile(ctx, c, workspace, key, rev, path)
		if err != nil {
			return err
		}
		_, err = os.Stdout.Write(data)
		return err
	}
	scope, err := need("AGENTTRUNK_SCOPE_ID")
	if err != nil {
		return err
	}
	if mode == "releases" {
		result, err := c.Releases.List(ctx, workspace, &api.ListReleasesRequest{ScopeID: &scope})
		if err != nil {
			return err
		}
		return json.NewEncoder(os.Stdout).Encode(result)
	}
	if !yes {
		return fmt.Errorf("write approval required")
	}
	key, err := need("AGENTTRUNK_CONTEXT_KEY")
	if err != nil {
		return err
	}
	body := &api.PublishInput{ScopeID: &scope, ContextKey: key, Title: "Support response guidance", Kind: api.ContextKind("skill"), Files: []*api.FileInput{
		{Path: "SKILL.md", ContentBase64: base64.StdEncoding.EncodeToString([]byte("---\nname: support-response\ndescription: Draft support responses with verified facts.\n---\n\n# Support response\n\nRead references/escalation.md.\n"))},
		{Path: "references/escalation.md", ContentBase64: base64.StdEncoding.EncodeToString([]byte("# Escalation\n\nAsk the runtime to route missing facts to the support owner.\n"))},
	}}
	result, err := c.Contexts.Publish(ctx, workspace, body)
	if err != nil {
		return err
	}
	return json.NewEncoder(os.Stdout).Encode(result)
}
func main() {
	if run() != nil {
		fmt.Fprintln(os.Stderr, "Workflow failed. Check configuration and permissions; reconcile uncertain writes before retrying.")
		os.Exit(1)
	}
}
