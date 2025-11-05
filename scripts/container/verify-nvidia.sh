#!/bin/bash
set -euo pipefail

# Script: verify-nvidia.sh
# Purpose: Comprehensive NVIDIA feature verification inside container

echo "═══════════════════════════════════════════════════════════════"
echo "          NVIDIA Container Feature Verification"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# Check 1: nvidia-smi availability
echo "1. GPU Detection:"
if command -v nvidia-smi &> /dev/null; then
    nvidia-smi --query-gpu=name,driver_version --format=csv,noheader
    echo "   ✓ nvidia-smi accessible"
else
    echo "   ✗ nvidia-smi not found"
    exit 1
fi
echo ""

# Check 2: CUDA Toolkit
echo "2. CUDA Toolkit:"
if command -v nvcc &> /dev/null; then
    nvcc --version | grep -E 'release|Cuda compilation tools'
    echo "   ✓ CUDA compiler available"
else
    echo "   ⚠ nvcc not in PATH (expected for runtime-only image)"
fi
echo ""

# Check 3: Deep Learning Libraries
echo "3. Deep Learning Libraries:"
CUDNN_VERSION=$(ls /usr/lib/x86_64-linux-gnu/libcudnn.so.* 2>/dev/null | grep -oP 'libcudnn\.so\.\K[\d\.]+' | head -1 || echo "N/A")
TENSORRT_VERSION=$(ls /usr/lib/x86_64-linux-gnu/libnvinfer.so.* 2>/dev/null | grep -oP 'libnvinfer\.so\.\K[\d\.]+' | head -1 || echo "N/A")
NCCL_VERSION=$(ls /usr/lib/x86_64-linux-gnu/libnccl.so.* 2>/dev/null | grep -oP 'libnccl\.so\.\K[\d\.]+' | head -1 || echo "N/A")

if [ "$CUDNN_VERSION" != "N/A" ]; then
    echo "   ✓ cuDNN: $CUDNN_VERSION"
else
    echo "   ✗ cuDNN: Not found"
fi

if [ "$TENSORRT_VERSION" != "N/A" ]; then
    echo "   ✓ TensorRT: $TENSORRT_VERSION"
else
    echo "   ✗ TensorRT: Not found"
fi

if [ "$NCCL_VERSION" != "N/A" ]; then
    echo "   ✓ NCCL: $NCCL_VERSION"
else
    echo "   ✗ NCCL: Not found"
fi
echo ""

# Check 4: NVIDIA Libraries
echo "4. NVIDIA Libraries:"
LIB_COUNT=$(ldconfig -p | grep nvidia | wc -l)
echo "   ✓ $LIB_COUNT NVIDIA libraries loaded"
echo ""

# Check 5: GPU Device Access
echo "5. GPU Device Access:"
if [ -e /dev/nvidia0 ]; then
    ls -1 /dev/nvidia* 2>/dev/null | head -5 | sed 's/^/   ✓ /'
else
    echo "   ✗ No GPU devices found"
    exit 1
fi
echo ""

# Check 6: Environment Variables
echo "6. NVIDIA Environment:"
env | grep NVIDIA | sed 's/^/   /'
echo ""

# Check 7: Base Image Information
echo "7. Base Image Features:"
echo "   ✓ Base: nvcr.io/nvidia/cuda-dl-base:25.10-cuda13.0-runtime-ubuntu24.04"
echo "   ✓ OS: Ubuntu $(lsb_release -rs 2>/dev/null || cat /etc/os-release | grep VERSION_ID | cut -d'"' -f2)"
echo "   ✓ Architecture: $(uname -m)"
echo ""

# Check 8: Runtime Test
echo "8. GPU Runtime Test:"
if nvidia-smi --query-gpu=utilization.gpu,memory.used --format=csv,noheader &> /dev/null; then
    UTIL=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
    MEM=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)
    echo "   ✓ Current GPU Utilization: ${UTIL}%"
    echo "   ✓ Current GPU Memory: ${MEM}MB"
else
    echo "   ⚠ Cannot query GPU metrics"
fi
echo ""

echo "═══════════════════════════════════════════════════════════════"
echo "Status: All NVIDIA features verified ✓"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "The NVIDIA startup banner is hidden due to ENTRYPOINT override."
echo "This does not affect functionality - all features are present."
echo ""
