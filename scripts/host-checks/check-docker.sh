#!/bin/bash
# Check Docker installation and accessibility
set -uo pipefail

LOG_DIR="${1:-logs/verify-host/$(date +%Y-%m-%d_%H-%M-%S)}"
TIMESTAMP="${2:-$(date +%Y-%m-%d_%H-%M-%S)}"
LOG_FILE="$LOG_DIR/04-check-docker.md"

mkdir -p "$LOG_DIR"

strip_colors() {
    sed -e 's/\x1b\[[0-9;]*m//g'
}

EXIT_CODE=0

{
echo "# Docker Check"
echo ""
echo "**Check:** Docker installation and permissions"
echo "**Run:** $TIMESTAMP"
echo ""
echo "---"
echo ""

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "## Check Results"
echo ""

if ! command -v docker &> /dev/null; then
    echo -e "${RED}✗ Docker command not found${NC}"
    echo ""
    echo "**Issue:** Docker is not installed."
    echo ""
    echo "**Impact:** Cannot run the container."
    echo ""
    echo "**Resolution:** Install Docker from https://docs.docker.com/engine/install/"
    EXIT_CODE=1
else
    echo -e "${GREEN}✓ Docker is installed${NC}"
    echo ""
    DOCKER_VERSION=$(docker --version)
    echo "**Version:** \`$DOCKER_VERSION\`"
    echo ""

    # Check if user can run docker
    if docker ps &> /dev/null; then
        echo -e "${GREEN}✓ Docker is accessible (no sudo required)${NC}"
        echo ""
        echo "**Status:** User has proper Docker permissions"
    else
        echo -e "${YELLOW}⚠ Docker requires sudo or user is not in docker group${NC}"
        echo ""
        echo "**Issue:** Current user cannot run Docker commands."
        echo ""
        echo "**Resolution:**"
        echo "\`\`\`bash"
        echo "sudo usermod -aG docker \$USER"
        echo "# Then log out and back in"
        echo "\`\`\`"
        EXIT_CODE=2
    fi
fi

echo ""
echo "---"
echo ""
echo "**Check completed:** $(date)"

} | tee >(strip_colors > "$LOG_FILE") >/dev/null

exit $EXIT_CODE
