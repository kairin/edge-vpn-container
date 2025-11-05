# Host Verification Check Modules

Modular scripts for verifying host system configuration before running containers.

## Purpose

These scripts break down the host verification process into independent, testable components. Each script verifies one specific aspect of the system and creates its own detailed log file.

## Scripts Overview

### Core Check Scripts

| Script | Check | Exit Codes |
|--------|-------|------------|
| `check-display.sh` | DISPLAY environment variable | 0=pass, 1=error |
| `check-x11.sh` | X11 socket accessibility | 0=pass, 1=error |
| `check-xhost.sh` | xhost access control | 0=pass, 1=error, 2=warning |
| `check-docker.sh` | Docker installation & permissions | 0=pass, 1=error, 2=warning |
| `check-nvidia-gpu.sh` | NVIDIA GPU detection & capabilities | 0=pass, 1=error, 2=warning |
| `check-nvidia-runtime.sh` | NVIDIA Docker runtime | 0=pass, 2=warning |

### Configuration Scripts

| Script | Purpose | User Interaction |
|--------|---------|------------------|
| `enable-persistence-mode.sh` | Enable NVIDIA Persistence Mode | Prompts user (default: yes) |

---

## Usage

### Run Full Verification

The main orchestrator runs all checks automatically:

```bash
./scripts/verify-host.sh
```

**Creates:**
```
logs/verify-host/2025-11-05_17-00-00/
├── 01-check-display.md
├── 02-check-x11.md
├── 03-check-xhost.md
├── 04-check-docker.md
├── 05-check-nvidia-gpu.md
├── 06-check-nvidia-runtime.md
├── 07-enable-persistence-mode.md
└── summary.md
```

### Run Individual Check

Test a specific check:

```bash
./scripts/host-checks/check-nvidia-gpu.sh
# Creates: logs/verify-host/<timestamp>/05-check-nvidia-gpu.md
```

With custom log directory:

```bash
LOG_DIR="logs/verify-host/test-run"
TIMESTAMP="2025-11-05_17-00-00"
./scripts/host-checks/check-nvidia-gpu.sh "$LOG_DIR" "$TIMESTAMP"
```

---

## Individual Check Details

### 1. check-display.sh - DISPLAY Variable

**Checks:**
- DISPLAY environment variable is set
- Value indicates available display server

**Pass Criteria:**
- ✓ DISPLAY is set (e.g., `:0`, `wayland-0`)

**Failure Impact:**
- Container cannot show GUI applications
- Edge browser will fail to start

**Resolution:**
```bash
# Check current DISPLAY
echo $DISPLAY

# Usually set automatically by X11/Wayland
# If not set, start display server first
```

---

### 2. check-x11.sh - X11 Sockets

**Checks:**
- `/tmp/.X11-unix/` directory exists
- X11 socket files present (X0, X1, etc.)

**Pass Criteria:**
- ✓ At least one X11 socket file exists

**Failure Impact:**
- No connection to display server
- GUI applications cannot render

**Resolution:**
```bash
# Check X11 sockets
ls -la /tmp/.X11-unix/

# Ensure X server is running
# Usually starts automatically with desktop environment
```

---

### 3. check-xhost.sh - Access Control

**Checks:**
- xhost utility installed
- Access control configuration
- Local Docker access permissions

**Pass Criteria:**
- ✓ Access control enabled
- ✓ Local connections allowed

**Warning Conditions:**
- ⚠ xhost not installed
- ⚠ Access control disabled (insecure)
- ⚠ Docker access not allowed

**Resolution:**
```bash
# Install xhost
sudo apt-get install x11-xserver-utils

# Enable access control
xhost -

# Allow Docker containers
xhost +local:docker
```

---

### 4. check-docker.sh - Docker

**Checks:**
- Docker command available
- Docker daemon accessible
- User permissions (sudo vs. docker group)

**Pass Criteria:**
- ✓ Docker installed
- ✓ User can run Docker without sudo

**Warning Conditions:**
- ⚠ User requires sudo for Docker

**Resolution:**
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Log out and back in for changes to take effect
# Or run: newgrp docker
```

---

### 5. check-nvidia-gpu.sh - NVIDIA GPU

**Checks:**
- nvidia-smi available
- GPU detection and status
- Full nvidia-smi output
- GPU capabilities:
  - NVENC (video encoding)
  - NVDEC (video decoding)
  - CUDA compute capability
  - Display output status
  - Persistence mode status

**Pass Criteria:**
- ✓ nvidia-smi works
- ✓ GPU detected and accessible

**Warning Conditions:**
- ⚠ nvidia-smi not found
- ⚠ GPU capabilities cannot be queried

**Log Contents:**
- Complete nvidia-smi output
- GPU model and driver version
- CUDA version
- Memory usage and temperature
- All capability checks

**Note:** Does NOT prompt for persistence mode (see `enable-persistence-mode.sh`)

---

### 6. check-nvidia-runtime.sh - NVIDIA Runtime

**Checks:**
- NVIDIA runtime in Docker info
- Available Docker runtimes list

**Pass Criteria:**
- ✓ NVIDIA runtime detected in Docker

**Warning Conditions:**
- ⚠ NVIDIA runtime not found

**Resolution:**
```bash
# Install NVIDIA Container Toolkit
# See: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html

