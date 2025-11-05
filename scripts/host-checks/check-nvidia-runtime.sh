#!/bin/bash
# Check NVIDIA Docker runtime availability
set -uo pipefail

LOG_DIR="${1:-logs/verify-host/$(date +%Y-%m-%d_%H-%M-%S)}"
TIMESTAMP="${2:-$(date +%Y-%m-%d_%H-%M-%S)}"
LOG_FILE="$LOG_DIR/06-check-nvidia-runtime.md"

mkdir -p "$LOG_DIR"

strip_colors() {
    sed -e 's/\x1b\[[0-9;]*m//g'
}

EXIT_CODE=0

{
echo "# NVIDIA Docker Runtime Check"
echo ""
echo "**Check:** NVIDIA Docker runtime availability"
echo "**Run:** $TIMESTAMP"
echo ""
echo "---"
echo ""

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "## Check Results"
echo ""

if docker info 2>/dev/null | grep -q "nvidia"; then
    echo -e "${GREEN}✓ NVIDIA runtime is available${NC}"
    echo ""
    echo "**Status:** GPU acceleration in containers will work"
    echo ""
    echo "**Available runtimes:**"
    echo "\`\`\`"
    docker info 2>/dev/null | grep -A 5 "Runtimes:"
    echo "\`\`\`"
else
    echo -e "${YELLOW}⚠ NVIDIA runtime not detected in Docker${NC}"
    echo ""
    echo "**Issue:** GPU acceleration in containers will not work."
    echo ""
    echo "**Resolution:** Install NVIDIA Container Toolkit"
    echo ""
    echo "See: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html"
    EXIT_CODE=2
fi

echo ""
echo "---"
echo ""
echo "**Check completed:** $(date)"

} | tee >(strip_colors > "$LOG_FILE") >/dev/null

exit $EXIT_CODE
