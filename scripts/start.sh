#!/bin/bash
set -euo pipefail

# Startup script for Microsoft Edge in container
# Initializes D-Bus and launches Edge with optimal settings

# Start D-Bus session daemon if not already running
if [ -z "${DBUS_SESSION_BUS_ADDRESS:-}" ]; then
    # Start dbus-daemon and export variables
    eval "$(dbus-launch --sh-syntax)"
    export DBUS_SESSION_BUS_ADDRESS
    export DBUS_SESSION_BUS_PID

    # Ensure D-Bus cleanup on exit
    trap "kill ${DBUS_SESSION_BUS_PID} 2>/dev/null || true" EXIT INT TERM
fi

# Suppress specific non-critical D-Bus errors by redirecting stderr
# This preserves exit codes while filtering noise
exec 2> >(grep -v "Failed to connect to the bus: Failed to connect to socket /run/dbus/system_bus_socket" >&2)

# Launch Microsoft Edge with Wayland support and GPU acceleration
# Using 'exec' to replace shell process (container will exit when Edge exits)

# Detect if NVIDIA GPU is available
if [ -e "/dev/nvidia0" ] && [ -n "${NVIDIA_VISIBLE_DEVICES:-}" ]; then
    # NVIDIA GPU - use native OpenGL and Vulkan for best performance
    exec microsoft-edge-stable \
        --enable-features=UseOzonePlatform,VaapiVideoDecoder,Vulkan \
        --ozone-platform=wayland \
        --disable-dev-shm-usage \
        --enable-gpu-rasterization \
        --enable-zero-copy \
        --enable-native-gpu-memory-buffers \
        --ignore-gpu-blocklist \
        --window-size=1280,800 \
        --window-position=100,100
else
    # Fallback - use ANGLE for software/Intel/AMD GPUs
    exec microsoft-edge-stable \
        --enable-features=UseOzonePlatform,VaapiVideoDecoder \
        --ozone-platform=wayland \
        --disable-dev-shm-usage \
        --use-gl=angle \
        --use-angle=gl \
        --ignore-gpu-blocklist \
        --window-size=1280,800 \
        --window-position=100,100
fi
