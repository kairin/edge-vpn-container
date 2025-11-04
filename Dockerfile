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

# Install Microsoft Edge with proper cleanup
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /tmp/microsoft.gpg \
    && install -o root -g root -m 644 /tmp/microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends microsoft-edge-stable \
    && rm -rf /var/lib/apt/lists/* /tmp/microsoft.gpg

CMD ["/bin/bash"]
