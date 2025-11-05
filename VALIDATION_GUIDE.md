# Validation Testing Guide

This guide provides step-by-step instructions for validating the GPU acceleration implementation.

---

## Prerequisites

Before starting validation:
- Ensure you're on Ubuntu 25.10 (or similar) with NVIDIA GPU
- NVIDIA drivers installed and working: `nvidia-smi` should show your GPU
- Docker installed with NVIDIA Container Toolkit
- You're in the repository root directory: `cd /home/kkk/Apps/edge-vpn-container`

---

## Validation Workflow

### Phase 1: Pre-Launch Verification (5 minutes)

**Test TASK-033: Quick verification script**

```bash
./scripts/quick-verify.sh
```

**Expected Output**:
```
======================================================================
           Edge VPN Container - Quick Verification
======================================================================

✓ Docker image exists: Found
✓ NVIDIA GPU detected: NVIDIA GeForce RTX 4080 SUPER
✓ NVIDIA libraries present: [X] libraries found
✓ GPU memory available: 16.0GB total (will use 8.0GB for shared memory)
✓ Display server available: X11 (:0) or Wayland (wayland-0)
✓ Video group access: User in video group
✓ Config directory exists: Ready
✓ Downloads directory exists: Ready

======================================================================
                    Verification Complete
======================================================================

Container is ready to launch!
```

**Validation Criteria**:
- [ ] All checks show ✓ (green checkmark)
- [ ] GPU is detected with correct name
- [ ] Shared memory calculation is correct (8GB for 16GB GPU)
- [ ] Display server is available
- [ ] No ✗ (red X) or errors

**If Fails**:
- Check missing prerequisites
- Verify `nvidia-smi` works on host
- Ensure display variable is set: `echo $DISPLAY`

---

### Phase 2: Container Launch (5 minutes)

**Test TASK-022: Container launches successfully**

```bash
# Terminal 1: Launch container
./run.sh
```

**Expected Output**:
```
======================================================================
        Edge NVIDIA Container Launcher
======================================================================

Checking prerequisites...
✓ Docker is installed
✓ NVIDIA GPU detected: NVIDIA GeForce RTX 4080 SUPER
✓ Display server available: x11 (:0)

Calculating resources...
✓ GPU Memory: 16384 MB
✓ Shared Memory: 8192 MB (50% of GPU)
✓ Container RAM: 10240 MB (shm + 2GB overhead)

Building image if needed...
[may see build output if first time]

Launching container...
✓ Container started: edge-nvidia

You are now inside the container.
To start Edge browser with GPU acceleration:
  launch-edge.sh

To monitor GPU:
  check-gpu.sh --watch
```

**Validation Criteria**:
- [ ] Container launches without errors
- [ ] All ✓ checks pass
- [ ] Memory calculations are correct
- [ ] You see a bash prompt inside container
- [ ] No exit codes 1-5

**If Fails**:
- Check exit code and error message
- Verify Docker is running: `docker ps`
- Check if container name conflicts: `docker ps -a | grep edge-nvidia`

---

### Phase 3: Security Validation (2 minutes)

**Test TASK-027: Security configuration is correct**

Open a **new terminal** (keep container running in Terminal 1):

```bash
# Terminal 2: Validate security
./scripts/validate-security.sh edge-nvidia
```

**Expected Output**:
```
===================================================================
           Security Validation: edge-nvidia
===================================================================
Checking privileged mode... ✓ PASS (Privileged: false)
Checking capabilities... ✓ PASS (No capabilities added)
Checking IPC isolation... ✓ PASS (IPC: private - isolated)
Checking seccomp profile... ✓ PASS (Seccomp: default profile enabled)
Checking no-new-privileges... ✓ PASS (no-new-privileges: true)
Checking memory limits... ✓ PASS (Memory limit: 10240MB)
Checking CPU limits... ✓ PASS (CPU limit: 4.0 cores)
===================================================================
                    Summary
===================================================================
✓ All security checks passed
Container is properly hardened.
```

**Validation Criteria**:
- [ ] All 7 checks show ✓ PASS
- [ ] Exit code is 0
- [ ] Memory limit matches calculated value (10240MB for 16GB GPU)
- [ ] CPU limit is 4.0 cores
- [ ] No ⚠ WARNING or ✗ FAIL messages

