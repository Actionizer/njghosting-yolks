#!/bin/bash
set -e

# Make script path-independent
cd "$(dirname "$0")"

PY_VERSIONS=(3.11 3.12 3.13)
REPO="ghcr.io/jjakesv/yolks"

for v in "${PY_VERSIONS[@]}"; do
    TAG="python_$v"
    echo "🚀 Checking Python $v -> $TAG"

    # Skip build if image already exists
    if curl -s -f -l "https://ghcr.io/v2/jjakesv/yolks/manifests/$TAG" >/dev/null 2>&1; then
        echo "✅ Image $TAG already exists, skipping build."
        continue
    fi

    echo "🚀 Building Python $v -> $TAG"

    docker build \
        --platform linux/amd64 \
        --build-arg PYTHON_VERSION="$v" \
        -t "$REPO:$TAG" \
        -f Dockerfile .

    echo "📦 Pushing $TAG to GHCR"
    docker push "$REPO:$TAG"
done
