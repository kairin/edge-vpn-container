# Host Verification Modules

Modular scripts for verifying host system configuration before building and running GPU-accelerated containers.

## Purpose

Break down host verification into independent, testable components. Each script checks one specific aspect and creates its own detailed log.

## Scripts

| Script | Checks | Exit Codes |
|--------|--------|------------|
| `check-display.sh` | DISPLAY environment variable | 0=pass, 1=error |
| `check-x11.sh` | X11 socket accessibility | 0=pass, 1=error |
| `check-xhost.sh` | xhost access control | 0=pass, 1=error, 2=warning |
| `check-docker.sh` | Docker installation & permissions | 0=pass, 1=error, 2=warning |
| `check-nvidia-gpu.sh` | GPU detection & capabilities | 0=pass, 1=error, 2=warning |
| `check-nvidia-runtime.sh` | NVIDIA Docker runtime | 0=pass, 2=warning |
| `enable-persistence-mode.sh` | NVIDIA Persistence Mode setup | Interactive (default: yes) |

## How It Works

**Run full verification:**
```bash
./scripts/verify-host.sh
```

**Creates timestamped directory:**
```
logs/verify-host/2025-11-05_17-00-00/
├── 01-check-display.md
├── 02-check-x11.md
├── 03-check-xhost.md
├── 04-check-docker.md
├── 05-check-nvidia-gpu.md
├── 06-check-nvidia-runtime.md
├── 07-enable-persistence-mode.md
└── summary.md                    # Combined summary with links
```

**Run individual check:**
```bash
./scripts/host-checks/check-nvidia-gpu.sh
```

## What Each Check Does

### 1. check-display.sh
Verifies DISPLAY environment variable is set (e.g., `:0`, `wayland-0`).

**Why:** Container needs DISPLAY to show GUI applications like Edge browser.

### 2. check-x11.sh
Checks `/tmp/.X11-unix/` directory and X11 socket files exist.

**Why:** Container needs X11 sockets to connect to display server.

### 3. check-xhost.sh
Verifies xhost utility and access control configuration.

**Why:** Container needs permission to access display server.

**Fix if needed:**
```bash
sudo apt-get install x11-xserver-utils
xhost +local:docker
```

### 4. check-docker.sh
Checks Docker installed and user has permissions (docker group vs. sudo).

**Why:** Container operations require Docker with proper permissions.

**Fix if needed:**
```bash
sudo usermod -aG docker $USER
newgrp docker
```

### 5. check-nvidia-gpu.sh
Detects NVIDIA GPU, queries capabilities (NVENC, NVDEC, CUDA), logs full nvidia-smi output.

**Why:** Verify GPU hardware is accessible for acceleration.

### 6. check-nvidia-runtime.sh
Checks NVIDIA runtime available in Docker.

**Why:** Docker needs NVIDIA runtime to provide GPU access to containers.

**Fix if needed:**
```bash
# Install NVIDIA Container Toolkit
# See: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html
```

### 7. enable-persistence-mode.sh
Prompts user to enable NVIDIA Persistence Mode (default: yes).

**Why:** Keeps NVIDIA driver loaded for instant GPU access and faster container startup.

**Trade-off:** Slightly higher idle power (~1-2W), but recommended for Docker GPU workloads.

## Exit Codes

| Code | Meaning | Description |
|------|---------|-------------|
| 0 | Pass | Check succeeded |
| 1 | Error | Critical failure, must fix |
| 2 | Warning | Non-critical, review recommended |

**Orchestrator behavior:**
- Continues all checks even if one fails
- Tracks total errors and warnings
- Reports summary at end

## Log Format

Each check creates markdown log with:
- Check name and purpose
- Timestamp
- Detailed results with status indicators (✓/✗/⚠)
- Resolution steps if failed

**Example structure:**
```markdown
# NVIDIA GPU Check

**Check:** NVIDIA GPU detection and capabilities
**Run:** 2025-11-05_17-00-00

---

## Check Results

✓ nvidia-smi is available

## GPU Information Summary

**Model:** NVIDIA GeForce RTX 4080 SUPER
**Driver:** 580.95.05
...

---

**Check completed:** Wed Nov 5 17:00:15 2025
```

## Adding New Checks

**1. Create script:**
```bash
#!/bin/bash
set -uo pipefail

LOG_DIR="${1:-logs/verify-host/$(date +%Y-%m-%d_%H-%M-%S)}"
TIMESTAMP="${2:-$(date +%Y-%m-%d_%H-%M-%S)}"
LOG_FILE="$LOG_DIR/0X-check-something.md"

mkdir -p "$LOG_DIR"

EXIT_CODE=0

{
echo "# Something Check"
echo ""
# Check logic here
# Set EXIT_CODE=1 for errors, =2 for warnings
echo ""
echo "**Check completed:** $(date)"
} | tee >(sed -e 's/\x1b\[[0-9;]*m//g' > "$LOG_FILE") >/dev/null

exit $EXIT_CODE
```

**2. Make executable:**
```bash
chmod +x scripts/host-checks/check-something.sh
```

**3. Add to orchestrator** (`scripts/verify-host.sh`):
```bash
echo "X. Checking something..."
./scripts/host-checks/check-something.sh "$LOG_DIR" "$TIMESTAMP"
STATUS=$?
# Handle exit code...
```

**4. Update summary** - Add link in summary.md generation section.

## Testing Individual Checks

```bash
# Test script syntax
bash -n scripts/host-checks/check-nvidia-gpu.sh

# Run single check
./scripts/host-checks/check-nvidia-gpu.sh

# View latest log
cat $(find logs/verify-host -name "05-check-nvidia-gpu.md" | sort | tail -1)
```

## Removing Checks

Comment out in orchestrator (`scripts/verify-host.sh`):

```bash
# echo "5. Checking NVIDIA GPU..."
# ./scripts/host-checks/check-nvidia-gpu.sh "$LOG_DIR" "$TIMESTAMP"
# # Disabled for testing
```

## Benefits

**Testable:** Run individual checks independently for debugging
**Maintainable:** One check per file, clear separation of concerns
**Extensible:** Easy to add new checks or modify existing ones
**Flexible:** Comment out unwanted checks in orchestrator
**Debuggable:** Individual logs for each component with full details

## See Also

- [Main README](../../README.md) - Project overview
- [verify-host.sh](../verify-host.sh) - Orchestrator script
- [Logs README](../../logs/verify-host/README.md) - Log documentation
