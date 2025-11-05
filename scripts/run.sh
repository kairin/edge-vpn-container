#!/bin/bash
set -euo pipefail

# Check if image exists
if ! docker image inspect cuda-container &> /dev/null; then
    echo "❌ Error: cuda-container image not found!"
    echo ""
    echo "Please build the image first by running:"
    echo "  ./scripts/build.sh"
    echo ""
    exit 1
fi

# Create log directory for container sessions
LOG_DIR="logs/container-sessions"
mkdir -p "$LOG_DIR"

# Generate timestamped log filename
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
TEMP_LOG="$LOG_DIR/.session-${TIMESTAMP}.tmp"
SESSION_LOG="$LOG_DIR/session-${TIMESTAMP}.md"

echo "Launching container..."
echo "Session will be logged to: $SESSION_LOG"
echo ""

# Create markdown header
cat > "$SESSION_LOG" << EOF
# Container Session Log

**Started:** $(date)
**Container:** cuda-container
**User:** $(id -un) ($(id -u):$(id -g))
**Display:** ${DISPLAY}

---

## Session Output

\`\`\`
EOF

# Launch container with session logging using script command
script -q -c "docker run --runtime=nvidia -it --rm \
  --name cuda-container \
  --user \"$(id -u):$(id -g)\" \
  -e HOME=\"$HOME\" \
  -e DISPLAY=\"${DISPLAY}\" \
  --network=host \
  --ipc=host \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v \"$HOME:$HOME:rw\" \
  cuda-container" "$TEMP_LOG"

# Strip ANSI codes and control sequences, append to markdown
sed -e 's/\x1b\[[0-9;]*m//g' \
    -e 's/\x1b\][0-9];[^\x07]*\x07//g' \
    -e 's/\x1b\[[?][0-9]*[hl]//g' \
    -e 's/\r//g' \
    "$TEMP_LOG" >> "$SESSION_LOG"

# Close markdown code block and add footer
cat >> "$SESSION_LOG" << EOF
\`\`\`

---

**Ended:** $(date)
**Session Duration:** Logged to \`$SESSION_LOG\`
EOF

# Remove temp file
rm -f "$TEMP_LOG"

echo ""
echo "========================================"
echo "Session log saved to: $SESSION_LOG"
echo "========================================"
