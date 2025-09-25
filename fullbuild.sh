#!/bin/bash
set -e

echo "========================================"
echo "🚀 Starting full Yolks build (Node + Python)"
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

echo "========================================"
echo "✅ Full Yolks build finished!"
echo "========================================"
