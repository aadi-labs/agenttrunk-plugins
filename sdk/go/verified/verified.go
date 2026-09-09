// Package verified provides bounded, integrity-checked reads on top of the Fern client.
package verified

import (
	"context"
	"crypto/sha256"
	"fmt"
	api "github.com/aadi-labs/agenttrunk-plugins/sdk/go"
	"github.com/aadi-labs/agenttrunk-plugins/sdk/go/client"
	"io"
	"regexp"
	"strings"
	"unicode/utf8"
)

var digest = regexp.MustCompile(`^[a-f0-9]{64}$`)

func ReadFile(ctx context.Context, c *client.AgentTrunk, workspace, key, revision, path string) ([]byte, error) {
	if !digest.MatchString(revision) {
		return nil, fmt.Errorf("immutable revision ID required")
	}
	if len(path) == 0 || len(path) > 512 || !utf8.ValidString(path) || strings.Contains(path, "\\") {
		return nil, fmt.Errorf("invalid resource path")
	}
	for _, char := range path {
		if char < 32 || char == 127 {
			return nil, fmt.Errorf("invalid resource path")
		}
	}
	for _, part := range strings.Split(path, "/") {
		if part == "" || part == "." || part == ".." {
			return nil, fmt.Errorf("invalid resource path")
		}
	}
	inspected, err := c.Contexts.Inspect(ctx, workspace, key, &api.InspectContextsRequest{Ref: &revision})
	if err != nil {
		return nil, err
	}
	if inspected.Revision == nil || inspected.Revision.ID != revision {
		return nil, fmt.Errorf("revision mismatch")
	}
	var file *api.FileRecord
	for _, item := range inspected.Revision.Files {
		if item.Path == path {
			file = item
			break
		}
	}
	if file == nil || file.Size < 0 || file.Size > 1_000_000 || !digest.MatchString(file.Sha256) {
		return nil, fmt.Errorf("invalid file manifest")
	}
	reader, err := c.Contexts.ReadFile(ctx, workspace, key, path, &api.ReadFileContextsRequest{Ref: revision})
	if err != nil {
		return nil, err
	}
	if closer, ok := reader.(io.Closer); ok {
		defer closer.Close()
	}
	content, err := io.ReadAll(io.LimitReader(reader, 1_000_001))
	if err != nil {
		return nil, err
	}
	if len(content) != file.Size || fmt.Sprintf("%x", sha256.Sum256(content)) != file.Sha256 {
		return nil, fmt.Errorf("context file integrity check failed")
	}
	return content, nil
}
