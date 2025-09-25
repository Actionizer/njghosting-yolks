#!/bin/bash
set -e

# List of Python versions to build
PY_VERSIONS=(3.11 3.12 3.13)

for v in "${PY_VERSIONS[@]}"; do
  TAG="python_$v"
  echo "🚀 Checking Python $v -> $TAG"

  # Check if image already exists on GHCR
  if curl -s -f -l "https://ghcr.io/v2/jjakesv/yolks/manifests/$TAG" >/dev/null 2>&1; then
    echo "✅ Image $TAG already exists, skipping build."
    continue
  fi

  echo "🚀 Building Python $v -> $TAG"
  docker build \
    --build-arg PYTHON_VERSION=$v \
    -t ghcr.io/jjakesv/yolks:$TAG \
    -f Dockerfile.python .

  echo "🚀 Pushing Python $v -> $TAG"
  docker push ghcr.io/jjakesv/yolks:$TAG
done
