#!/bin/bash
set -e

# Make script path-independent
cd "$(dirname "$0")"

# Swift versions to support
VERSIONS=(6.1 6.0 5.10)
REPO="ghcr.io/jjakesv/yolks"

for v in "${VERSIONS[@]}"; do
    TAG="swift_$v"
    echo "🚀 Checking Swift $v -> $TAG"

    # Skip build if image already exists
    if curl -s -f -l "https://ghcr.io/v2/jjakesv/yolks/manifests/$TAG" >/dev/null 2>&1; then
        echo "✅ Image $TAG already exists, skipping build."
        continue
    fi

    echo "🚀 Building Node.js $v -> $TAG with npm $NPM_VER"

    docker build \
        --platform linux/amd64 \
        --build-arg VERSION="$v" \
        -t "$REPO:$TAG" \
        -f Dockerfile .

    echo "📦 Pushing $TAG to GHCR"
    docker push "$REPO:$TAG"
done
