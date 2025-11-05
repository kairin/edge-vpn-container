# Edge VPN Container

Containerized Microsoft Edge browser with NVIDIA GPU acceleration, built on CUDA Deep Learning base image (Ubuntu 24.04).

## Quick Start

```bash
# Step 1: Verify host system prerequisites
./scripts/verify-host.sh

# Step 2: Build the Docker image
./scripts/build.sh

# Step 3: Run the container
./scripts/run.sh
```

## System Requirements

### Host System
- **OS**: Linux with X11 or Wayland display server
- **Docker**: Version 20.10+ with NVIDIA Container Toolkit
- **NVIDIA GPU**: Any CUDA-capable GPU
- **NVIDIA Driver**: Version 535+ (CUDA 13.0 compatible)
- **Display**: X11 socket accessible at `/tmp/.X11-unix`

### Tested Configuration
- OS: Ubuntu 25.10 (Oracular Oriole)
- Docker: 28.5.1
- NVIDIA Driver: 580.95.05
- GPU: NVIDIA GeForce RTX 4080 SUPER (16GB VRAM)
- Display: Wayland with X11 compatibility

## Three-Step Workflow

### 1. Pre-Flight Verification: `scripts/verify-host.sh`

**Purpose:** Verify host system is properly configured before building or running container.

**What it checks:**
- ✅ DISPLAY environment variable
- ✅ X11 socket accessibility (`/tmp/.X11-unix`)
- ✅ xhost access control configuration
- ✅ Docker installation and permissions
- ✅ NVIDIA GPU detection and status
- ✅ NVIDIA capabilities (NVENC, NVDEC, compute, persistence mode)
- ✅ NVIDIA Docker runtime availability

**Logging:**
- Location: `logs/verify-host/verify-host-YYYY-MM-DD_HH-MM-SS.md`
- Format: Markdown with complete verification output
- Contains: All checks, GPU information, system status

**When to run:**
- Before first build
- After driver updates
- When troubleshooting display or GPU issues
- After system configuration changes

```bash
./scripts/verify-host.sh
```

**Expected output:**
```
========================================
Host Display Configuration Verification
========================================
✓ DISPLAY is set: :0
✓ Found 2 X11 socket(s)
✓ Access control is enabled
✓ Docker is installed
✓ nvidia-smi is available
✓ NVIDIA runtime is available
========================================
✓ All checks passed!
Your system is ready to run the container.
Execute: ./scripts/build.sh
========================================
```

---

### 2. Image Build: `scripts/build.sh`

**Purpose:** Build the Docker image with NVIDIA CUDA base and Microsoft Edge.

**What it does:**
- Pulls NVIDIA CUDA Deep Learning base image (~4.5 GB)
- Installs Microsoft Edge stable and dependencies
- Installs OpenGL/EGL libraries for GPU rendering
- Creates `cuda-container` image

**Logging:**
- Location: `logs/docker-builds/build-YYYY-MM-DD_HH-MM-SS.md`
- Format: Markdown with complete build output
- Contains: All Docker layers, downloads, package installations

**Build time:** ~5-10 minutes (depending on network speed)

**When to run:**
- First time setup
- After Dockerfile changes
- To update to latest NVIDIA base image
- To upgrade Microsoft Edge version

```bash
./scripts/build.sh
```

**Expected output:**
```
Building cuda-container image...
Build process will be logged to: logs/docker-builds/build-2025-11-05_16-30-00.md

[Docker build output...]

========================================
Build completed successfully!
Build log saved to: logs/docker-builds/build-2025-11-05_16-30-00.md
========================================

You can now run ./scripts/run.sh to launch the container
```

---

### 3. Container Launch: `scripts/run.sh`

**Purpose:** Launch the containerized Edge browser with GPU acceleration and X11 forwarding.

**What it does:**
- Verifies `cuda-container` image exists
- Runs container with NVIDIA runtime
- Mounts X11 sockets for GUI display
- Mounts home directory for file access
- Configures CUDA optimizations (SHMEM, memory locking)
- Logs complete container session

