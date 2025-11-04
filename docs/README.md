# Documentation Archive

This folder contains historical documentation and backups from the Edge VPN Container development process.

## Files Index

### Original Backups (2025-11-04)
- **00-dockerfile-original-ubuntu-base.backup** - Original Dockerfile using plain Ubuntu 24.04 base
- **00-run.sh-original.backup** - Original run script with manual GPU mounting
- **00-start.sh-original.backup** - Original Edge startup script

### Session Documentation (2025-11-04)
1. **01-initial-security-audit-2025-11-04.md**
   - Initial security review identifying critical vulnerabilities
   - Found issues: seccomp disabled, SYS_ADMIN capability, hardcoded paths
   - Recommended security hardening measures

2. **02-security-hardening-improvements-2025-11-04.md**
   - Detailed improvements applied to follow Docker best practices
   - Security enhancements: removed dangerous flags, added resource limits
   - Portability improvements: dynamic paths, Wayland/X11 detection

3. **03-downloads-volume-mounting-guide.md**
   - Complete guide on how downloads persist using volume mounts
   - Troubleshooting common issues with download persistence
   - Best practices for volume mounting

4. **04-session-summary-2025-11-04.md**
   - Complete session summary of all changes made
   - Testing verification steps
   - Rollback instructions

## Current Implementation (2025-11-04)

The project was migrated from:
- **Base**: Ubuntu 24.04 → NVIDIA CUDA Deep Learning base (cuda13.0-runtime-ubuntu24.04)
- **GPU**: Manual device mounting → NVIDIA Container Toolkit with `--runtime=nvidia`
- **Image**: `edge-vpn` → `edge-nvidia` → `kairin/bases:edge-cuda13.0-ubuntu24.04`

### What's in Production Now
- **Dockerfile**: Uses NVIDIA CUDA base image with Microsoft Edge only
- **run.sh**: Minimal script that auto-builds and runs with NVIDIA runtime
- **README.md**: Main documentation (in parent directory)

## Migration History

### Phase 1: Initial Setup (Early 2025-11-04)
- Created Ubuntu 24.04 container with Edge + F5 VPN
- Used manual GPU mounting with library paths
- Hardcoded paths for specific user

### Phase 2: Security Hardening (Mid 2025-11-04)
- Identified security vulnerabilities
- Applied Docker best practices
- Made scripts user-agnostic and portable

### Phase 3: NVIDIA Base Migration (Late 2025-11-04)
- Switched to NVIDIA CUDA Deep Learning base image
- Installed NVIDIA Container Toolkit on host
- Simplified container to Edge only (no F5 VPN yet)
- Published to Docker Hub as `kairin/bases:edge-cuda13.0-ubuntu24.04`

## Notes

These documents reflect the development process and are kept for:
1. Historical reference
2. Understanding design decisions
3. Troubleshooting similar issues
4. Rolling back if needed

For current usage instructions, see the main **README.md** in the parent directory.
