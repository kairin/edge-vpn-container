# Edge VPN Container

Secure, isolated Microsoft Edge browser with F5 VPN client running in Docker.

---

## Quick Start

### 1. Build the Container

```bash
docker build -t edge-vpn .
```

### 2. Run the Container

```bash
./run.sh
```

That's it! Edge will launch with your VPN client available.

---

## Features

- ✅ **Isolated Environment** - Runs Edge in secure container
- ✅ **Wayland & X11 Support** - Auto-detects display server
- ✅ **GPU Acceleration** - Hardware accelerated rendering
- ✅ **Persistent Downloads** - Downloads saved to `~/Downloads`
- ✅ **Persistent Config** - Settings saved in `~/.config/microsoft-edge-docker`
- ✅ **Security Hardened** - Follows Docker best practices
- ✅ **Dynamic Configuration** - Works for any user, no hardcoded paths

---

## File Structure

```
edge-vpn-container/
├── Dockerfile                   # Container image definition
├── start.sh                     # Container startup script
├── run.sh                       # Host launcher script
├── linux_f5vpn.x86_64.deb      # F5 VPN client installer
├── README.md                    # This file
├── SECURITY_REVIEW.md           # Security analysis
├── IMPROVEMENTS.md              # What was improved and why
└── DOWNLOADS_PERSISTENCE.md     # Download configuration details
```

---

## Requirements

- **Docker** 20.10+ (28.5.1 tested)
- **Ubuntu** 24.04+ or similar (25.10 host tested)
- **Display Server** - Wayland or X11
- **GPU** (optional) - For hardware acceleration

---

## Configuration

### Default Settings

| Setting | Value | Customizable |
|---------|-------|--------------|
| Downloads | `~/Downloads` | ✅ Yes |
| Config | `~/.config/microsoft-edge-docker` | ✅ Yes |
| Memory Limit | 4GB | ✅ Yes |
| CPU Limit | 4 cores | ✅ Yes |
| Display | Auto-detect | ❌ Auto |

### Customize Resource Limits

Edit `run.sh` and modify:

```bash
--memory=4g       # Change to 2g, 8g, etc.
--cpus=4          # Change to 2, 8, etc.
--shm-size=2gb    # Increase for many browser tabs
```

### Customize Download Location

Edit `run.sh` and change:

```bash
DOWNLOADS_DIR="${USER_HOME}/Downloads"
# To:
DOWNLOADS_DIR="/path/to/your/downloads"
```

---

## Security

This container follows security best practices:

- ✅ **Non-root user** - Runs as your UID/GID
- ✅ **Seccomp enabled** - Syscall filtering active
- ✅ **No extra capabilities** - Least privilege principle
- ✅ **Isolated IPC** - Separate IPC namespace
- ✅ **Resource limits** - Prevents resource exhaustion
- ✅ **No new privileges** - Cannot escalate privileges
- ✅ **Read-only mounts** - Where appropriate

For detailed security analysis, see [`SECURITY_REVIEW.md`](SECURITY_REVIEW.md).

---

## Troubleshooting

### Container Won't Start

```bash
# Check if image exists
docker images | grep edge-vpn

# If not, rebuild
docker build -t edge-vpn .
```

### Display Not Working

```bash
# Check display server
echo "DISPLAY=$DISPLAY"
echo "WAYLAND_DISPLAY=$WAYLAND_DISPLAY"

# Test X11 access
xhost +local:

# Check XDG_RUNTIME_DIR
echo "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR"
```

### GPU Not Working

```bash
# Check GPU devices
ls -la /dev/dri/

# Check permissions
groups | grep video

# Test inside container
docker exec edge-vpn-container ls -la /dev/dri/
```

### Downloads Not Persisting

```bash
# Test file creation
docker exec edge-vpn-container touch ~/Downloads/test.txt
ls ~/Downloads/test.txt

# If fails, check mounts
docker inspect edge-vpn-container | jq '.[0].Mounts'
```

### Permission Errors

```bash
# Verify UID/GID match
echo "Host UID: $(id -u)"
docker exec edge-vpn-container id -u

# Should match. If not, check run.sh:
# -u $(id -u):$(id -g)
```

---

## Advanced Usage

### Run in Background (Detached)

Edit `run.sh` and change:
```bash
docker run -it --rm \
# To:
docker run -d --rm \
```

Then attach when needed:
```bash
docker attach edge-vpn-container
```

### Custom Network

```bash
# Create custom network
docker network create edge-network

# Edit run.sh, replace:
--network host
# With:
--network edge-network
```

### Multiple Instances

```bash
# Copy and rename run.sh
cp run.sh run-instance2.sh

# Edit run-instance2.sh, change:
--name edge-vpn-container
# To:
--name edge-vpn-instance2
```

---

## Maintenance

### Update Container

```bash
# Rebuild with latest packages
docker build --no-cache -t edge-vpn .

# Remove old images
docker image prune
```

### Check Container Health

```bash
# View health status
docker inspect --format='{{.State.Health.Status}}' edge-vpn-container

# View logs
docker logs edge-vpn-container

# View resource usage
docker stats edge-vpn-container
```

### Backup Configuration

```bash
# Backup Edge config
tar czf edge-config-backup.tar.gz ~/.config/microsoft-edge-docker

# Restore if needed
tar xzf edge-config-backup.tar.gz -C ~/
```

---

## Documentation

- **[SECURITY_REVIEW.md](SECURITY_REVIEW.md)** - Complete security analysis
- **[IMPROVEMENTS.md](IMPROVEMENTS.md)** - What was improved and why
- **[DOWNLOADS_PERSISTENCE.md](DOWNLOADS_PERSISTENCE.md)** - Download configuration

---

## Verification

### Test Complete Setup

```bash
# 1. Build succeeds
docker build -t edge-vpn . && echo "✅ Build OK"

# 2. Image exists
docker images edge-vpn && echo "✅ Image OK"

# 3. Run script works
./run.sh &
sleep 5
docker ps | grep edge-vpn && echo "✅ Container running"

# 4. Downloads persist
docker exec edge-vpn-container touch ~/Downloads/test.txt
[ -f ~/Downloads/test.txt ] && echo "✅ Downloads persist"
rm ~/Downloads/test.txt

# 5. Stop container
docker stop edge-vpn-container && echo "✅ Test complete"
```

---

## Support

For issues or improvements:
1. Review troubleshooting section above
2. Check documentation files
3. Verify system requirements
4. Review Docker logs: `docker logs edge-vpn-container`

---

## License

This setup is provided as-is for personal use. Microsoft Edge and F5 VPN have their own licenses.
