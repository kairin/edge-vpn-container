#!/bin/bash
# Check NVIDIA GPU detection and capabilities
set -uo pipefail

LOG_DIR="${1:-logs/verify-host/$(date +%Y-%m-%d_%H-%M-%S)}"
TIMESTAMP="${2:-$(date +%Y-%m-%d_%H-%M-%S)}"
LOG_FILE="$LOG_DIR/05-check-nvidia-gpu.md"

mkdir -p "$LOG_DIR"

strip_colors() {
    sed -e 's/\x1b\[[0-9;]*m//g'
}

EXIT_CODE=0

{
echo "# NVIDIA GPU Check"
echo ""
echo "**Check:** NVIDIA GPU detection and capabilities"
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

if ! command -v nvidia-smi &> /dev/null; then
    echo -e "${YELLOW}⚠ nvidia-smi command not found${NC}"
    echo ""
    echo "**Issue:** NVIDIA drivers may not be installed."
    echo ""
    echo "**Impact:** GPU acceleration will not work."
    echo ""
    echo "**Resolution:** Install NVIDIA drivers for your GPU"
    EXIT_CODE=2
else
    echo -e "${GREEN}✓ nvidia-smi is available${NC}"
    echo ""

    # Try to get GPU info
    if nvidia-smi &> /dev/null; then
        echo "## Full nvidia-smi Output"
        echo ""
        echo "\`\`\`"
        nvidia-smi 2>/dev/null
        echo "\`\`\`"
        echo ""

        echo "## GPU Information Summary"
        echo ""

        # Get GPU name
        GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null | head -1)
        if [ -n "$GPU_NAME" ]; then
            echo "**Model:** $GPU_NAME"
        fi

        # Get driver version
        DRIVER_VERSION=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader 2>/dev/null | head -1)
        if [ -n "$DRIVER_VERSION" ]; then
            echo ""
            echo "**Driver:** $DRIVER_VERSION"
        fi

        # Get CUDA version from nvidia-smi output
        CUDA_VERSION=$(nvidia-smi 2>/dev/null | grep "CUDA Version" | sed 's/.*CUDA Version: \([0-9.]*\).*/\1/' | head -1)
        if [ -n "$CUDA_VERSION" ]; then
            echo ""
            echo "**CUDA:** $CUDA_VERSION"
        fi

        # Get GPU compute capability
        GPU_COMPUTE=$(nvidia-smi --query-gpu=compute_cap --format=csv,noheader 2>/dev/null | head -1 || true)
        if [ -n "$GPU_COMPUTE" ]; then
            echo ""
            echo "**Compute Capability:** $GPU_COMPUTE"
        fi

        # Get GPU utilization
        GPU_UTIL=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
        if [ -n "$GPU_UTIL" ]; then
            echo ""
            echo "**Utilization:** ${GPU_UTIL}%"
        fi

        # Get memory info
        MEM_USED=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits 2>/dev/null | head -1)
        MEM_TOTAL=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits 2>/dev/null | head -1)
        if [ -n "$MEM_USED" ] && [ -n "$MEM_TOTAL" ]; then
            echo ""
            echo "**Memory:** ${MEM_USED}MB / ${MEM_TOTAL}MB"
        fi

        # Get temperature
        TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
        if [ -n "$TEMP" ]; then
            echo ""
            echo "**Temperature:** ${TEMP}°C"
        fi

        # Check GPU count
        GPU_COUNT=$(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null | wc -l)
        if [ "$GPU_COUNT" -gt 1 ]; then
            echo ""
            echo "**Note:** $GPU_COUNT GPUs detected (showing first GPU info)"
        fi

        echo ""
        echo "## NVIDIA Capabilities"
        echo ""

        # Check NVENC (video encoding)
        if nvidia-smi --query-gpu=encoder.stats.sessionCount --format=csv,noheader 2>/dev/null | grep -q "^[0-9]"; then
            echo "- ✓ **NVENC** (Hardware video encoding) - Available"
        else
            echo "- ? **NVENC** status - Unable to query"
        fi

        # Check NVDEC (video decoding)
        VIDEO_CLOCK=$(nvidia-smi --query-gpu=clocks.current.video --format=csv,noheader,nounits 2>/dev/null | head -1 || true)
        if [ -n "$VIDEO_CLOCK" ] && [ "$VIDEO_CLOCK" != "N/A" ]; then
            echo "- ✓ **NVDEC** (Hardware video decoding) - Available (Video clock: ${VIDEO_CLOCK} MHz)"
        else
            echo "- ? **NVDEC** status - Unable to detect"
        fi

        # Check for CUDA cores
        if [ -n "$GPU_COMPUTE" ]; then
            echo "- ✓ **CUDA Compute** - Capability $GPU_COMPUTE"
        fi

        # Check for Display output capability
        DISPLAY_ACTIVE=$(nvidia-smi --query-gpu=display_active --format=csv,noheader 2>/dev/null | head -1 || true)
        if [ "$DISPLAY_ACTIVE" = "Enabled" ]; then
            echo "- ✓ **Display Output** - Active (GPU connected to monitor)"
        elif [ "$DISPLAY_ACTIVE" = "Disabled" ]; then
            echo "- ○ **Display Output** - Disabled (headless GPU)"
        fi

        # Check persistence mode (just report, don't prompt)
        PERSISTENCE=$(nvidia-smi --query-gpu=persistence_mode --format=csv,noheader 2>/dev/null | head -1 || true)
        if [ "$PERSISTENCE" = "Enabled" ]; then
            echo "- ✓ **Persistence Mode** - Enabled (optimal for containers)"
        elif [ "$PERSISTENCE" = "Disabled" ]; then
            echo "- ○ **Persistence Mode** - Disabled"
            echo ""
            echo "  **Note:** Persistence mode keeps NVIDIA driver loaded when GPU is idle."
            echo "  Run \`./scripts/host-checks/enable-persistence-mode.sh\` to enable it."
        fi

    else
        echo -e "${RED}✗ nvidia-smi failed to query GPU${NC}"
        echo ""
        echo "**Issue:** NVIDIA drivers may not be properly installed."
        EXIT_CODE=1
    fi
fi

echo ""
echo "---"
echo ""
echo "**Check completed:** $(date)"

} | tee >(strip_colors > "$LOG_FILE") >/dev/null

exit $EXIT_CODE
