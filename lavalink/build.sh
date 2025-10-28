#!/bin/bash
set -e

# Make script path-independent
cd "$(dirname "$0")"

# Node versions to support
REPO="ghcr.io/actionizer/njghosting-yolks"

for v in "${VERSIONS[@]}"; do
    TAG="lavalink_$v"
    echo "🚀 Checking Lavalink $v -> $TAG"

    # Skip build if image already exists
    if curl -s -f -l "https://ghcr.io/v2/actionizer/njghosting-yolks/manifests/$TAG" >/dev/null 2>&1; then
        echo "✅ Image $TAG already exists, skipping build."
        continue
    fi

    echo "🚀 Building Lavalink $v -> $TAG"

    docker build \
        --platform linux/amd64 \
        --build-arg NODE_VERSION="$v" \
        --build-arg NPM_VERSION="$NPM_VER" \
        -t "$REPO:$TAG" \
        -f Dockerfile .

    echo "📦 Pushing $TAG to GHCR"
    docker push "$REPO:$TAG"
done
