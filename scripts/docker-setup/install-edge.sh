#!/bin/bash
# Install Microsoft Edge browser from official Microsoft repository
set -euo pipefail

echo "Installing Microsoft Edge browser..."

# Add Microsoft GPG key for package verification
echo "Adding Microsoft GPG key..."
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor -o /usr/share/keyrings/microsoft-edge.gpg

# Add Microsoft Edge repository
echo "Adding Microsoft Edge repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main" > \
    /etc/apt/sources.list.d/microsoft-edge.list

# Update package list and install Edge
echo "Installing Microsoft Edge stable..."
apt-get update
apt-get install -y --no-install-recommends microsoft-edge-stable

# Clean up apt cache
rm -rf /var/lib/apt/lists/*

# Verify installation
if command -v microsoft-edge &> /dev/null; then
    EDGE_VERSION=$(microsoft-edge --version 2>/dev/null || echo "Unknown")
    echo "✓ Microsoft Edge installed successfully: $EDGE_VERSION"
else
    echo "✗ Microsoft Edge installation failed!"
    exit 1
fi
