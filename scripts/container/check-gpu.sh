#!/bin/bash
set -euo pipefail

# Script: check-gpu.sh
# Purpose: In-container GPU status monitoring

WATCH_MODE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --watch)
            WATCH_MODE=true
            shift
            ;;
        --help)
            cat << EOF
Usage: check-gpu.sh [OPTIONS]

Display GPU status and utilization metrics

OPTIONS:
  --watch    Monitor GPU continuously (refresh every 2 seconds)
  --help     Show this help message

OUTPUT:
  GPU Name and Driver Version
  GPU Utilization (%)
  Memory Usage (MB used / MB total)
  GPU Temperature (°C)
  Active GPU Processes

EXAMPLES:
  # Single check
  check-gpu.sh

  # Continuous monitoring
  check-gpu.sh --watch
EOF
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            echo "Use --help for usage information" >&2
            exit 1
            ;;
    esac
done

# Function to display GPU status
show_gpu_status() {
    if ! command -v nvidia-smi &> /dev/null; then
        echo "✗ nvidia-smi not available" >&2
        echo "NVIDIA runtime may not be configured correctly" >&2
        return 1
    fi

    echo "======================================================================"
    echo "                  GPU Status"
    echo "======================================================================"

    # GPU Name
    GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null || echo "Unknown")
    echo "GPU: $GPU_NAME"

    # Driver Version
    DRIVER=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader 2>/dev/null || echo "Unknown")
    echo "Driver: $DRIVER"

    echo "----------------------------------------------------------------------"

    # Utilization
    GPU_UTIL=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader 2>/dev/null || echo "N/A")
    echo "GPU Utilization: $GPU_UTIL"

    # Memory
    GPU_MEM=$(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader 2>/dev/null || echo "N/A")
    echo "GPU Memory: $GPU_MEM"

    # Temperature
    GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader 2>/dev/null || echo "N/A")
    echo "GPU Temperature: ${GPU_TEMP}°C"

    # Processes
    PROCESS_COUNT=$(nvidia-smi --query-compute-apps=pid --format=csv,noheader 2>/dev/null | wc -l || echo "0")
    echo "Active GPU Processes: $PROCESS_COUNT"

    if [ "$PROCESS_COUNT" -gt 0 ]; then
        echo ""
        echo "GPU Processes:"
        nvidia-smi --query-compute-apps=pid,name,used_memory --format=csv,noheader 2>/dev/null | \
            awk -F',' '{printf "  PID %-8s %-30s %s\n", $1, $2, $3}' || true
    fi

    echo "======================================================================"
}

# Main execution
if [ "$WATCH_MODE" = true ]; then
    echo "Monitoring GPU (press Ctrl+C to stop)..."
    echo ""
    while true; do
        clear
        show_gpu_status
        sleep 2
    done
else
    show_gpu_status
fi
