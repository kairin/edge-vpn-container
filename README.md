# Edge VPN Container

Containerized Microsoft Edge browser with NVIDIA GPU acceleration. Built on modular architecture for easy maintenance and testing.

## Current Status

✅ **Working:**
- Microsoft Edge in Docker container
- NVIDIA GPU hardware acceleration
- Modular build system (docker-setup/)
- Modular verification system (host-checks/)
- Comprehensive logging for all operations
- Three-step workflow (verify → build → run)

🚧 **Future:**
- F5 VPN client integration (deferred)

---

## Quick Start

```bash
# 1. Verify system ready
./scripts/verify-host.sh

# 2. Build image (first time only)
./scripts/build.sh

# 3. Run container
./scripts/run.sh

# Inside container:
microsoft-edge --no-sandbox
```

---

## Goals & Decisions

### Primary Goal
Run Microsoft Edge browser in isolated Docker container with full GPU acceleration.

### Architecture Decisions

**Modular Design**
- Separated Docker build into independent scripts (`scripts/docker-setup/`)
- Separated host verification into independent checks (`scripts/host-checks/`)
- Each component testable independently
- Easy to add/remove/modify components

**Comprehensive Logging**
- All operations automatically logged to timestamped markdown files
- Logs grouped by type: verification, builds, sessions
- Clean format (ANSI codes stripped)
- Individual logs + summary for each run

**Three-Step Workflow**
- **Verify** host prerequisites before building
- **Build** image once with modular installation scripts
- **Run** container multiple times with session logging

**NVIDIA CUDA Base**
- Switched from plain Ubuntu to NVIDIA CUDA Deep Learning base
- Provides GPU acceleration out of the box
- Includes cuDNN, NCCL, TensorRT

---

## System Requirements

**Host:**
- Linux with X11 display server
- Docker 20.10+ with NVIDIA Container Toolkit
- NVIDIA GPU (CUDA-capable)
- NVIDIA Driver 535+

**Tested:**
- Ubuntu 25.10, Docker 28.5.1, Driver 580.95.05
- NVIDIA GeForce RTX 4080 SUPER

---

## Three-Step Workflow

### 1. Verify Host (`./scripts/verify-host.sh`)

Checks system prerequisites:
- DISPLAY variable, X11 sockets, xhost
- Docker installation and permissions
- NVIDIA GPU detection and capabilities
- NVIDIA Docker runtime

**Logs:** `logs/verify-host/<timestamp>/`
- Individual check logs (01-check-display.md, etc.)
- summary.md with links to all checks

**Run:** Before first build, after driver updates, when troubleshooting

---

### 2. Build Image (`./scripts/build.sh`)

Builds Docker image using modular scripts:
- `install-base.sh` - System dependencies (curl, gnupg, ca-certificates)
- `install-gpu-libs.sh` - GPU libraries (libgl1, libegl1)
- `install-edge.sh` - Microsoft Edge stable

**Logs:** `logs/docker-builds/build-<timestamp>.md`

**Run:** First time, after Dockerfile changes, to update packages

**Time:** ~5-10 minutes

---

### 3. Run Container (`./scripts/run.sh`)

Launches container with:
- NVIDIA runtime for GPU access
- X11 forwarding for display
- Home directory mounted (read-write)
- CUDA optimizations (SHMEM, memory locking)

**Logs:** `logs/container-sessions/session-<timestamp>.md`

**Run:** Every time you want to use the browser

---

## Project Structure

```
edge-vpn-container/
├── README.md                        # This file
├── Dockerfile                       # Modular build using scripts/docker-setup/
├── scripts/
│   ├── verify-host.sh              # Orchestrates all host checks
│   ├── build.sh                     # Builds Docker image with logging
│   ├── run.sh                       # Launches container with logging
│   ├── host-checks/                 # Modular verification scripts
│   │   ├── check-display.sh
│   │   ├── check-x11.sh
│   │   ├── check-xhost.sh
│   │   ├── check-docker.sh
│   │   ├── check-nvidia-gpu.sh
│   │   ├── check-nvidia-runtime.sh
│   │   ├── enable-persistence-mode.sh
│   │   └── README.md
│   └── docker-setup/                # Modular installation scripts
│       ├── install-base.sh
│       ├── install-gpu-libs.sh
│       ├── install-edge.sh
│       └── README.md
├── logs/                            # Auto-generated (gitignored)
│   ├── verify-host/<timestamp>/    # Verification runs
│   ├── docker-builds/build-*.md    # Build outputs
│   ├── container-sessions/session-*.md  # Session recordings
│   └── README.md                    # Logs documentation
└── docs/                            # Session notes and backups
```

