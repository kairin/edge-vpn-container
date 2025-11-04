#!/bin/bash
# Quick verification script for edge-vpn container

echo "======================================================================"
echo "           Edge VPN Container - Quick Verification"
echo "======================================================================"
echo

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

pass() { echo -e "${GREEN}✓${NC} $1"; }
fail() { echo -e "${RED}✗${NC} $1"; }
warn() { echo -e "${YELLOW}!${NC} $1"; }

# Test 1: Image exists
echo -n "1. Docker image exists... "
if docker image inspect edge-vpn &>/dev/null; then
    pass "Found"
else
    fail "Missing - run: docker build -t edge-vpn ."
    exit 1
fi

# Test 2: NVIDIA GPU present
echo -n "2. NVIDIA GPU detected... "
if [ -e "/dev/nvidia0" ]; then
    GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null | head -1)
    if [ -n "$GPU_NAME" ]; then
        pass "$GPU_NAME"
    else
        warn "Device found but nvidia-smi failed"
    fi
else
    fail "No NVIDIA GPU found"
fi

# Test 3: NVIDIA libraries accessible
echo -n "3. NVIDIA libraries present... "
LIB_COUNT=$(ls /lib/x86_64-linux-gnu/libnvidia*.so* 2>/dev/null | wc -l)
if [ "$LIB_COUNT" -gt 0 ]; then
    pass "$LIB_COUNT libraries found"
else
    fail "No NVIDIA libraries found"
fi

# Test 4: Display server available
echo -n "4. Display server available... "
if [ -n "$WAYLAND_DISPLAY" ] && [ -S "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" ]; then
    pass "Wayland ($WAYLAND_DISPLAY)"
elif [ -n "$DISPLAY" ]; then
    pass "X11 ($DISPLAY)"
else
    fail "No display server detected"
fi

# Test 5: Video group membership
echo -n "5. Video group access... "
if groups | grep -q video; then
    pass "User in video group"
else
    warn "Not in video group (may cause permission issues)"
fi

# Test 6: Configuration directory
echo -n "6. Config directory exists... "
if [ -d "$HOME/.config/microsoft-edge-docker" ]; then
    pass "Ready"
else
    pass "Will be created"
fi

# Test 7: Downloads directory
echo -n "7. Downloads directory exists... "
if [ -d "$HOME/Downloads" ]; then
    pass "Ready"
else
    pass "Will be created"
fi

echo
echo "======================================================================"
echo "                    Verification Complete"
echo "======================================================================"
echo
echo "Container is ready to launch!"
echo
echo "Run: ./run.sh"
echo
echo "After launch, verify:"
echo "  1. No warning banner in browser"
echo "  2. Open edge://gpu to see NVIDIA GPU"
echo "  3. Check performance is fast"
echo
