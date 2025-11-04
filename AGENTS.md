# Edge VPN Container Project

## Project Overview

This repository contains a containerized Microsoft Edge browser built on NVIDIA CUDA Deep Learning base image (Ubuntu 24.04), designed for GPU-accelerated web browsing with future VPN client integration.

**Key Components:**
- **Dockerfile**: NVIDIA CUDA 13.0 runtime base with Microsoft Edge stable
- **run.sh**: Auto-building container launcher with NVIDIA runtime support
- **README.md**: User-facing documentation and quick start guide

**Published Image:**
- Docker Hub: `kairin/bases:edge-cuda13.0-ubuntu24.04`
- Base: `nvcr.io/nvidia/cuda-dl-base:25.10-cuda13.0-runtime-ubuntu24.04`
- Size: ~4.5 GB (includes CUDA libraries and Edge browser)

## Problems Solved

### 1. GPU Acceleration for Containerized Browser
**Challenge:** Running Microsoft Edge in a Docker container without GPU access resulted in extremely slow performance due to software rendering.

**Solution:** Migrated from plain Ubuntu 24.04 base to NVIDIA CUDA Deep Learning base image, installed NVIDIA Container Toolkit on host (Ubuntu 25.10), and configured proper runtime with `--runtime=nvidia` flag.

**Outcome:** Full GPU acceleration with NVIDIA RTX 4080 SUPER, verified via `nvidia-smi` inside container.

### 2. Security Hardening
**Challenge:** Initial implementation had critical security vulnerabilities:
- Seccomp filtering disabled (`--security-opt seccomp=unconfined`)
- Dangerous `SYS_ADMIN` capability granted
- Host IPC namespace sharing (`--ipc=host`)
- No resource limits (DoS risk)

**Solution:** Applied Docker security best practices:
- Enabled default seccomp profile for syscall filtering
- Removed unnecessary capabilities (principle of least privilege)
- Isolated IPC namespace
- Added resource limits (4GB memory, 4 CPU cores)
- Implemented `no-new-privileges` security option

**Documented in:** `docs/01-initial-security-audit-2025-11-04.md`, `docs/02-security-hardening-improvements-2025-11-04.md`

### 3. Portability Across Systems
**Challenge:** Original scripts contained hardcoded paths (`/home/user`) that failed for other users and systems.

**Solution:** Made all paths dynamic using environment variables:
- `$HOME` instead of hardcoded home directory
- `$(id -u)` and `$(id -g)` for user detection
- Automatic Wayland/X11 display server detection
- Auto-detection of GPU availability

**Outcome:** Container works on any Linux system with NVIDIA GPU and Docker.

### 4. Persistent Downloads Configuration
**Challenge:** Understanding whether downloads from containerized Edge would persist after container exit.

**Solution:** Documented volume mounting strategy:
- Host `~/Downloads` mounted to container `~/Downloads` with read-write access
- Edge config directory mounted for settings persistence
- Same path inside and outside container ensures seamless experience

**Documented in:** `docs/03-downloads-volume-mounting-guide.md`

### 5. Development History Preservation
**Challenge:** Multiple iterations created documentation clutter in root directory.

**Solution:** Organized project structure:
- `docs/` - Historical documentation and backups from security hardening phase
- `scripts/` - Diagnostic and testing utilities (not required for operation)
- Root folder - Only essential active files (Dockerfile, run.sh, README.md)

**Documented in:** `docs/README.md`, `scripts/README.md`

## Development Timeline

### Phase 1: Initial Setup (Early Nov 4, 2025)
- Created Ubuntu 24.04 container with Microsoft Edge + F5 VPN client
- Manual GPU mounting with library paths
- Hardcoded user paths

### Phase 2: Security Hardening (Mid Nov 4, 2025)
- Conducted security audit
- Applied Docker and Ubuntu 24.04 best practices
- Made scripts portable and user-agnostic
- Created comprehensive documentation

