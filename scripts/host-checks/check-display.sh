#!/bin/bash
# Check DISPLAY environment variable
set -uo pipefail

LOG_DIR="${1:-logs/verify-host/$(date +%Y-%m-%d_%H-%M-%S)}"
TIMESTAMP="${2:-$(date +%Y-%m-%d_%H-%M-%S)}"
LOG_FILE="$LOG_DIR/01-check-display.md"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Strip ANSI codes for clean logs
strip_colors() {
    sed -e 's/\x1b\[[0-9;]*m//g'
}

# Exit codes: 0=pass, 1=error, 2=warning
EXIT_CODE=0

# Start logging
{
echo "# DISPLAY Variable Check"
echo ""
echo "**Check:** DISPLAY environment variable"
echo "**Run:** $TIMESTAMP"
echo ""
echo "---"
echo ""

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "## Check Results"
echo ""

if [ -z "${DISPLAY:-}" ]; then
    echo -e "${RED}✗ DISPLAY is not set${NC}"
    echo ""
    echo "**Issue:** No display server available."
    echo ""
    echo "**Impact:** Container will not be able to show GUI applications."
    echo ""
    echo "**Resolution:** Ensure X11 or Wayland is running and DISPLAY is set."
    EXIT_CODE=1
else
    echo -e "${GREEN}✓ DISPLAY is set: $DISPLAY${NC}"
    echo ""
    echo "**Meaning:** Display server is available on \`$DISPLAY\`"
fi

echo ""
echo "---"
echo ""
echo "**Check completed:** $(date)"

} | tee >(strip_colors > "$LOG_FILE") >/dev/null

exit $EXIT_CODE
