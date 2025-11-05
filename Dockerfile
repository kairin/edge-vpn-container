# Use NVIDIA CUDA Deep Learning base image with Ubuntu 24.04
FROM nvcr.io/nvidia/cuda-dl-base:25.10-cuda13.0-runtime-ubuntu24.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Copy installation scripts into the container
COPY scripts/docker-setup/ /tmp/docker-setup/

# Run modular installations in sequence
# Each script is independent and can be commented out if not needed
RUN chmod +x /tmp/docker-setup/*.sh && \
    echo "=== Installing Base Dependencies ===" && \
    /tmp/docker-setup/install-base.sh && \
    echo "=== Installing GPU Libraries ===" && \
    /tmp/docker-setup/install-gpu-libs.sh && \
    echo "=== Installing Microsoft Edge ===" && \
    /tmp/docker-setup/install-edge.sh && \
    echo "=== Cleaning up ===" && \
    rm -rf /tmp/docker-setup

# Default command
CMD ["/bin/bash"]
