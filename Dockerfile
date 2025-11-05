# Use NVIDIA CUDA Deep Learning base image with Ubuntu 24.04
FROM nvcr.io/nvidia/cuda-dl-base:25.10-cuda13.0-runtime-ubuntu24.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Install dependencies in a single layer with proper cleanup
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Microsoft Edge and GPU acceleration libraries with proper cleanup
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /tmp/microsoft.gpg \
    && install -o root -g root -m 644 /tmp/microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        microsoft-edge-stable \
        va-driver-all \
        mesa-va-drivers \
        libva2 \
        vainfo \
    && rm -rf /var/lib/apt/lists/* /tmp/microsoft.gpg

# Copy container scripts and make them executable
COPY scripts/container/ /container-scripts/
RUN chmod +x /container-scripts/*.sh

# Add container scripts to PATH
ENV PATH="/container-scripts:${PATH}"

# Override NVIDIA entrypoint to avoid permission issues with --user flag
# The NVIDIA entrypoint is designed for root-level CUDA setup, but we run as non-root
# Use our custom entrypoint that displays NVIDIA verification on startup
ENTRYPOINT []

CMD ["/container-scripts/container-entrypoint.sh"]
