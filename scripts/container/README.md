# Container Scripts

This directory contains scripts that are copied into the Docker container during build and executed from within the container environment.

## Purpose

These scripts provide in-container functionality for GPU-accelerated Microsoft Edge browser usage:

- **launch-edge.sh**: Helper script to launch Microsoft Edge with GPU acceleration flags
- **check-gpu.sh**: GPU status monitoring tool for verifying NVIDIA runtime accessibility
- **verify-nvidia.sh**: Comprehensive NVIDIA feature verification (CUDA, cuDNN, TensorRT, NCCL)

## Usage

These scripts are automatically copied to `/container-scripts/` inside the Docker image during the build process. They are added to the PATH for easy access.

### From Inside Container

After running `./run.sh` to start the container:

```bash
# Launch Edge browser with GPU acceleration
launch-edge.sh

# Launch Edge with specific URL
launch-edge.sh --url=https://example.com

# Launch Edge with custom flags
launch-edge.sh --flags="--incognito --disable-extensions"

# Launch without GPU flags (troubleshooting)
launch-edge.sh --no-gpu-flags

# Check GPU status
check-gpu.sh

# Monitor GPU continuously
check-gpu.sh --watch

# Verify all NVIDIA features are present
verify-nvidia.sh
```

## Script Details

### launch-edge.sh

Launches Microsoft Edge browser with recommended GPU acceleration flags for optimal performance in containerized environment.

**Default GPU Flags Applied**:
- `--enable-features=VaapiVideoDecoder` (hardware video decoding)
- `--use-gl=egl` (OpenGL via EGL for container compatibility)
- `--ignore-gpu-blocklist` (bypass browser GPU blocklist)
- `--disable-gpu-driver-bug-workarounds` (trust recent NVIDIA drivers)

**Reference**: See `specs/001-nvidia-runtime-verification/contracts/launch-edge.sh.contract.md` for full interface specification.

### check-gpu.sh

Displays current GPU utilization, memory usage, temperature, and process information.

**Output Includes**:
- GPU name and driver version
- GPU utilization percentage
- Memory usage (used/total)
- GPU temperature
- Active GPU processes

**Reference**: See `specs/001-nvidia-runtime-verification/quickstart.md` for usage examples.

### verify-nvidia.sh

Comprehensive verification that all NVIDIA features from the base image are present and functional. This script confirms that the `ENTRYPOINT` override (needed for permission compatibility) did not remove any NVIDIA functionality.

**Verifies**:
- GPU detection via nvidia-smi
- CUDA Toolkit (13.0)
- Deep Learning libraries (cuDNN 9.14, TensorRT 10.13, NCCL 2.27)
- NVIDIA library count (27 libraries)
- GPU device access (/dev/nvidia*)
- NVIDIA environment variables
- Runtime GPU metrics

**Note**: The NVIDIA startup banner is hidden due to `ENTRYPOINT []` override in Dockerfile. This is required for `--user` flag compatibility and does not affect functionality. All features inherited from `nvcr.io/nvidia/cuda-dl-base:25.10-cuda13.0-runtime-ubuntu24.04` are present.

## Build Integration

These scripts are copied into the container image by the Dockerfile:

```dockerfile
COPY scripts/container/ /container-scripts/
RUN chmod +x /container-scripts/*.sh
ENV PATH="/container-scripts:${PATH}"
```

## Development

When modifying these scripts:

1. Test locally before rebuilding container
2. Ensure scripts are executable (`chmod +x`)
3. Follow bash best practices (`set -euo pipefail`)
4. Update this README if adding new scripts
5. Document changes in `docs/` with dated files

## References

- **Specification**: `specs/001-nvidia-runtime-verification/spec.md`
- **Contracts**: `specs/001-nvidia-runtime-verification/contracts/`
- **Quick Start Guide**: `specs/001-nvidia-runtime-verification/quickstart.md`
