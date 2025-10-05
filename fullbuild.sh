#!/bin/bash
set -e

echo "========================================"
echo "🚀 Starting full Yolks build (Node + Python + Bun)"
echo "========================================"

# Build Node.js Yolks
if [ -f "nodejs/build.sh" ]; then
    echo "🔹 Building Node.js Yolks images..."
    bash nodejs/build.sh
else
    echo "⚠️ Node.js build script not found!"
fi

# Build Python Yolks
if [ -f "python/build.sh" ]; then
    echo "🔹 Building Python Yolks images..."
    bash python/build.sh
else
    echo "⚠️ Python build script not found!"
fi

# Build Bun Latest
if [ -f "bun_latest/dockerfile" ]; then
    echo "🔹 Building Bun Latest Yolk..."
    docker buildx build \
        -t ghcr.io/jjakesv/yolks:bun_latest \
        -f bun_latest/dockerfile .
else
    echo "⚠️ Bun Latest dockerfile not found!"
fi

# Build Bun Canary
if [ -f "bun_canary/dockerfile" ]; then
    echo "🔹 Building Bun Canary Yolk..."
    docker buildx build \
        -t ghcr.io/jjakesv/yolks:bun_canary \
        -f bun_canary/dockerfile .
else
    echo "⚠️ Bun Canary dockerfile not found!"
fi

# Build Deno
if [ -f "deno/dockerfile" ]; then
    echo "🔹 Building Deno yolk..."
    docker buildx build \
        -t ghcr.io/jjakesv/yolks:deno
        -f deno/dockerfile .
else
    echo "⚠️ Deno dockerfile not found!"
fi

echo "========================================"
echo "✅ Full Yolks build finished!"
echo "========================================"
