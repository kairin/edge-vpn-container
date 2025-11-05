#!/bin/bash
# Check xhost access control configuration
set -uo pipefail

LOG_DIR="${1:-logs/verify-host/$(date +%Y-%m-%d_%H-%M-%S)}"
TIMESTAMP="${2:-$(date +%Y-%m-%d_%H-%M-%S)}"
LOG_FILE="$LOG_DIR/03-check-xhost.md"

mkdir -p "$LOG_DIR"

strip_colors() {
    sed -e 's/\x1b\[[0-9;]*m//g'
}

EXIT_CODE=0

{
echo "# xhost Access Control Check"
echo ""
echo "**Check:** xhost access control configuration"
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

if ! command -v xhost &> /dev/null; then
    echo -e "${YELLOW}⚠ xhost command not found${NC}"
    echo ""
    echo "**Issue:** xhost utility not installed."
    echo ""
    echo "**Resolution:** Install with: \`sudo apt-get install x11-xserver-utils\`"
    EXIT_CODE=2
else
    XHOST_OUTPUT=$(xhost 2>&1 || true)

    if echo "$XHOST_OUTPUT" | grep -q "unable to open display"; then
        echo -e "${RED}✗ Cannot connect to display server${NC}"
        echo ""
        echo "**Issue:** xhost cannot access DISPLAY=$DISPLAY"
        EXIT_CODE=1
    elif echo "$XHOST_OUTPUT" | grep -q "access control disabled"; then
        echo -e "${YELLOW}⚠ Access control is DISABLED${NC}"
        echo ""
        echo "**Status:** Any client can connect (INSECURE)"
        echo ""
        echo "**Security Recommendation:**"
        echo "\`\`\`bash"
        echo "xhost -                # Re-enable access control"
        echo "xhost +local:docker    # Allow only local Docker"
        echo "\`\`\`"
        EXIT_CODE=2
    elif echo "$XHOST_OUTPUT" | grep -q "access control enabled"; then
        echo -e "${GREEN}✓ Access control is enabled${NC}"
        echo ""

        if echo "$XHOST_OUTPUT" | grep -q "LOCAL:"; then
            echo "**Status:** Local connections are allowed"
            echo ""
            echo "**Meaning:** This is secure and will work with Docker."
        else
            echo -e "${YELLOW}⚠ No local connections allowed${NC}"
            echo ""
            echo "**Issue:** Docker containers may not be able to connect."
            echo ""
            echo "**Resolution:**"
            echo "\`\`\`bash"
            echo "xhost +local:docker"
            echo "\`\`\`"
            EXIT_CODE=2
        fi
    fi

    echo ""
    echo "**Raw xhost output:**"
    echo "\`\`\`"
    echo "$XHOST_OUTPUT"
    echo "\`\`\`"
fi

echo ""
echo "---"
echo ""
echo "**Check completed:** $(date)"

} | tee >(strip_colors > "$LOG_FILE") >/dev/null

exit $EXIT_CODE