**If Fails**:
- Review error messages
- Check run.sh has correct security flags
- Verify container was launched with current run.sh

---

### Phase 4: GPU Acceleration (10 minutes)

**Test TASK-058: Browser launches with GPU acceleration**

Back in **Terminal 1** (inside container):

```bash
# Inside container
launch-edge.sh
```

**Expected Output**:
```
======================================================================
          Microsoft Edge GPU Launcher
======================================================================

Pre-launch checks...
✓ Microsoft Edge is installed
✓ Display server available: :0
✓ GPU accessible (nvidia-smi available)

Launching Microsoft Edge with GPU acceleration...
✓ Edge started successfully

Flags applied:
  --enable-features=VaapiVideoDecoder
  --use-gl=egl
  --ignore-gpu-blocklist
  --disable-gpu-driver-bug-workarounds

Verify GPU acceleration:
  Navigate to edge://gpu in the browser
```

**Validation Criteria**:
- [ ] Browser window opens
- [ ] No "Cannot open display" errors
- [ ] Script exits cleanly with ✓ messages

**In the Browser** (Test TASK-059):

1. Navigate to: `edge://gpu`

2. **Look for these indicators**:
   - **Graphics Feature Status** section should show:
     - Canvas: Hardware accelerated
     - Compositing: Hardware accelerated
     - Multiple Raster Threads: Enabled
     - Out-of-process Rasterization: Hardware accelerated
     - OpenGL: Enabled
     - Rasterization: Hardware accelerated on all tiles
     - Video Decode: Hardware accelerated

   - **Driver Information** section should show:
     - GPU0: NVIDIA GeForce RTX 4080 SUPER
     - Driver vendor: NVIDIA
     - Driver version: 580.95.05

**Validation Criteria**:
- [ ] edge://gpu page loads successfully
- [ ] GPU is listed in "Driver Information" section
- [ ] Most items show "Hardware accelerated"
- [ ] No red error messages or "Software only" warnings

**If Fails**:
- Check nvidia-smi works inside container
- Verify GPU flags are being applied
- Try manual launch with flags to debug

---

### Phase 5: GPU Monitoring (5 minutes)

**Test TASK-052: GPU monitoring works**

Open **Terminal 3** (new terminal on host):

```bash
# Terminal 3: Enter the running container
docker exec -it edge-nvidia bash

# Inside container
check-gpu.sh
```

**Expected Output**:
```
======================================================================
                  GPU Status
======================================================================
GPU: NVIDIA GeForce RTX 4080 SUPER
Driver: 580.95.05
----------------------------------------------------------------------
GPU Utilization: 15 %
GPU Memory: 450 MiB, 16376 MiB
GPU Temperature: 52°C
Active GPU Processes: 2

GPU Processes:
  PID 123      microsoft-edge-bin             250 MiB
  PID 456      microsoft-edge-bin             200 MiB
======================================================================
```

**Validation Criteria**:
- [ ] GPU status displays correctly
- [ ] Utilization is 5-30% (with browser active)
- [ ] GPU memory shows usage (200-500MB typical)
- [ ] Temperature is reasonable (40-70°C)
- [ ] Browser processes are listed

**Test Watch Mode**:

```bash
# Inside container (Terminal 3)
check-gpu.sh --watch
```

**Expected Behavior**:
- Screen refreshes every 2 seconds
- GPU stats update in real-time
- Press Ctrl+C to stop
- No errors or crashes

**Validation Criteria**:
- [ ] Watch mode updates continuously
- [ ] Stats reflect browser activity
- [ ] Can exit cleanly with Ctrl+C

---

### Phase 6: Performance Diagnostics (5 minutes)

**Test TASK-046-048: Performance diagnostics**

In **Terminal 2** (on host, with container running):

```bash
# Test text output
./scripts/diagnose-performance.sh edge-nvidia text
```

