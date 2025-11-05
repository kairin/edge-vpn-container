#!/bin/bash
# Check X11 socket accessibility
set -uo pipefail

LOG_DIR="${1:-logs/verify-host/$(date +%Y-%m-%d_%H-%M-%S)}"
TIMESTAMP="${2:-$(date +%Y-%m-%d_%H-%M-%S)}"
LOG_FILE="$LOG_DIR/02-check-x11.md"

mkdir -p "$LOG_DIR"

strip_colors() {
    sed -e 's/\x1b\[[0-9;]*m//g'
}

EXIT_CODE=0

{
echo "# X11 Socket Check"
echo ""
echo "**Check:** X11 socket files accessibility"
echo "**Run:** $TIMESTAMP"
echo ""
echo "---"
echo ""

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "## Check Results"
echo ""

if [ ! -d "/tmp/.X11-unix" ]; then
    echo -e "${RED}✗ /tmp/.X11-unix directory does not exist${NC}"
    echo ""
    echo "**Issue:** No X11 sockets available for GUI applications."
    echo ""
    echo "**Impact:** Cannot connect to display server."
    EXIT_CODE=1
else
    SOCKET_COUNT=$(ls -1 /tmp/.X11-unix/ 2>/dev/null | wc -l)
    if [ "$SOCKET_COUNT" -eq 0 ]; then
        echo -e "${RED}✗ No X11 sockets found in /tmp/.X11-unix/${NC}"
        echo ""
        echo "**Issue:** X server may not be running."
        EXIT_CODE=1
    else
        echo -e "${GREEN}✓ Found $SOCKET_COUNT X11 socket(s)${NC}"
        echo ""
        echo "**Socket Details:**"
        echo "\`\`\`"
        ls -lh /tmp/.X11-unix/
        echo "\`\`\`"
        echo ""
        echo "**Meaning:** X server is running and accessible via these sockets"
    fi
fi

echo ""
echo "---"
echo ""
echo "**Check completed:** $(date)"

} | tee >(strip_colors > "$LOG_FILE") >/dev/null

exit $EXIT_CODE