**Logging:**
- Location: `logs/container-sessions/session-YYYY-MM-DD_HH-MM-SS.md`
- Format: Markdown with complete session output
- Contains: All commands typed, outputs, timestamps

**Container Configuration:**
- Runtime: NVIDIA (`--runtime=nvidia`)
- User: Non-root (matches host UID:GID)
- Network: Host network mode
- IPC: Host IPC namespace (for CUDA SHMEM)
- Display: X11 forwarding via mounted socket
- Volumes: Home directory (read-write)

**When to run:**
- After successful build
- Every time you want to use the browser
- For testing and validation

```bash
./scripts/run.sh
```

**Expected output:**
```
Launching container...
Session will be logged to: logs/container-sessions/session-2025-11-05_16-35-00.md

[Container starts, you get shell prompt]
ubuntu@hostname:~$ microsoft-edge --no-sandbox
[Edge browser launches]
ubuntu@hostname:~$ exit

========================================
Session log saved to: logs/container-sessions/session-2025-11-05_16-35-00.md
========================================
```

---

## Complete Setup Example

```bash
# Clone or download this repository
cd /path/to/edge-vpn-container

# Step 1: Verify your system is ready
./scripts/verify-host.sh
# → logs/verify-host/verify-host-2025-11-05_15-00-00.md

# Step 2: Build the Docker image (one-time setup)
./scripts/build.sh
# → logs/docker-builds/build-2025-11-05_15-05-00.md
# This takes 5-10 minutes

# Step 3: Run the container
./scripts/run.sh
# → logs/container-sessions/session-2025-11-05_15-15-00.md

# Inside the container, launch Edge
ubuntu@hostname:~$ microsoft-edge --no-sandbox

# When done, exit the container
ubuntu@hostname:~$ exit
```

---

## Container Technical Details

### Base Image
- **Image**: `nvcr.io/nvidia/cuda-dl-base:25.10-cuda13.0-runtime-ubuntu24.04`
- **OS**: Ubuntu 24.04.3 LTS (Noble Numbat)
- **CUDA**: 13.0.88
- **cuDNN**: 9.14
- **NCCL**: 2.27
- **TensorRT**: 10.13

### Installed Software
- Microsoft Edge Stable (latest)
- OpenGL libraries (libgl1, libegl1)
- CUDA runtime libraries

### Security Features
- Non-root user (matches host UID/GID)
- Resource limits configured
- Default seccomp profile enabled
- No unnecessary capabilities granted

### GPU Access
- Full NVIDIA GPU passthrough via `--runtime=nvidia`
- Hardware video encoding (NVENC)
- Hardware video decoding (NVDEC)
- CUDA compute capabilities
- OpenGL/EGL rendering

---

## Logging System

All three scripts automatically log their complete output to timestamped markdown files:

```
logs/
├── verify-host/           # Host verification logs
│   └── verify-host-*.md   # System check results
├── docker-builds/         # Image build logs
│   └── build-*.md         # Docker build output
└── container-sessions/    # Container session logs
    └── session-*.md       # Everything that happens inside container
```

### View Logs

```bash
# View most recent verification
cat $(ls -t logs/verify-host/*.md | head -1)

# View most recent build
cat $(ls -t logs/docker-builds/*.md | head -1)

# View most recent session
cat $(ls -t logs/container-sessions/*.md | head -1)
```

### Log Cleanup

```bash
# Delete logs older than 30 days
find logs -name "*.md" -mtime +30 -delete

# Keep only 10 most recent of each type
ls -t logs/verify-host/*.md | tail -n +11 | xargs rm -f
ls -t logs/docker-builds/*.md | tail -n +11 | xargs rm -f
ls -t logs/container-sessions/*.md | tail -n +11 | xargs rm -f
```

See [logs/README.md](logs/README.md) for detailed documentation.

---

## Troubleshooting

### Build Issues

**Problem:** Docker build fails with network errors
```bash
# Check internet connectivity
curl -I https://packages.microsoft.com

# Try build again (Docker caches successful layers)
./scripts/build.sh
```

