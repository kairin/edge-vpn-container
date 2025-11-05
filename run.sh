#!/bin/bash
set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Pre-launch checks
check_docker() {
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}✗ Docker not installed${NC}" >&2
        echo "Install Docker:" >&2
        echo "  Ubuntu/Debian: sudo apt install docker.io" >&2
        echo "  Fedora: sudo dnf install docker" >&2
        echo "  Arch: sudo pacman -S docker" >&2
        exit 1
    fi

    if ! docker ps &> /dev/null; then
        echo -e "${RED}✗ Cannot access Docker${NC}" >&2
        echo "Ensure Docker is running and you have permissions:" >&2
        echo "  sudo systemctl start docker" >&2
        echo "  sudo usermod -aG docker \$USER" >&2
        exit 1
    fi
}

check_gpu() {
    if [ ! -e /dev/nvidia0 ]; then
        echo -e "${RED}✗ No NVIDIA GPU detected${NC}" >&2
        echo "Ensure NVIDIA drivers are installed:" >&2
        echo "  nvidia-smi should show your GPU" >&2
        echo "Install NVIDIA Container Toolkit:" >&2
        echo "  https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/" >&2
        exit 2
    fi

    if ! nvidia-smi &>/dev/null; then
        echo -e "${RED}✗ nvidia-smi not accessible${NC}" >&2
        echo "NVIDIA drivers may not be installed correctly" >&2
        exit 2
    fi
}

# Function: Calculate shared memory size
# Logic: max(4GB, min(50% GPU memory, 8GB))
# Returns: SHM_SIZE in MB
calculate_shm_size() {
    local GPU_MEM_MB
    GPU_MEM_MB=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits 2>/dev/null | head -1 | tr -d '[:space:]')

    if [ -z "$GPU_MEM_MB" ] || [ "$GPU_MEM_MB" -eq 0 ]; then
        echo "4096"  # Default 4GB if GPU memory query fails
        return
    fi

    local SHM_SIZE=$((GPU_MEM_MB / 2))

    # Enforce minimum 4GB (4096 MB)
    if [ $SHM_SIZE -lt 4096 ]; then
        SHM_SIZE=4096
    fi

    # Enforce maximum 8GB (8192 MB)
    if [ $SHM_SIZE -gt 8192 ]; then
        SHM_SIZE=8192
    fi

    echo "$SHM_SIZE"
}

# Function: Detect display protocol (prioritize X11 over Wayland)
# Returns: DISPLAY_VAR and DISPLAY_MOUNT for docker run
detect_display_protocol() {
    if [ -n "${DISPLAY:-}" ]; then
        # X11 available - prioritize this
        export DISPLAY_VAR="$DISPLAY"
        export DISPLAY_MOUNT="/tmp/.X11-unix:/tmp/.X11-unix:rw"
        export DISPLAY_PROTOCOL="X11"
    elif [ -n "${WAYLAND_DISPLAY:-}" ] && [ -n "${XDG_RUNTIME_DIR:-}" ]; then
        # Wayland available - use XWayland compatibility
        export DISPLAY_VAR=":0"
        export DISPLAY_MOUNT="${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:ro"
        export DISPLAY_PROTOCOL="Wayland (via XWayland)"
    else
        echo "✗ No display server detected" >&2
        echo "Ensure you're running in a graphical environment:" >&2
        echo "  X11: echo \$DISPLAY should show :0 or similar" >&2
        echo "  Wayland: echo \$WAYLAND_DISPLAY should show wayland-0 or similar" >&2
        exit 3
    fi
}

# Run pre-launch checks
check_docker
check_gpu

# Calculate shared memory and container memory
SHM_SIZE_MB=$(calculate_shm_size)
CONTAINER_MEM_MB=$((SHM_SIZE_MB + 2048))

# Detect display protocol
detect_display_protocol

# Create required directories if missing
mkdir -p "$HOME/Downloads"
mkdir -p "$HOME/.config/microsoft-edge-docker"

echo -e "${GREEN}===================================================================${NC}"
echo -e "${GREEN}           Edge GPU Container Launch${NC}"
echo -e "${GREEN}===================================================================${NC}"
echo -e "${GREEN}✓${NC} Shared Memory: ${SHM_SIZE_MB}MB"
echo -e "${GREEN}✓${NC} Container RAM: ${CONTAINER_MEM_MB}MB"
echo -e "${GREEN}✓${NC} Display Protocol: ${DISPLAY_PROTOCOL}"
echo -e "${GREEN}===================================================================${NC}"

# Build image if it doesn't exist
if ! docker image inspect edge-nvidia &> /dev/null; then
    echo -e "${YELLOW}Building edge-nvidia image...${NC}"
    if ! docker build -t edge-nvidia .; then
        echo -e "${RED}✗ Image build failed${NC}" >&2
        exit 4
    fi
fi

echo -e "${GREEN}Launching container with NVIDIA runtime...${NC}"

# Launch container with full configuration
# Note: no-new-privileges is incompatible with --runtime=nvidia
# The NVIDIA runtime requires privilege elevation for GPU access
# Note: --ipc=host required for X11 shared memory communication
# Note: --device=/dev/dri required for browser hardware acceleration
docker run --runtime=nvidia -it --rm \
  --name edge-nvidia \
  -e NVIDIA_VISIBLE_DEVICES=all \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  -e DISPLAY="${DISPLAY_VAR}" \
  --network=host \
  --ipc=host \
  --device=/dev/dri \
  --shm-size="${SHM_SIZE_MB}m" \
  --memory="${CONTAINER_MEM_MB}m" \
  --cpus=4 \
  --user "$(id -u):$(id -g)" \
  -v "${DISPLAY_MOUNT}" \
  -v "$HOME/Downloads:$HOME/Downloads:rw" \
  -v "$HOME/.config/microsoft-edge-docker:$HOME/.config/microsoft-edge:rw" \
  edge-nvidia
