#!/bin/bash
# Host X11/Display Verification Script
# Run this before ./scripts/run.sh to verify your system is ready

set -uo pipefail  # Removed -e so script continues through all checks

# Create log directory structure
LOG_DIR="logs/verify-host"
mkdir -p "$LOG_DIR"

# Generate timestamped log filename
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
LOG_FILE="$LOG_DIR/verify-host-${TIMESTAMP}.md"

# Function to strip ANSI color codes for log file
strip_colors() {
    sed -e 's/\x1b\[[0-9;]*m//g'
}

# Initialize markdown log file with frontmatter
cat > "$LOG_FILE" << EOF
# Host Display Configuration Verification

**Generated:** $(date)
**Log File:** \`$LOG_FILE\`

---

## Verification Results

EOF

# Function to log to file (strips colors, markdown formatted)
log_to_file() {
    strip_colors >> "$LOG_FILE"
}

# Start verification output
{
echo "========================================"
echo "Host Display Configuration Verification"
echo "========================================"
echo "Log file: $LOG_FILE"
echo ""

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

# Check 1: DISPLAY variable
echo "1. Checking DISPLAY variable..."
if [ -z "${DISPLAY:-}" ]; then
    echo -e "${RED}✗ DISPLAY is not set${NC}"
    echo "  This means no display server is available."
    echo "  Container will not be able to show GUI applications."
    ((ERRORS++))
else
    echo -e "${GREEN}✓ DISPLAY is set: $DISPLAY${NC}"
    echo "  Meaning: Display server is available on $DISPLAY"
fi
echo ""

# Check 2: X11 sockets
echo "2. Checking X11 socket files..."
if [ ! -d "/tmp/.X11-unix" ]; then
    echo -e "${RED}✗ /tmp/.X11-unix directory does not exist${NC}"
    echo "  No X11 sockets available for GUI applications."
    ((ERRORS++))
else
    SOCKET_COUNT=$(ls -1 /tmp/.X11-unix/ 2>/dev/null | wc -l)
    if [ "$SOCKET_COUNT" -eq 0 ]; then
        echo -e "${RED}✗ No X11 sockets found in /tmp/.X11-unix/${NC}"
        ((ERRORS++))
    else
        echo -e "${GREEN}✓ Found $SOCKET_COUNT X11 socket(s):${NC}"
        ls -lh /tmp/.X11-unix/ | tail -n +2 | while read -r line; do
            echo "  $line"
        done
        echo "  Meaning: X server is running and accessible via these sockets"
    fi
fi
echo ""

# Check 3: xhost access control
echo "3. Checking xhost access control..."
if ! command -v xhost &> /dev/null; then
    echo -e "${YELLOW}⚠ xhost command not found${NC}"
    echo "  You may need to install: sudo apt-get install x11-xserver-utils"
    ((WARNINGS++))
else
    XHOST_OUTPUT=$(xhost 2>&1 || true)

    if echo "$XHOST_OUTPUT" | grep -q "unable to open display"; then
        echo -e "${RED}✗ Cannot connect to display server${NC}"
        echo "  Actual output: xhost cannot access DISPLAY=$DISPLAY"
        ((ERRORS++))
    elif echo "$XHOST_OUTPUT" | grep -q "access control disabled"; then
        echo -e "${YELLOW}⚠ Access control is DISABLED${NC}"
        echo "  Actual status: Any client can connect (INSECURE)"
        echo ""
        echo "  Security recommendation:"
        echo "    xhost -                # Re-enable access control"
        echo "    xhost +local:docker    # Allow only local Docker"
        ((WARNINGS++))
    elif echo "$XHOST_OUTPUT" | grep -q "access control enabled"; then
        echo -e "${GREEN}✓ Access control is enabled${NC}"

        if echo "$XHOST_OUTPUT" | grep -q "LOCAL:"; then
            echo "  Actual status: Local connections are allowed"
            echo "  Explanation: This is secure and will work with Docker."
        else
            echo -e "${YELLOW}⚠ No local connections allowed${NC}"
            echo "  Actual status: Docker containers may not be able to connect."
            echo ""
            echo "  Run this command to fix:"
            echo "    xhost +local:docker"
            ((WARNINGS++))
        fi
    fi

    echo ""
    echo "  Raw xhost output:"
    echo "$XHOST_OUTPUT" | sed 's/^/    /'
fi
echo ""

# Check 4: Docker availability
echo "4. Checking Docker..."
if ! command -v docker &> /dev/null; then
    echo -e "${RED}✗ Docker command not found${NC}"
    echo "  Docker is required to run the container."
    ((ERRORS++))
else
    echo -e "${GREEN}✓ Docker is installed${NC}"
    DOCKER_VERSION=$(docker --version)
    echo "  Version: $DOCKER_VERSION"

    # Check if user can run docker
    if docker ps &> /dev/null; then
        echo -e "${GREEN}✓ Docker is accessible (no sudo required)${NC}"
    else
        echo -e "${YELLOW}⚠ Docker requires sudo or user is not in docker group${NC}"
        echo "  You may need to run: sudo usermod -aG docker $USER"
        echo "  Then log out and back in."
        ((WARNINGS++))
    fi
fi
echo ""

# Check 5: NVIDIA GPU
echo "5. Checking NVIDIA GPU..."
if ! command -v nvidia-smi &> /dev/null; then
    echo -e "${YELLOW}⚠ nvidia-smi command not found${NC}"
    echo "  NVIDIA drivers may not be installed."
    echo "  GPU acceleration will not work."
    ((WARNINGS++))
else
    echo -e "${GREEN}✓ nvidia-smi is available${NC}"

    # Try to get GPU info
    if nvidia-smi &> /dev/null; then
        echo ""
        echo "  Full nvidia-smi Output:"
        echo "  ════════════════════════════════════════════════════════════════════════════════"
        nvidia-smi 2>/dev/null | sed 's/^/  /'
        echo "  ════════════════════════════════════════════════════════════════════════════════"
        echo ""
        echo "  GPU Information Summary:"

        # Get GPU name
        GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null | head -1)
        if [ -n "$GPU_NAME" ]; then
            echo "    Model: $GPU_NAME"
        fi

        # Get driver version
        DRIVER_VERSION=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader 2>/dev/null | head -1)
        if [ -n "$DRIVER_VERSION" ]; then
            echo "    Driver: $DRIVER_VERSION"
        fi

        # Get CUDA version from nvidia-smi output (not query-gpu)
        CUDA_VERSION=$(nvidia-smi 2>/dev/null | grep "CUDA Version" | sed 's/.*CUDA Version: \([0-9.]*\).*/\1/' | head -1)
        if [ -n "$CUDA_VERSION" ]; then
            echo "    CUDA: $CUDA_VERSION"
        fi

        # Get GPU compute capability
        GPU_COMPUTE=$(nvidia-smi --query-gpu=compute_cap --format=csv,noheader 2>/dev/null | head -1 || true)
        if [ -n "$GPU_COMPUTE" ]; then
            echo "    Compute Capability: $GPU_COMPUTE"
        fi

        # Get GPU utilization
        GPU_UTIL=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
        if [ -n "$GPU_UTIL" ]; then
            echo "    Utilization: ${GPU_UTIL}%"
        fi

        # Get memory info
        MEM_USED=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits 2>/dev/null | head -1)
        MEM_TOTAL=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits 2>/dev/null | head -1)
        if [ -n "$MEM_USED" ] && [ -n "$MEM_TOTAL" ]; then
            echo "    Memory: ${MEM_USED}MB / ${MEM_TOTAL}MB"
        fi

        # Get temperature
        TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
        if [ -n "$TEMP" ]; then
            echo "    Temperature: ${TEMP}°C"
        fi

        # Check GPU count
        GPU_COUNT=$(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null | wc -l)
        if [ "$GPU_COUNT" -gt 1 ]; then
            echo "    Note: $GPU_COUNT GPUs detected (showing first GPU info)"
        fi

        echo ""
        echo "  NVIDIA Capabilities:"

        # Check for specific NVIDIA features
        # Check NVENC (video encoding) - detect via encoder session count
        if nvidia-smi --query-gpu=encoder.stats.sessionCount --format=csv,noheader 2>/dev/null | grep -q "^[0-9]"; then
            echo "    ✓ NVENC (Hardware video encoding) - Available"
        else
            echo "    ? NVENC status - Unable to query"
        fi

        # Check NVDEC (video decoding) - detect via video clock domain
        VIDEO_CLOCK=$(nvidia-smi --query-gpu=clocks.current.video --format=csv,noheader,nounits 2>/dev/null | head -1 || true)
        if [ -n "$VIDEO_CLOCK" ] && [ "$VIDEO_CLOCK" != "N/A" ]; then
            echo "    ✓ NVDEC (Hardware video decoding) - Available (Video clock: ${VIDEO_CLOCK} MHz)"
        else
            echo "    ? NVDEC status - Unable to detect"
        fi

        # Check for CUDA cores (compute capability)
        if [ -n "$GPU_COMPUTE" ]; then
            echo "    ✓ CUDA Compute - Capability $GPU_COMPUTE"
        fi

        # Check for Display output capability
        DISPLAY_ACTIVE=$(nvidia-smi --query-gpu=display_active --format=csv,noheader 2>/dev/null | head -1 || true)
        if [ "$DISPLAY_ACTIVE" = "Enabled" ]; then
            echo "    ✓ Display Output - Active (GPU connected to monitor)"
        elif [ "$DISPLAY_ACTIVE" = "Disabled" ]; then
            echo "    ○ Display Output - Disabled (headless GPU)"
        fi

        # Check persistence mode
        PERSISTENCE=$(nvidia-smi --query-gpu=persistence_mode --format=csv,noheader 2>/dev/null | head -1 || true)
        if [ "$PERSISTENCE" = "Enabled" ]; then
            echo "    ✓ Persistence Mode - Enabled (optimal for containers)"
        elif [ "$PERSISTENCE" = "Disabled" ]; then
            echo "    ○ Persistence Mode - Disabled"
            echo ""
            echo "      What is Persistence Mode?"
            echo "      - Keeps NVIDIA driver loaded even when GPU is idle"
            echo "      - Containers get instant GPU access (no driver reload delay)"
            echo "      - Recommended for Docker containers with GPU access"
            echo ""

            # Only offer interactive prompt if running in terminal
            if [ -t 0 ]; then
                read -p "      Enable Persistence Mode now? [y/N]: " -n 1 -r
                echo ""
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    echo "      Enabling persistence mode (requires sudo)..."
                    if sudo nvidia-smi -pm 1 2>&1 | grep -q "Enabled persistence mode"; then
                        echo -e "      ${GREEN}✓ Persistence mode enabled successfully${NC}"
                    else
                        echo -e "      ${RED}✗ Failed to enable persistence mode${NC}"
                    fi
                else
                    echo "      Skipped. You can enable it later with: sudo nvidia-smi -pm 1"
                fi
            else
                echo "      To enable: sudo nvidia-smi -pm 1"
            fi
        fi

    else
        echo -e "${RED}✗ nvidia-smi failed to query GPU${NC}"
        echo "  NVIDIA drivers may not be properly installed."
        ((ERRORS++))
    fi
fi
echo ""

# Check 6: NVIDIA Docker runtime
echo "6. Checking NVIDIA Docker runtime..."
if docker info 2>/dev/null | grep -q "nvidia"; then
    echo -e "${GREEN}✓ NVIDIA runtime is available${NC}"

    # Show available runtimes
    echo ""
    echo "  Available runtimes:"
    docker info 2>/dev/null | grep -A 5 "Runtimes:" | sed 's/^/    /'
else
    echo -e "${YELLOW}⚠ NVIDIA runtime not detected in Docker${NC}"
    echo "  GPU acceleration in containers will not work."
    echo ""
    echo "  To install NVIDIA Container Toolkit:"
    echo "    https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html"
    ((WARNINGS++))
fi
echo ""

# Summary
echo "========================================"
echo "Verification Summary"
echo "========================================"

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
    exit 1
fi

echo ""
echo "========================================"
echo "Quick Reference"
echo "========================================"
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

} | tee >(log_to_file)

# Add final section to markdown log
echo "" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
echo "**Verification completed at:** $(date)" >> "$LOG_FILE"

# Display log file location
echo ""
echo "========================================"
echo "Log saved to: $LOG_FILE"
echo "========================================"
