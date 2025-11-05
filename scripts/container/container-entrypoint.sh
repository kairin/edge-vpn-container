#!/bin/bash
# Container entrypoint script - displays NVIDIA verification on startup

# Run NVIDIA verification
/container-scripts/verify-nvidia.sh

# Display welcome message
echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "          Welcome to Edge NVIDIA Container"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "Available commands:"
echo "  launch-edge.sh       - Start Microsoft Edge with GPU acceleration"
echo "  check-gpu.sh         - Monitor GPU status"
echo "  verify-nvidia.sh     - Re-run NVIDIA verification"
echo ""
echo "Quick start:"
echo "  1. launch-edge.sh"
echo "  2. Navigate to edge://gpu in browser to verify GPU"
echo ""
echo "═══════════════════════════════════════════════════════════════"
echo ""

# Start interactive bash shell
exec /bin/bash
