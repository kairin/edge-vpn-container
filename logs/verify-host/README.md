# Host Verification Logs

This directory contains logs from the host verification script (`verify-host.sh`).

## Purpose

Verify that your host system is properly configured before running the container:
- X11 display server accessibility
- Docker installation and permissions
- NVIDIA GPU detection and capabilities
- NVIDIA Docker runtime availability

## Log Files

**Format:** Markdown (`.md`)
**Naming:** `verify-host-YYYY-MM-DD_HH-MM-SS.md`
**Example:** `verify-host-2025-11-05_15-54-47.md`

## What's Logged

Each log contains:
- ✅ DISPLAY variable status
- ✅ X11 socket accessibility
- ✅ xhost access control configuration
- ✅ Docker availability and permissions
- ✅ Full `nvidia-smi` output
- ✅ GPU information summary (model, driver, CUDA version, temperature, memory)
- ✅ NVIDIA capabilities (NVENC, NVDEC, compute, display, persistence mode)
- ✅ NVIDIA Docker runtime status

## Usage

```bash
# Run verification (generates new log)
./scripts/verify-host.sh

# View most recent log
cat $(ls -t logs/verify-host/*.md | head -1)

# View in markdown viewer
glow $(ls -t logs/verify-host/*.md | head -1)

# Search all verification logs for errors
grep -i "error\|warning" logs/verify-host/*.md
```

## Log Structure

```markdown
# Host Display Configuration Verification

**Generated:** [timestamp]
**Log File:** `logs/verify-host/verify-host-YYYY-MM-DD_HH-MM-SS.md`

---

## Verification Results

1. Checking DISPLAY variable...
✓ DISPLAY is set: :0

2. Checking X11 socket files...
✓ Found 2 X11 socket(s)

3. Checking xhost access control...
✓ Access control is enabled

4. Checking Docker...
✓ Docker is installed

5. Checking NVIDIA GPU...
✓ nvidia-smi is available
[Full nvidia-smi output]
[GPU Information Summary]
[NVIDIA Capabilities]

6. Checking NVIDIA Docker runtime...
✓ NVIDIA runtime is available

---

**Verification completed at:** [timestamp]
```

## When to Run

Run verification:
- **Before first container launch** - Ensure system is ready
- **After driver updates** - Confirm NVIDIA drivers still work
- **When troubleshooting** - Document system state
- **After system configuration changes** - Verify nothing broke

## Cleanup

```bash
# Delete logs older than 30 days
find logs/verify-host -name "*.md" -mtime +30 -delete

# Keep only the 20 most recent logs
ls -t logs/verify-host/*.md | tail -n +21 | xargs rm -f
```

## Benefits

- 📊 **System health snapshots** at different points in time
- 🐛 **Troubleshooting** with complete system information
- 📈 **Track changes** in GPU utilization, temperature, driver versions
- 📝 **Documentation** for support requests or team sharing
