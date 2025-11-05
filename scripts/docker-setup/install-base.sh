#!/bin/bash
# Install base system dependencies required for package management
set -euo pipefail

echo "Installing base system dependencies..."

apt-get update

apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    ca-certificates \
    apt-transport-https

# Clean up apt cache
rm -rf /var/lib/apt/lists/*

echo "✓ Base dependencies installed successfully"
