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
        -t ghcr.io/actionizer/njghosting-yolks:bun_latest \
        -f bun_latest/dockerfile .
else
    echo "⚠️ Bun Latest dockerfile not found!"
fi

# Build Bun Canary
if [ -f "bun_canary/dockerfile" ]; then
    echo "🔹 Building Bun Canary Yolk..."
    docker buildx build \
        -t ghcr.io/actionizer/njghosting-yolks:bun_canary \
        -f bun_canary/dockerfile .
else
    echo "⚠️ Bun Canary dockerfile not found!"
fi

# Build Deno
if [ -f "deno/Dockerfile" ]; then
    echo "🔹 Building Deno yolk..."
    docker buildx build \
        -t ghcr.io/actionizer/njghosting-yolks:deno \
        -f deno/Dockerfile .
else
    echo "⚠️ Deno dockerfile not found!"
fi

# Build swift :)
if [ -f "swift/Dockerfile" ]; then
    echo "Building Swift yolk..."
    bash swift/build.sh
else
    echo "Swift dockerfile not found!"
fi

# Build lavalink
if [ -f "lavalink/Dockerfile" ]; then
    echo "Building Lavalink yolk..."
    docker buildx build \
        -t ghcr.io/actionizer/njghosting-yolks:lavalink \
        --platform linux/amd64 \
        -f lavalink/Dockerfile .
else
    echo "Lavalink dockerfile not found!"
fi

echo "========================================"
echo "✅ Full Yolks build finished!"
echo "========================================"
