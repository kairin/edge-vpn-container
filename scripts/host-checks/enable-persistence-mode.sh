#!/bin/bash
# Enable NVIDIA Persistence Mode
set -uo pipefail

LOG_DIR="${1:-logs/verify-host/$(date +%Y-%m-%d_%H-%M-%S)}"
TIMESTAMP="${2:-$(date +%Y-%m-%d_%H-%M-%S)}"
LOG_FILE="$LOG_DIR/07-enable-persistence-mode.md"

mkdir -p "$LOG_DIR"

strip_colors() {
    sed -e 's/\x1b\[[0-9;]*m//g'
}

EXIT_CODE=0

{
echo "# NVIDIA Persistence Mode Setup"
echo ""
echo "**Check:** Enable NVIDIA Persistence Mode"
echo "**Run:** $TIMESTAMP"
echo ""
echo "---"
echo ""

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "## Persistence Mode Status"
echo ""

# Check if nvidia-smi is available
if ! command -v nvidia-smi &> /dev/null; then
    echo -e "${RED}✗ nvidia-smi not available${NC}"
    echo ""
    echo "**Issue:** Cannot check or enable persistence mode without NVIDIA drivers."
    EXIT_CODE=1
else
    # Check current persistence mode status
    PERSISTENCE=$(nvidia-smi --query-gpu=persistence_mode --format=csv,noheader 2>/dev/null | head -1 || true)

    if [ "$PERSISTENCE" = "Enabled" ]; then
        echo -e "${GREEN}✓ Persistence Mode is already enabled${NC}"
        echo ""
        echo "**Status:** No action needed - persistence mode is active"
    elif [ "$PERSISTENCE" = "Disabled" ]; then
        echo -e "${YELLOW}○ Persistence Mode is currently disabled${NC}"
        echo ""
        echo "## What is Persistence Mode?"
        echo ""
        echo "**Benefits:**"
        echo "- Keeps NVIDIA driver loaded even when GPU is idle"
        echo "- Containers get instant GPU access (no driver reload delay)"
        echo "- Recommended for Docker containers with GPU access"
        echo "- Improves container startup time"
        echo ""
        echo "**System Impact:**"
        echo "- Slightly higher idle power consumption (~1-2W)"
        echo "- NVIDIA driver stays resident in memory"
        echo ""

        # Interactive prompt - default to yes
        # Only prompt if running in terminal
        if [ -t 0 ]; then
            read -p "Enable Persistence Mode now? [Y/n]: " -n 1 -r
            echo ""

            # Default to yes if empty or starts with Y/y
            if [[ -z "$REPLY" ]] || [[ $REPLY =~ ^[Yy]$ ]]; then
                echo ""
                echo "## Enabling Persistence Mode"
                echo ""
                echo "Running: \`sudo nvidia-smi -pm 1\`"
                echo ""

                if sudo nvidia-smi -pm 1 2>&1 | grep -q "Enabled persistence mode"; then
                    echo -e "${GREEN}✓ Persistence mode enabled successfully${NC}"
                    echo ""
                    echo "**Status:** NVIDIA driver will now stay loaded"
                else
                    echo -e "${RED}✗ Failed to enable persistence mode${NC}"
                    echo ""
                    echo "**Issue:** sudo nvidia-smi -pm 1 failed"
                    echo ""
                    echo "**Try manually:** \`sudo nvidia-smi -pm 1\`"
                    EXIT_CODE=1
                fi
            else
                echo ""
                echo "Skipped by user choice."
                echo ""
                echo "**To enable later:** \`sudo nvidia-smi -pm 1\`"
            fi
        else
            echo "**To enable:** \`sudo nvidia-smi -pm 1\`"
        fi
    else
        echo -e "${YELLOW}⚠ Unable to determine persistence mode status${NC}"
        EXIT_CODE=2
    fi
fi

echo ""
echo "---"
echo ""
echo "**Check completed:** $(date)"

} | tee >(strip_colors > "$LOG_FILE") >/dev/null

exit $EXIT_CODE
