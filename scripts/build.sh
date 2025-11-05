#!/bin/bash
set -euo pipefail

# Create log directory for docker builds
LOG_DIR="logs/docker-builds"
mkdir -p "$LOG_DIR"

# Generate timestamped log filename
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
TEMP_LOG="$LOG_DIR/.build-${TIMESTAMP}.tmp"
BUILD_LOG="$LOG_DIR/build-${TIMESTAMP}.md"

echo "Building cuda-container image..."
echo "Build process will be logged to: $BUILD_LOG"
echo ""

# Create markdown header
cat > "$BUILD_LOG" << EOF
# Docker Build Log

**Started:** $(date)
**Image:** cuda-container
**Base:** nvcr.io/nvidia/cuda-dl-base:25.10-cuda13.0-runtime-ubuntu24.04

---

## Build Output

\`\`\`
EOF

# Run docker build and capture output
script -q -c "docker build -t cuda-container ." "$TEMP_LOG"

# Strip ANSI codes and control sequences, append to markdown
sed -e 's/\x1b\[[0-9;]*m//g' \
    -e 's/\x1b\][0-9];[^\x07]*\x07//g' \
    -e 's/\x1b\[[?][0-9]*[hl]//g' \
    -e 's/\r//g' \
    "$TEMP_LOG" >> "$BUILD_LOG"

# Close markdown code block and add footer
cat >> "$BUILD_LOG" << EOF
\`\`\`

---

**Ended:** $(date)
**Build log:** \`$BUILD_LOG\`
EOF

# Remove temp file
rm -f "$TEMP_LOG"

echo ""
echo "========================================"
echo "Build completed successfully!"
echo "Build log saved to: $BUILD_LOG"
echo "========================================"
echo ""
echo "You can now run ./scripts/run.sh to launch the container"