**Problem:** Permission denied during build
```bash
# Ensure user is in docker group
sudo usermod -aG docker $USER
# Log out and back in for changes to take effect
```

### Display Issues

**Problem:** Container can't access display
```bash
# Check DISPLAY variable
echo $DISPLAY

# Enable X11 access for Docker
xhost +local:docker

# Verify with verification script
./scripts/verify-host.sh
```

**Problem:** "No protocol specified" error
```bash
# This means xhost access control is blocking Docker
xhost +local:docker
```

### GPU Issues

**Problem:** GPU not detected in container
```bash
# Verify NVIDIA runtime is installed
docker info | grep -i nvidia

# Test GPU access
docker run --runtime=nvidia --rm nvcr.io/nvidia/cuda-dl-base:25.10-cuda13.0-runtime-ubuntu24.04 nvidia-smi
```

**Problem:** "nvidia-smi: command not found"
```bash
# Install NVIDIA drivers on host
# Ubuntu: sudo ubuntu-drivers autoinstall

# Install NVIDIA Container Toolkit
# See: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html
```

### Edge Browser Issues

**Problem:** Edge doesn't launch or crashes
```bash
# Inside container, check Edge installation
dpkg -l | grep edge

# Try launching with verbose output
microsoft-edge --no-sandbox --verbose

# Check for missing libraries
ldd $(which microsoft-edge)
```

---

## Advanced Usage

### Custom Dockerfile Modifications

Edit `Dockerfile` to add additional packages:

```dockerfile
# Add before the final CMD line
RUN apt-get update && \
    apt-get install -y your-package && \
    rm -rf /var/lib/apt/lists/*
```

Then rebuild:
```bash
./scripts/build.sh
```

### Volume Mounting for Downloads

The container mounts your entire home directory by default. Downloads from Edge will be saved to your host system's filesystem.

```bash
# Inside container
ubuntu@hostname:~$ cd ~/Downloads
ubuntu@hostname:~/Downloads$ ls
# Files here are accessible from host
```

### Persistence Mode for GPU

Enable NVIDIA persistence mode for faster container startup:

```bash
# Enable persistence mode (survives reboots)
sudo nvidia-smi -pm 1

# Verify
nvidia-smi | grep "Persistence Mode"
```

### Running Multiple Containers

Each `./run.sh` execution creates a new container session. Only one can run at a time because they all use the name `cuda-container`.

To run multiple simultaneously, modify container name in `run.sh`:
```bash
--name cuda-container-1
```

---

## Docker Hub Image

A pre-built image is available on Docker Hub:

```bash
# Pull pre-built image
docker pull kairin/bases:edge-cuda13.0-ubuntu24.04

# Tag for use with run.sh
docker tag kairin/bases:edge-cuda13.0-ubuntu24.04 cuda-container

# Now you can skip ./scripts/build.sh and go directly to:
./scripts/run.sh
```

**Note:** Pre-built image may not be the latest version. Building locally ensures you get the latest Edge and security updates.

---

## Project Structure

```
edge-vpn-container/
├── README.md                    # This file - main documentation
├── CLAUDE.md                    # LLM agent instructions (symlink)
├── Dockerfile                   # Container image definition
├── docs/                        # Historical documentation
│   └── *.md                     # Security audits, migration guides
├── logs/                        # Automatic logging (gitignored)
│   ├── README.md                # Logging documentation
│   ├── verify-host/             # Verification logs
│   ├── docker-builds/           # Build logs
│   └── container-sessions/      # Session logs
└── scripts/                     # Executable workflow scripts
    ├── verify-host.sh           # Pre-flight system verification
    ├── build.sh                 # Image build script
    └── run.sh                   # Container launcher
```

---

## Contributing

This is a personal project for running Microsoft Edge in a containerized environment with GPU acceleration. Feel free to fork and adapt for your needs.

---

## License

This project is provided as-is for educational and personal use.

---

## Acknowledgments

- **NVIDIA** - CUDA Deep Learning base images
- **Microsoft** - Edge browser
- **Docker** - Containerization platform
