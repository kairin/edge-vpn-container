# Docker Setup Scripts

Modular installation scripts for building the container image.

## Purpose

These scripts break down the Docker image build process into independent, testable components. Each script handles one specific aspect of the installation.

## Scripts

### 1. `install-base.sh` - Base System Dependencies

**Purpose:** Install essential package management tools

**Installs:**
- `curl` - Download files from URLs
- `gnupg` - GPG key verification
- `ca-certificates` - SSL/TLS certificate authorities
- `apt-transport-https` - HTTPS support for apt

**When to modify:**
- Need additional package management tools
- Adding new repository types

---

### 2. `install-gpu-libs.sh` - GPU Rendering Libraries

**Purpose:** Install OpenGL and EGL libraries for hardware-accelerated graphics

**Installs:**
- `libgl1` - OpenGL library (3D graphics API)
- `libegl1` - EGL library (GPU rendering interface)

**When to modify:**
- Need additional GPU libraries
- Adding Vulkan or other graphics APIs
- Supporting different GPU vendors

---

### 3. `install-edge.sh` - Microsoft Edge Browser

**Purpose:** Install Microsoft Edge stable from official Microsoft repository

**Steps:**
1. Add Microsoft GPG key
2. Add Microsoft Edge apt repository
3. Install `microsoft-edge-stable` package
4. Verify installation succeeded

**When to modify:**
- Want different Edge channel (beta, dev, canary)
- Need to install browser extensions
- Want to switch to different browser (Chrome, Firefox)

---

## Usage

### During Docker Build

The Dockerfile automatically uses these scripts:

```dockerfile
COPY scripts/docker-setup/ /tmp/docker-setup/

RUN chmod +x /tmp/docker-setup/*.sh && \
    /tmp/docker-setup/install-base.sh && \
    /tmp/docker-setup/install-gpu-libs.sh && \
    /tmp/docker-setup/install-edge.sh && \
    rm -rf /tmp/docker-setup
```

### Testing Scripts Independently

Test a script before building the full image:

```bash
# Test script syntax
bash -n scripts/docker-setup/install-edge.sh

# Test in temporary container
docker run --rm -v "$PWD/scripts/docker-setup:/scripts" \
    ubuntu:24.04 \
    bash /scripts/install-base.sh
```

### Disabling Components

Comment out scripts you don't need in the Dockerfile:

```dockerfile
RUN chmod +x /tmp/docker-setup/*.sh && \
    /tmp/docker-setup/install-base.sh && \
    /tmp/docker-setup/install-gpu-libs.sh && \
    # /tmp/docker-setup/install-edge.sh && \    # ← Disabled
    rm -rf /tmp/docker-setup
```

---

## Adding New Components

### Example: Adding VPN Client

**1. Create new script:**
```bash
vim scripts/docker-setup/install-vpn.sh
```

**2. Script template:**
```bash
#!/bin/bash
set -euo pipefail

echo "Installing F5 VPN client..."

# Your installation commands here
wget https://example.com/vpn-client.deb
dpkg -i vpn-client.deb || apt-get install -f -y

# Verify installation
if command -v vpn-client &> /dev/null; then
    echo "✓ VPN client installed successfully"
else
    echo "✗ VPN client installation failed!"
    exit 1
fi
```

**3. Make executable:**
```bash
chmod +x scripts/docker-setup/install-vpn.sh
```

**4. Add to Dockerfile:**
```dockerfile
RUN chmod +x /tmp/docker-setup/*.sh && \
    /tmp/docker-setup/install-base.sh && \
    /tmp/docker-setup/install-gpu-libs.sh && \
    /tmp/docker-setup/install-edge.sh && \
    /tmp/docker-setup/install-vpn.sh && \    # ← New
    rm -rf /tmp/docker-setup
```

**5. Rebuild:**
```bash
./scripts/build.sh
```

---

## Script Guidelines

### Required Elements

Every script should:

✅ **Start with shebang and set options:**
```bash
#!/bin/bash
set -euo pipefail
```

✅ **Print what it's doing:**
```bash
echo "Installing something..."
```

✅ **Clean up after itself:**
```bash
rm -rf /var/lib/apt/lists/*
```

✅ **Verify installation:**
```bash
if command -v something &> /dev/null; then
    echo "✓ Installation successful"
else
    echo "✗ Installation failed!"
    exit 1
fi
```

### Best Practices

- 📝 **Add comments** explaining what each section does
- 🧹 **Clean up** temporary files and apt cache
- ✅ **Verify** installation succeeded before continuing
- 📊 **Print versions** of installed software
- ⚠️ **Exit with error** if installation fails

---

## Troubleshooting

### Script fails during build

**Check which script failed:**
```
Step 5/6 : RUN chmod +x /tmp/docker-setup/*.sh && ...
 ---> Running in abc123
=== Installing Base Dependencies ===
✓ Base dependencies installed successfully
=== Installing GPU Libraries ===
✗ Installation failed!
```

**Test the failing script:**
```bash
# Run in temporary container
docker run --rm -it \
    nvcr.io/nvidia/cuda-dl-base:25.10-cuda13.0-runtime-ubuntu24.04 \
    bash

# Inside container
apt-get update
# Manually run commands from the script
```

### Script works on host but fails in container

- Container may have different base packages installed
- Check script uses absolute paths, not relative
- Verify all dependencies are in `install-base.sh`

### Want to modify script after build

1. Edit the script file
2. Rebuild the image: `./scripts/build.sh`
3. Docker will use updated script

---

## Benefits

### ✅ Modularity
- Each component in separate file
- Easy to add/remove/modify

### ✅ Testability
- Test scripts before Docker build
- Debug independently

### ✅ Maintainability
- Clear what each script does
- Easy to update single component

### ✅ Reusability
- Use scripts outside Docker
- Share across projects

### ✅ Flexibility
- Comment out what you don't need
- Easy to customize

---

## Examples

### Switching from Edge to Chrome

**1. Create `install-chrome.sh`:**
```bash
#!/bin/bash
set -euo pipefail

echo "Installing Google Chrome..."

curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | \
    gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > \
    /etc/apt/sources.list.d/google-chrome.list

apt-get update
apt-get install -y --no-install-recommends google-chrome-stable
rm -rf /var/lib/apt/lists/*

echo "✓ Google Chrome installed successfully"
```

**2. Update Dockerfile:**
```dockerfile
RUN chmod +x /tmp/docker-setup/*.sh && \
    /tmp/docker-setup/install-base.sh && \
    /tmp/docker-setup/install-gpu-libs.sh && \
    # /tmp/docker-setup/install-edge.sh && \    # Disabled
    /tmp/docker-setup/install-chrome.sh && \    # Added
    rm -rf /tmp/docker-setup
```

### Adding Video Codecs

**Create `install-codecs.sh`:**
```bash
#!/bin/bash
set -euo pipefail

echo "Installing video codecs..."

apt-get update
apt-get install -y --no-install-recommends \
    va-driver-all \
    mesa-va-drivers \
    libva2 \
    vainfo
rm -rf /var/lib/apt/lists/*

echo "✓ Video codecs installed successfully"
```

**Add to Dockerfile after GPU libs.**

---

## See Also

- [Main README](../../README.md) - Project overview
- [Build Script](../build.sh) - How images are built
- [Dockerfile](../../Dockerfile) - How scripts are used