**Expected Output**:
```
======================================================================
           Performance Diagnostics Report
======================================================================
Generated: 2025-11-05 [timestamp]
Container: edge-nvidia

[GPU STATUS]
✓ OK GPU Detected: NVIDIA GeForce RTX 4080 SUPER
✓ OK Driver Version: 580.95.05
✓ OK CUDA Version: 13.0
✓ OK GPU Utilization: 15% (Active GPU usage detected)
✓ OK GPU Memory: 450MB / 16384MB (Normal usage)
✓ OK GPU Temperature: 52°C
✓ OK GPU Processes: 2 active

[BROWSER STATUS]
✓ OK Edge Process: 5 process(es) running
✓ OK CPU Usage: 12.5%
✓ OK Memory Usage: 8.2%

[DISPLAY PROTOCOL]
✓ OK Using x11: :0

[SHARED MEMORY]
✓ OK Allocated: 8192MB
✓ OK Used: 245MB / 8192MB (3%) - Sufficient available

[SYSTEM RESOURCES]
✓ OK Container Memory: 1.5GB / 10240MB
✓ OK Container CPU: 15.2%

======================================================================
                    Recommendations
======================================================================
  - System is performing optimally
```

**Validation Criteria**:
- [ ] All sections display data
- [ ] GPU utilization > 0% (browser is using GPU)
- [ ] Most checks are ✓ OK (green)
- [ ] Recommendations make sense
- [ ] No ✗ CRITICAL errors

**Test JSON Output**:

```bash
./scripts/diagnose-performance.sh edge-nvidia json
```

**Expected Output**: Valid JSON with all metrics

**Validation Criteria**:
- [ ] Output is valid JSON
- [ ] Can be parsed: `./scripts/diagnose-performance.sh edge-nvidia json | jq .`
- [ ] Contains all key sections (gpu, browser, recommendations)

---

### Phase 7: Persistence Testing (10 minutes)

**Test TASK-060-061: Downloads and config persist**

**In Terminal 1** (inside container, in browser):

1. **Test Downloads**:
   - In Edge browser, download a file (any file)
   - Note the file name
   - Close the browser
   - Exit the container: `exit`

2. **Verify Download Persisted**:
   ```bash
   # On host (Terminal 1)
   ls -lh ~/Downloads/
   # Should see your downloaded file
   ```

3. **Test Config Persistence**:
   - Re-launch container: `./run.sh`
   - Inside container: `launch-edge.sh`
   - In browser, set a preference (e.g., set homepage, add bookmark)
   - Close browser and exit container
   - Re-launch container and browser
   - Verify preference is still set

**Validation Criteria**:
- [ ] Downloaded files appear in `~/Downloads` on host
- [ ] Files persist after container exit
- [ ] Browser preferences persist across container restarts
- [ ] No permission errors when creating files

---

### Phase 8: Real-World Performance (15 minutes)

**Test TASK-062-064: Real-world usage**

Launch container and browser, then:

**Test 1: Video Playback**
1. Navigate to YouTube
2. Play a 4K video
3. In Terminal 2, run: `./scripts/diagnose-performance.sh edge-nvidia text`

**Validation Criteria**:
- [ ] Video plays smoothly without stuttering
- [ ] GPU utilization increases (20-40%)
- [ ] No frame drops or buffering (beyond network)
- [ ] No "Aw, Snap!" crashes

**Test 2: Heavy Browsing**
1. Open 10-15 tabs with various websites
2. Switch between tabs rapidly
3. Scroll through pages

**Validation Criteria**:
- [ ] Tabs load quickly
- [ ] Smooth scrolling
- [ ] No tab crashes
- [ ] Shared memory usage stays below 80%

**Test 3: GPU-Intensive Site**
1. Navigate to: https://webglsamples.org/aquarium/aquarium.html
2. Increase fish count to 1000+
3. Monitor GPU: In Terminal 3 (inside container): `check-gpu.sh --watch`

**Validation Criteria**:
- [ ] WebGL content renders correctly
- [ ] GPU utilization increases significantly (40-80%)
- [ ] Frame rate remains smooth
- [ ] GPU processes show Edge using GPU

---

### Phase 9: Error Handling (5 minutes)

**Test TASK-034: Error handling**

**Test 1: No GPU Available**
```bash
# Temporarily rename nvidia device (requires sudo)
sudo mv /dev/nvidia0 /dev/nvidia0.bak 2>/dev/null || echo "Test device not found"

# Try to launch
./run.sh

# Expected: Should fail with clear error
# Exit code: 2
# Message: "✗ No NVIDIA GPU detected"

# Restore device
sudo mv /dev/nvidia0.bak /dev/nvidia0 2>/dev/null || echo "Restore not needed"
```

