#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
# Prefer a supported local Go. Docker matches the AgentMailer local toolchain fallback.
if command -v go >/dev/null 2>&1 && go version | grep -Eq 'go1\.(2[1-9]|[3-9][0-9])\.'; then
  cd sdk/go
  exec go "$@"
fi
generator_docker_config="$(mktemp -d)"
trap 'rm -rf "$generator_docker_config"' EXIT INT TERM
docker_host="$(docker context inspect --format '{{.Endpoints.docker.Host}}')"
node scripts/check-docker-engine.mjs "$docker_host"
DOCKER_CONFIG="$generator_docker_config" DOCKER_HOST="$docker_host" \
  docker run --rm -v "$(pwd)/sdk/go:/workspace" -w /workspace golang:1.24-bookworm go "$@"
