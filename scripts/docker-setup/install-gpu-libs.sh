#!/bin/bash
# Install OpenGL and EGL libraries for GPU-accelerated rendering
set -euo pipefail

echo "Installing GPU rendering libraries..."

apt-get update

apt-get install -y --no-install-recommends \
    libgl1 \
    libegl1

# Clean up apt cache
rm -rf /var/lib/apt/lists/*

echo "✓ GPU libraries installed successfully"
