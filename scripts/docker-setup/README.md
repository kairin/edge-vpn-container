# Docker Setup Scripts

Modular installation scripts used by Dockerfile to build the container image.

## Purpose

Break down Docker image build into independent, test able components. Each script handles one installation step.

## Scripts

| Script | Installs | Purpose |
|--------|----------|---------|
| `install-base.sh` | curl, gnupg, ca-certificates, apt-transport-https | Package management tools |
| `install-gpu-libs.sh` | libgl1, libegl1 | OpenGL/EGL for GPU rendering |
| `install-edge.sh` | microsoft-edge-stable | Microsoft Edge browser |

## How It Works

**Dockerfile uses them:**
```dockerfile
COPY scripts/docker-setup/ /tmp/docker-setup/

RUN chmod +x /tmp/docker-setup/*.sh && \
    /tmp/docker-setup/install-base.sh && \
    /tmp/docker-setup/install-gpu-libs.sh && \
    /tmp/docker-setup/install-edge.sh && \
    rm -rf /tmp/docker-setup
```

Each script:
1. Installs packages
2. Cleans up apt cache
3. Verifies installation
4. Reports success/failure

## Testing Individual Scripts

```bash
# Test script syntax
bash -n scripts/docker-setup/install-edge.sh

# Test in temporary container
docker run --rm -v "$PWD/scripts/docker-setup:/scripts" \
    ubuntu:24.04 bash /scripts/install-base.sh
```

## Adding Components

**1. Create new script:**
```bash
#!/bin/bash
set -euo pipefail

echo "Installing something..."

apt-get update
apt-get install -y --no-install-recommends your-package
rm -rf /var/lib/apt/lists/*

echo "✓ Installation successful"
```

**2. Make executable:**
```bash
chmod +x scripts/docker-setup/install-something.sh
```

**3. Add to Dockerfile:**
```dockerfile
RUN chmod +x /tmp/docker-setup/*.sh && \
    /tmp/docker-setup/install-base.sh && \
    /tmp/docker-setup/install-gpu-libs.sh && \
    /tmp/docker-setup/install-edge.sh && \
    /tmp/docker-setup/install-something.sh && \    # Add this line
    rm -rf /tmp/docker-setup
```

**4. Rebuild:**
```bash
./scripts/build.sh
```

## Removing Components

Comment out the line in Dockerfile:

```dockerfile
RUN chmod +x /tmp/docker-setup/*.sh && \
    /tmp/docker-setup/install-base.sh && \
    /tmp/docker-setup/install-gpu-libs.sh && \
    # /tmp/docker-setup/install-edge.sh && \    # Disabled
    rm -rf /tmp/docker-setup
```

## Script Guidelines

Every script should:

```bash
#!/bin/bash
set -euo pipefail  # Exit on error, undefined vars, pipe failures

echo "Installing something..."  # Print what it's doing

# Installation commands here

rm -rf /var/lib/apt/lists/*  # Clean up

echo "✓ Installation successful"  # Report success
```

## Benefits

**Testable:** Test individual scripts before Docker build
**Maintainable:** Clear separation of concerns
**Extensible:** Easy to add new components
**Flexible:** Comment out what you don't need
**Debuggable:** See which specific script failed

## Examples

### Switch from Edge to Chrome

Create `install-chrome.sh`:
```bash
#!/bin/bash
set -euo pipefail

echo "Installing Google Chrome..."

curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | \
    gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] \
    http://dl.google.com/linux/chrome/deb/ stable main" > \
    /etc/apt/sources.list.d/google-chrome.list

apt-get update
apt-get install -y --no-install-recommends google-chrome-stable
rm -rf /var/lib/apt/lists/*

echo "✓ Google Chrome installed"
```

Update Dockerfile to use `install-chrome.sh` instead of `install-edge.sh`.

### Add Video Codecs

Create `install-codecs.sh`:
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

echo "✓ Video codecs installed"
```

Add to Dockerfile after GPU libs.