### Phase 3: NVIDIA Base Migration (Late Nov 4, 2025)
- Switched to NVIDIA CUDA Deep Learning base image
- Installed NVIDIA Container Toolkit on Ubuntu 25.10 host
- Simplified container to Edge only (F5 VPN deferred)
- Published to Docker Hub: `kairin/bases:edge-cuda13.0-ubuntu24.04`

### Phase 4: Repository Organization (Late Nov 4, 2025)
- Consolidated documentation into `docs/` folder
- Moved utility scripts to `scripts/` folder
- Cleaned root directory to essential files only

## Technical Specifications

**Host System:**
- OS: Ubuntu 25.10 (Oracular Oriole)
- Docker: 28.5.1
- NVIDIA Driver: 580.95.05
- Display: Wayland (wayland-0) with X11 fallback
- GPU: NVIDIA GeForce RTX 4080 SUPER (16GB)

**Container Environment:**
- Base: Ubuntu 24.04.3 LTS (Noble Numbat)
- CUDA: 13.0.88
- Microsoft Edge: 142.0.3595.53
- Deep Learning Libraries: cuDNN 9.14, NCCL 2.27, TensorRT 10.13

**Verified Functionality:**
- ✅ GPU hardware acceleration working
- ✅ NVIDIA runtime integration successful
- ✅ Microsoft Edge installed and executable
- ✅ All dependencies satisfied
- ✅ Ubuntu 24.04 time64 (t64) packages compatible

---

## LLM Agent Instructions

This document outlines the rules for maintaining the structure of this repository.

### Root Folder Structure

The root folder of this repository should only contain the following files:

- `/home/user/Apps/edge-vpn-container/AGENTS.md` (this file)
- `/home/user/Apps/edge-vpn-container/README.md`
- `/home/user/Apps/edge-vpn-container/Dockerfile`
- `/home/user/Apps/edge-vpn-container/run.sh`
- The two symlinks `/home/user/Apps/edge-vpn-container/GEMINI.md` and `/home/user/Apps/edge-vpn-container/CLAUDE.md` that symlink to `/home/user/Apps/edge-vpn-container/AGENTS.md`

All other files and directories should be placed in appropriate subfolders:

- **Documentation and backups** → `docs/`
- **Utility scripts** → `scripts/`
- **Test files** → `tests/` (if needed)
- **Configuration examples** → `examples/` (if needed)

### Repository Maintenance Guidelines

When making changes to this repository:

1. **Keep root clean**: Only essential operational files belong in root
2. **Document changes**: Update relevant files in `docs/` when making significant changes
3. **Preserve history**: Keep dated documentation for context (e.g., `docs/01-initial-security-audit-2025-11-04.md`)
4. **Use descriptive names**: File names should clearly indicate their purpose and date if historical
5. **Organize by function**: Group related files into subfolders with README.md explanations

### Current Subfolder Structure

- **docs/** - Historical documentation, security audits, migration guides, session summaries, and original backups
- **scripts/** - Diagnostic tools (quick-verify.sh), legacy startup scripts (start.sh), and testing utilities

### Docker Image Versioning

When building new versions:
- Tag format: `edge-cuda<version>-ubuntu<version>` (e.g., `edge-cuda13.0-ubuntu24.04`)
- Push to: `kairin/bases:<tagname>`
- Document changes in `docs/` with date-stamped files
- Update README.md with new image tag if it becomes the current version

### Security Best Practices

Maintain security standards established in Phase 2:
- Never reintroduce `--security-opt seccomp=unconfined`
- Avoid `--privileged` or `SYS_ADMIN` capabilities unless absolutely justified
- Keep resource limits (memory, CPU) to prevent DoS
- Use isolated namespaces (no `--ipc=host` unless required)
- Document any security-impacting changes in `docs/`

### Future Enhancements

Planned features that may be added:
- F5 VPN client integration (deferred from Phase 1)
- Auto-launch Edge browser on container start (requires display server configuration)
- Wayland-native rendering optimization
- Custom security profiles (AppArmor/SELinux)
- Multi-architecture support (ARM64)

When adding these features:
- Create feature branch with descriptive name
- Document implementation in `docs/` with dated file
- Update README.md with new capabilities
- Test thoroughly before merging to main
- Tag new Docker image version if applicable
