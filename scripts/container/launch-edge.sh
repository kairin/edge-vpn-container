#!/bin/bash
set -euo pipefail

# Default GPU acceleration flags
DEFAULT_GPU_FLAGS=(
    "--enable-features=VaapiVideoDecoder"
    "--use-gl=egl"
    "--ignore-gpu-blocklist"
    "--disable-gpu-driver-bug-workarounds"
)

# Required flags for containerized environment
# These flags disable Chromium's sandboxing which conflicts with Docker's isolation
# Security is maintained via Docker's security controls (resource limits, non-root user, network isolation)
CONTAINER_FLAGS=(
    "--no-sandbox"              # Disable Chromium namespace sandbox (Docker provides isolation)
)

# Parse command-line arguments
URL=""
PROFILE_DIR=""
ADDITIONAL_FLAGS=()
USE_GPU_FLAGS=true

show_help() {
    cat << EOF
Usage: launch-edge.sh [OPTIONS]

Launch Microsoft Edge with GPU acceleration flags

OPTIONS:
  --url=URL             Open specific URL on launch
  --profile=PATH        Use custom profile directory
  --flags="FLAGS"       Additional browser flags (quoted)
  --no-gpu-flags        Skip recommended GPU flags (troubleshooting)
  --help                Show this help message

EXAMPLES:
  # Basic launch with GPU flags
  launch-edge.sh

  # Open specific website
  launch-edge.sh --url=https://example.com

  # Troubleshooting without GPU flags
  launch-edge.sh --no-gpu-flags

  # Custom flags
  launch-edge.sh --flags="--incognito --disable-extensions"

GPU ACCELERATION FLAGS (enabled by default):
  --enable-features=VaapiVideoDecoder
  --use-gl=egl
  --ignore-gpu-blocklist
  --disable-gpu-driver-bug-workarounds

VERIFY GPU ACCELERATION:
  1. Launch browser
  2. Navigate to edge://gpu
  3. Check "Graphics Feature Status" shows "Hardware accelerated"

ENVIRONMENT:
  DISPLAY must be set (X11 or Wayland)
  GPU accessible via nvidia-smi (recommended but not required)

EXIT CODES:
  0  Browser launched successfully
  1  microsoft-edge not found
  2  No display server available
  3  GPU not accessible (warning only)
EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --url=*)
            URL="${1#*=}"
            shift
            ;;
        --profile=*)
            PROFILE_DIR="${1#*=}"
            shift
            ;;
        --flags=*)
            IFS=' ' read -ra ADDITIONAL_FLAGS <<< "${1#*=}"
            shift
            ;;
        --no-gpu-flags)
            USE_GPU_FLAGS=false
            shift
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            echo "Use --help for usage information" >&2
            exit 1
            ;;
    esac
done

# Pre-launch checks
if ! command -v microsoft-edge &> /dev/null; then
    echo "✗ microsoft-edge executable not found" >&2
    echo "Ensure Edge is installed in the container." >&2
    exit 1
fi

if [ -z "${DISPLAY:-}" ]; then
    echo "✗ No display server detected" >&2
    echo "DISPLAY environment variable must be set." >&2
    echo "Ensure run.sh forwarded display server correctly." >&2
    exit 2
fi

# Check GPU accessibility (warning only, not fatal)
if ! nvidia-smi &>/dev/null; then
    echo "⚠ WARNING: GPU not accessible" >&2
    echo "Browser will launch but may use software rendering." >&2
    echo "Check NVIDIA runtime configuration in run.sh." >&2
    echo "" >&2
    echo "Launching browser anyway..." >&2
fi

# Build command
CMD=(microsoft-edge)

# Add container-required flags (always needed)
CMD+=("${CONTAINER_FLAGS[@]}")

# Add GPU flags if enabled
if [ "$USE_GPU_FLAGS" = true ]; then
    CMD+=("${DEFAULT_GPU_FLAGS[@]}")
    echo "✓ GPU acceleration flags enabled"
else
    echo "⚠ GPU acceleration flags disabled (troubleshooting mode)"
fi

# Add profile directory if specified
if [ -n "$PROFILE_DIR" ]; then
    mkdir -p "$PROFILE_DIR"
    CMD+=("--user-data-dir=$PROFILE_DIR")
    echo "✓ Using custom profile: $PROFILE_DIR"
fi

# Add additional flags
if [ ${#ADDITIONAL_FLAGS[@]} -gt 0 ]; then
    CMD+=("${ADDITIONAL_FLAGS[@]}")
    echo "✓ Additional flags: ${ADDITIONAL_FLAGS[*]}"
fi

# Add URL if specified
if [ -n "$URL" ]; then
    CMD+=("$URL")
    echo "✓ Opening URL: $URL"
fi

# Launch browser
echo "Launching Microsoft Edge..."
exec "${CMD[@]}"
