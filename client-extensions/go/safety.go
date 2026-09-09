// AgentTrunk transport policy. Copied into generated internal by postprocessing.
package internal

import (
    "bytes"
    "fmt"
    "io"
    "net/http"
    "regexp"
    "strings"
    "time"
    "github.com/aadi-labs/agenttrunk-plugins/sdk/go/core"
)

var immutableRevision = regexp.MustCompile(`^[a-f0-9]{64}$`)
var bearerToken = regexp.MustCompile(`^Bearer \S+$`)

func safeClient(client core.HTTPClient) core.HTTPClient {
    if client == nil { client = &http.Client{Timeout: 20 * time.Second} }
    if native, ok := client.(*http.Client); ok {
        copied := *native
        copied.CheckRedirect = func(_ *http.Request, _ []*http.Request) error { return http.ErrUseLastResponse }
        return &copied
    }
    // A supplied non-http.Client transport owns its own network behavior.
    return client
}

func validateRequest(request *http.Request) error {
    target := request.URL
    loopback := target.Hostname() == "localhost" || target.Hostname() == "127.0.0.1" || target.Hostname() == "::1"
    if (target.Scheme != "https" && !(target.Scheme == "http" && loopback)) || target.User != nil || target.Fragment != "" {
        return fmt.Errorf("use a trusted HTTPS API origin (HTTP loopback only for tests)")
    }
    if strings.HasPrefix(target.Path, "/v1/") && !bearerToken.MatchString(request.Header.Get("Authorization")) {
        return fmt.Errorf("AgentTrunk access token required")
    }
    if strings.Contains(target.Path, "/files/") && !immutableRevision.MatchString(target.Query().Get("ref")) {
        return fmt.Errorf("file reads require an immutable revision ID")
    }
    return nil
}

func boundedBody(body io.Reader, path string) (io.Reader, error) {
    limit := int64(24_000_000)
    if strings.Contains(path, "/files/") { limit = 1_000_000 }
    content, err := io.ReadAll(io.LimitReader(body, limit+1))
    if err != nil { return nil, err }
    if int64(len(content)) > limit { return nil, fmt.Errorf("AgentTrunk response exceeds size limit") }
    return bytes.NewReader(content), nil
}