---

## Technical Details

**Base Image:** `nvcr.io/nvidia/cuda-dl-base:25.10-cuda13.0-runtime-ubuntu24.04`
- Ubuntu 24.04.3 LTS
- CUDA 13.0.88, cuDNN 9.14, NCCL 2.27, TensorRT 10.13

**Installed:** Microsoft Edge Stable, OpenGL/EGL libraries

**Container Config:**
- Runtime: NVIDIA (`--runtime=nvidia`)
- User: Non-root (matches host UID:GID)
- Network: Host mode
- IPC: Host namespace (for CUDA SHMEM)
- Display: X11 forwarding

**GPU Access:** NVENC, NVDEC, CUDA compute, OpenGL/EGL rendering

---

## Modular Architecture Benefits

### Docker Build Modules (`scripts/docker-setup/`)
✅ Test individual installation scripts independently
✅ Add/remove components by commenting one line
✅ Easy to swap browsers (Chrome, Firefox)
✅ Clear separation of concerns

### Host Verification Modules (`scripts/host-checks/`)
✅ Run specific checks for debugging
✅ Add custom checks without touching existing
✅ Each check logs to individual file
✅ Orchestrator continues even if one check fails

### Comprehensive Logging
✅ Complete audit trail of all operations
✅ Debug issues after they occur
✅ Timestamped directory per verification run
✅ Individual logs + summary for easy navigation

---

## Common Commands

### View Recent Logs
```bash
# Latest verification
cat $(ls -t logs/verify-host/*/summary.md | head -1)

# Latest build
cat $(ls -t logs/docker-builds/*.md | head -1)

# Latest session
cat $(ls -t logs/container-sessions/*.md | head -1)
```

### Test Individual Components
```bash
# Test specific host check
./scripts/host-checks/check-nvidia-gpu.sh

# Test Docker installation script
docker run --rm -v "$PWD/scripts/docker-setup:/scripts" \
    ubuntu:24.04 bash /scripts/install-base.sh
```

### Enable Persistence Mode
```bash
# Recommended for faster container startup
./scripts/host-checks/enable-persistence-mode.sh
```

---

## Troubleshooting

### Display Issues
```bash
# Enable X11 access for Docker
xhost +local:docker

# Verify
./scripts/verify-host.sh
```

### GPU Issues
```bash
# Check NVIDIA runtime
docker info | grep -i nvidia

# Test GPU in container
docker run --runtime=nvidia --rm \
    nvcr.io/nvidia/cuda-dl-base:25.10-cuda13.0-runtime-ubuntu24.04 \
    nvidia-smi
```

### Build Issues
```bash
# Check internet connectivity
curl -I https://packages.microsoft.com

# Rebuild (Docker caches successful layers)
./scripts/build.sh
```

See individual component READMEs for detailed troubleshooting:
- [scripts/host-checks/README.md](scripts/host-checks/README.md)
- [scripts/docker-setup/README.md](scripts/docker-setup/README.md)
- [logs/README.md](logs/README.md)

---

## Documentation

- **[.github/BRANCH_NAMING.md](.github/BRANCH_NAMING.md)** - Branch naming convention
- **[scripts/host-checks/README.md](scripts/host-checks/README.md)** - Host verification modules
- **[scripts/docker-setup/README.md](scripts/docker-setup/README.md)** - Docker build modules
- **[logs/README.md](logs/README.md)** - Logging system documentation

---

## License

This project is provided as-is for personal use.

---

## Acknowledgments

- **NVIDIA** - CUDA Deep Learning base images
- **Microsoft** - Edge browser
- **Docker** - Containerization platform
