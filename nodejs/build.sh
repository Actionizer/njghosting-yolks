#!/bin/bash
set -e

# Node versions to support
VERSIONS=(12 14 16 18 20 22 24)

for v in "${VERSIONS[@]}"; do
  TAG="nodejs_$v"
  echo "🚀 Checking Node.js $v -> $TAG"

  # Skip build if image already exists on GHCR
  if curl -s -f -l "https://ghcr.io/v2/jjakesv/yolks/manifests/$TAG" >/dev/null 2>&1; then
    echo "✅ Image $TAG already exists, skipping build."
    continue
  fi

  # Pick correct npm version
  if [ "$v" -ge 20 ]; then
    NPM_VER="latest"
  else
    NPM_VER="8"
  fi

  echo "🚀 Building Node.js $v -> $TAG with npm $NPM_VER"
  docker build \
    --build-arg NODE_VERSION=$v \
    --build-arg NPM_VERSION=$NPM_VER \
    -t ghcr.io/jjakesv/yolks:$TAG \
    -f Dockerfile.node .

  docker push ghcr.io/jjakesv/yolks:$TAG
done