# Ubuntu example:
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
    sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```

---

### 7. enable-persistence-mode.sh - Persistence Mode

**Purpose:** Optionally enable NVIDIA Persistence Mode for better container performance

**Interactive Prompt:**
- Always asks user: "Enable Persistence Mode now? [Y/n]"
- Default: Yes (press Enter)
- User can decline by typing 'n'

**What it does:**
- Checks current persistence mode status
- Explains benefits and trade-offs
- Prompts user (default yes)
- Runs `sudo nvidia-smi -pm 1` if accepted

**Benefits:**
- Keeps NVIDIA driver loaded when GPU idle
- Instant GPU access for containers
- Faster container startup time
- Recommended for Docker GPU workloads

**Trade-offs:**
- Slightly higher idle power (~1-2W)
- NVIDIA driver stays in memory

**Manual Enable:**
```bash
sudo nvidia-smi -pm 1
```

---

## Exit Codes

All check scripts use consistent exit codes:

| Code | Meaning | Description |
|------|---------|-------------|
| 0 | Pass | Check succeeded, no issues |
| 1 | Error | Critical failure, must be fixed |
| 2 | Warning | Non-critical issue, should review |

**Orchestrator behavior:**
- Continues all checks even if one fails
- Tracks total errors and warnings
- Reports summary at end
- Exits with error (1) if any critical errors found

---

## Logging Structure

### Timestamped Directory

Each verification run creates a timestamped directory:

```
logs/verify-host/2025-11-05_17-00-00/
├── 01-check-display.md          # Individual check logs
├── 02-check-x11.md
├── 03-check-xhost.md
├── 04-check-docker.md
├── 05-check-nvidia-gpu.md
├── 06-check-nvidia-runtime.md
├── 07-enable-persistence-mode.md
└── summary.md                    # Combined summary
```

### Log File Format

Each log is markdown with:
- Check name and purpose
- Timestamp
- Detailed results
- Status indicators (✓/✗/⚠)
- Resolution steps if failed
- Completion timestamp

**Example:**
```markdown
# NVIDIA GPU Check

**Check:** NVIDIA GPU detection and capabilities
**Run:** 2025-11-05_17-00-00

---

## Check Results

✓ nvidia-smi is available

## Full nvidia-smi Output

```
[nvidia-smi output]
```

## GPU Information Summary

**Model:** NVIDIA GeForce RTX 4080 SUPER
**Driver:** 580.95.05
**CUDA:** 13.0
...

---

**Check completed:** Wed Nov 5 17:00:15 2025
```

### Summary File

The summary.md file contains:
- Overall status
- Error/warning counts
- Links to individual check logs
- Quick navigation

---

## Adding New Checks

### 1. Create Check Script

**Template:**
```bash
#!/bin/bash
# Description of what this checks
set -uo pipefail

LOG_DIR="${1:-logs/verify-host/$(date +%Y-%m-%d_%H-%M-%S)}"
TIMESTAMP="${2:-$(date +%Y-%m-%d_%H-%M-%S)}"
LOG_FILE="$LOG_DIR/0X-check-something.md"

mkdir -p "$LOG_DIR"

strip_colors() {
    sed -e 's/\x1b\[[0-9;]*m//g'
}

EXIT_CODE=0

{
echo "# Something Check"
echo ""
echo "**Check:** What this verifies"
echo "**Run:** $TIMESTAMP"
echo ""
echo "---"
echo ""

# Your check logic here
# Set EXIT_CODE=1 for errors, =2 for warnings

echo ""
echo "---"
echo ""
echo "**Check completed:** $(date)"

} | tee >(strip_colors > "$LOG_FILE") >/dev/null

exit $EXIT_CODE
```

### 2. Make Executable

```bash
chmod +x scripts/host-checks/check-something.sh
```

### 3. Add to Orchestrator

Edit `scripts/verify-host.sh`:

```bash
echo "X. Checking something..."
./scripts/host-checks/check-something.sh "$LOG_DIR" "$TIMESTAMP"
STATUS=$?
if [ $STATUS -eq 1 ]; then
    ((ERRORS++))
    echo -e "   ${RED}✗ Error${NC}"
elif [ $STATUS -eq 2 ]; then
    ((WARNINGS++))
    echo -e "   ${YELLOW}⚠ Warning${NC}"
else
    echo -e "   ${GREEN}✓ Pass${NC}"
fi
echo ""
```

### 4. Update Summary

Add link in summary.md generation section.

---

## Troubleshooting

### Check fails during verification

**View detailed log:**
```bash
# Find latest run
cat $(find logs/verify-host -name "05-check-nvidia-gpu.md" | sort | tail -1)
```

**Test check independently:**
```bash
# Run single check for debugging
./scripts/host-checks/check-nvidia-gpu.sh
```

### Logs not created

**Check permissions:**
```bash
# Ensure logs directory is writable
mkdir -p logs/verify-host
chmod 755 logs/verify-host
```

### Script shows permission denied

**Make executable:**
```bash
chmod +x scripts/host-checks/*.sh
```

---

## Benefits

### ✅ Modularity
- Each check is independent
- Easy to add/remove/modify
- Clear separation of concerns

### ✅ Individual Logging
- Each check has complete log
- Grouped by verification run
- Easy to find specific results

### ✅ Testability
- Test individual checks
- Debug in isolation
- Rerun only failed checks

### ✅ Flexibility
- Comment out checks in orchestrator
- Add custom checks
- Reorder easily

### ✅ Maintainability
- One check per file
- Clear naming convention
- Numbered execution order

---

## See Also

- [Main README](../../README.md) - Project overview
- [verify-host.sh](../verify-host.sh) - Orchestrator script
- [Logs README](../../logs/verify-host/README.md) - Log documentation