**Test 2: Display Server Not Available**
```bash
# Clear display variable
DISPLAY_BACKUP=$DISPLAY
unset DISPLAY
unset WAYLAND_DISPLAY

# Try to launch
./run.sh

# Expected: Should fail with clear error
# Exit code: 3
# Message: "✗ Display server not available"

# Restore
export DISPLAY=$DISPLAY_BACKUP
```

**Validation Criteria**:
- [ ] Appropriate error messages displayed
- [ ] Correct exit codes (1-5)
- [ ] Clear instructions for fixing issues
- [ ] No cryptic Docker errors

---

## Validation Checklist

After completing all phases, verify:

### Core Functionality
- [ ] Container launches successfully
- [ ] GPU acceleration is working (edge://gpu confirms)
- [ ] Browser is performant and responsive
- [ ] No crashes or "Aw, Snap!" errors

### Diagnostics
- [ ] quick-verify.sh detects all prerequisites
- [ ] diagnose-performance.sh provides accurate metrics
- [ ] validate-security.sh confirms all security checks
- [ ] check-gpu.sh monitors GPU in real-time

### Persistence
- [ ] Downloads saved to ~/Downloads
- [ ] Files persist after container restart
- [ ] Browser config persists
- [ ] No permission errors

### Performance
- [ ] GPU utilization 5-40% during normal browsing
- [ ] 20-80% during GPU-intensive tasks
- [ ] Video playback is smooth
- [ ] Multiple tabs work without issues

### Security
- [ ] All security checks pass
- [ ] No privileged mode
- [ ] Resource limits enforced
- [ ] No dangerous capabilities

### Error Handling
- [ ] Clear error messages for missing prerequisites
- [ ] Appropriate exit codes
- [ ] Helpful troubleshooting guidance

---

## Troubleshooting Validation Issues

### GPU Not Detected in Browser

**Symptoms**: edge://gpu shows "Software only"

**Debug Steps**:
```bash
# Inside container
nvidia-smi  # Should show GPU
glxinfo | grep "OpenGL renderer"  # Should show NVIDIA

# Check if flags are applied
ps aux | grep microsoft-edge | grep VaapiVideoDecoder
```

### Performance Is Slow

**Debug Steps**:
```bash
# Check GPU utilization
./scripts/diagnose-performance.sh edge-nvidia text

# Look for:
# - GPU utilization at 0% (GPU not being used)
# - Shared memory >80% (insufficient memory)
# - High CPU usage (software rendering)
```

### Container Won't Start

**Debug Steps**:
```bash
# Check Docker
docker ps
docker logs edge-nvidia

# Check GPU
nvidia-smi
nvidia-container-cli info

# Check image
docker images | grep edge-nvidia
```

---

## Reporting Results

After validation, document your results:

1. **All Tests Pass**: Implementation is validated ✅
   - Update tasks.md to mark TASK-058-064 as complete
   - Note any minor issues or observations

2. **Some Tests Fail**:
   - Document which tests failed
   - Include error messages and logs
   - Note system configuration differences
   - Create issues for investigation

3. **Performance Issues**:
   - Include output from diagnose-performance.sh
   - Note GPU utilization patterns
   - Compare with expected values

---

## Clean Up

After validation:

```bash
# Stop container (if running)
docker stop edge-nvidia

# Remove container (optional - will auto-remove with --rm)
docker rm edge-nvidia

# Keep image for future use, or remove:
docker rmi edge-nvidia
```

---

## Next Steps

After successful validation:
1. Mark validation tasks (TASK-058-064) as complete
2. Run code quality checks (TASK-065-068)
3. Update documentation with any findings
4. Consider the feature complete and ready for use

---

## Validation Time Estimate

- Phase 1: Pre-Launch - 5 minutes
- Phase 2: Container Launch - 5 minutes
- Phase 3: Security - 2 minutes
- Phase 4: GPU Acceleration - 10 minutes
- Phase 5: GPU Monitoring - 5 minutes
- Phase 6: Diagnostics - 5 minutes
- Phase 7: Persistence - 10 minutes
- Phase 8: Real-World - 15 minutes
- Phase 9: Error Handling - 5 minutes

**Total**: ~60 minutes for complete validation
