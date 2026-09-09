package main

import (
	"context"
	"fmt"
	api "github.com/aadi-labs/agenttrunk-plugins/sdk/go"
	"github.com/aadi-labs/agenttrunk-plugins/sdk/go/client"
	"github.com/aadi-labs/agenttrunk-plugins/sdk/go/option"
	"os"
	"time"
)

func run() error {
	token := os.Getenv("AGENTTRUNK_ACCESS_TOKEN")
	if token == "" {
		return fmt.Errorf("missing token")
	}
	c := client.New(option.WithAccessToken(token))
	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()
	var cursor *string
	for pageIndex := 0; pageIndex < 10; pageIndex++ {
		page, err := c.Workspaces.List(ctx, &api.ListWorkspacesRequest{Cursor: cursor})
		if err != nil {
			return err
		}
		for _, workspace := range page.Data {
			fmt.Println(workspace.ID, workspace.Name)
		}
		if page.NextCursor == nil || *page.NextCursor == "" {
			return nil
		}
		cursor = page.NextCursor
	}
	fmt.Println("Partial results: page budget reached; resume with the next cursor in your runtime.")
	return nil
}
func main() {
	if err := run(); err != nil {
		fmt.Fprintln(os.Stderr, "AgentTrunk request failed; check access, configuration and network.")
		os.Exit(1)
	}
}
