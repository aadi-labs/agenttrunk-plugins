#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
group="${1:-all-sdks}"
case "$group" in all-sdks|extra-sdks|typescript-sdk|python-sdk|go-sdk|rust-sdk|ruby-sdk|swift-sdk) ;; *) echo "Unknown SDK group" >&2; exit 1;; esac
generator_docker_config="$(mktemp -d)"
trap 'rm -rf "$generator_docker_config"' EXIT INT TERM
docker_host="$(docker context inspect --format '{{.Endpoints.docker.Host}}')"
node scripts/check-docker-engine.mjs "$docker_host"
DOCKER_CONFIG="$generator_docker_config" DOCKER_HOST="$docker_host" \
  ./node_modules/.bin/fern generate --local --force --no-prompt --generate-tests --group "$group" --version 0.1.0
