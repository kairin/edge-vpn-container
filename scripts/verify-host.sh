#!/bin/bash
# Host Verification Orchestrator - Runs all modular checks
set -uo pipefail

# Create timestamped log directory for this verification run
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
LOG_DIR="logs/verify-host/${TIMESTAMP}"
mkdir -p "$LOG_DIR"

echo "========================================="
echo "Host Display Configuration Verification"
echo "========================================="
echo "Run ID: $TIMESTAMP"
echo "Logs: $LOG_DIR"
echo ""

# Track errors and warnings
ERRORS=0
WARNINGS=0

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Run each check module and track status
echo "1. Checking DISPLAY variable..."
./scripts/host-checks/check-display.sh "$LOG_DIR" "$TIMESTAMP"
STATUS=$?
if [ $STATUS -eq 1 ]; then
    ((ERRORS++))
    echo -e "   ${RED}✗ Error${NC}"
elif [ $STATUS -eq 2 ]; then
    ((WARNINGS++))
    echo -e "   ${YELLOW}⚠ Warning${NC}"
else
    echo -e "   ${GREEN}✓ Pass${NC}"
fi
echo ""

echo "2. Checking X11 socket files..."
./scripts/host-checks/check-x11.sh "$LOG_DIR" "$TIMESTAMP"
STATUS=$?
if [ $STATUS -eq 1 ]; then
    ((ERRORS++))
    echo -e "   ${RED}✗ Error${NC}"
elif [ $STATUS -eq 2 ]; then
    ((WARNINGS++))
    echo -e "   ${YELLOW}⚠ Warning${NC}"
else
    echo -e "   ${GREEN}✓ Pass${NC}"
fi
echo ""

echo "3. Checking xhost access control..."
./scripts/host-checks/check-xhost.sh "$LOG_DIR" "$TIMESTAMP"
STATUS=$?
if [ $STATUS -eq 1 ]; then
    ((ERRORS++))
    echo -e "   ${RED}✗ Error${NC}"
elif [ $STATUS -eq 2 ]; then
    ((WARNINGS++))
    echo -e "   ${YELLOW}⚠ Warning${NC}"
else
    echo -e "   ${GREEN}✓ Pass${NC}"
fi
echo ""

echo "4. Checking Docker..."
./scripts/host-checks/check-docker.sh "$LOG_DIR" "$TIMESTAMP"
STATUS=$?
if [ $STATUS -eq 1 ]; then
    ((ERRORS++))
    echo -e "   ${RED}✗ Error${NC}"
elif [ $STATUS -eq 2 ]; then
    ((WARNINGS++))
    echo -e "   ${YELLOW}⚠ Warning${NC}"
else
    echo -e "   ${GREEN}✓ Pass${NC}"
fi
echo ""

echo "5. Checking NVIDIA GPU..."
./scripts/host-checks/check-nvidia-gpu.sh "$LOG_DIR" "$TIMESTAMP"
STATUS=$?
if [ $STATUS -eq 1 ]; then
    ((ERRORS++))
    echo -e "   ${RED}✗ Error${NC}"
elif [ $STATUS -eq 2 ]; then
    ((WARNINGS++))
    echo -e "   ${YELLOW}⚠ Warning${NC}"
else
    echo -e "   ${GREEN}✓ Pass${NC}"
fi
echo ""

echo "6. Checking NVIDIA Docker runtime..."
./scripts/host-checks/check-nvidia-runtime.sh "$LOG_DIR" "$TIMESTAMP"
STATUS=$?
if [ $STATUS -eq 1 ]; then
    ((ERRORS++))
    echo -e "   ${RED}✗ Error${NC}"
elif [ $STATUS -eq 2 ]; then
    ((WARNINGS++))
    echo -e "   ${YELLOW}⚠ Warning${NC}"
else
    echo -e "   ${GREEN}✓ Pass${NC}"
fi
echo ""

echo "7. Checking NVIDIA Persistence Mode..."
./scripts/host-checks/enable-persistence-mode.sh "$LOG_DIR" "$TIMESTAMP"
# Don't count this towards errors/warnings - it's optional
echo ""

# Generate summary markdown file
cat > "$LOG_DIR/summary.md" << EOF
# Host Verification Summary

**Run ID:** $TIMESTAMP
**Date:** $(date)
**Log Directory:** \`$LOG_DIR\`

---

## Verification Results

EOF

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo "**Status:** ✓ All checks passed" >> "$LOG_DIR/summary.md"
else
    echo "**Status:** $ERRORS error(s), $WARNINGS warning(s)" >> "$LOG_DIR/summary.md"
fi

cat >> "$LOG_DIR/summary.md" << EOF

## Individual Check Results

1. [DISPLAY Variable](01-check-display.md)
2. [X11 Sockets](02-check-x11.md)
3. [xhost Access Control](03-check-xhost.md)
4. [Docker](04-check-docker.md)
5. [NVIDIA GPU](05-check-nvidia-gpu.md)
6. [NVIDIA Docker Runtime](06-check-nvidia-runtime.md)
7. [Persistence Mode Setup](07-enable-persistence-mode.md)

---

**Generated:** $(date)
EOF

# Display summary
echo "========================================="
echo "Verification Summary"
echo "========================================="

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo "Your system is ready to run the container."
    echo "Execute: ./scripts/build.sh (first time) or ./scripts/run.sh"
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠ $WARNINGS warning(s) found${NC}"
    echo ""
    echo "Your system should work, but review the warnings above."
    echo "You can proceed with: ./scripts/build.sh (first time) or ./scripts/run.sh"
else
    echo -e "${RED}✗ $ERRORS error(s) found${NC}"
    if [ $WARNINGS -gt 0 ]; then
        echo -e "${YELLOW}⚠ $WARNINGS warning(s) found${NC}"
    fi
    echo ""
    echo "Please fix the errors above before running ./scripts/build.sh"
fi

echo ""
echo "========================================="
echo "Quick Reference"
echo "========================================="
echo ""
echo "Enable X11 access for Docker:"
echo "  xhost +local:docker"
echo ""
echo "Re-enable access control (if disabled):"
echo "  xhost -"
echo "  xhost +local:docker"
echo ""
echo "Build image (first time):"
echo "  ./scripts/build.sh"
echo ""
echo "Launch container:"
echo "  ./scripts/run.sh"
echo ""
echo "========================================="
echo "Detailed logs saved to: $LOG_DIR"
echo "Summary: $LOG_DIR/summary.md"
echo "========================================="

# Exit with error if there were critical errors
if [ $ERRORS -gt 0 ]; then
    exit 1
fi

exit 0
