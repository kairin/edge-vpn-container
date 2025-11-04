# Download Persistence Configuration

This document explains how downloads from Edge are persisted to your host system.

---

## How It Works

### Volume Mounts

Both the current and improved scripts mount your Downloads directory:

**Current (`run.sh`):**
```bash
-v /home/user/Downloads:/home/user/Downloads
```

**Improved (`run-improved.sh`):**
```bash
DOWNLOADS_DIR="${USER_HOME}/Downloads"
-v "${DOWNLOADS_DIR}:${DOWNLOADS_DIR}:rw"
```

### What This Means

1. **Files persist after container exits** - Downloads are written to your host filesystem
2. **Same path inside and outside** - `/home/user/Downloads` inside = `/home/user/Downloads` outside
3. **Read-write access** - Container can create/modify files

---

## Verification

### Test Download Persistence

```bash
# 1. Start container
./run-improved.sh

# 2. In Edge, download a file (e.g., visit https://speed.hetzner.de/ and download a test file)

# 3. Exit Edge/container

# 4. Check if file persists on host
ls -lh ~/Downloads/
```

**Expected Result:** Downloaded file should be visible in your host `~/Downloads` directory.

---

## Current Configuration Status

### Dockerfile Settings

**Current `Dockerfile`:**
```dockerfile
# Line 59: Creates Downloads directory in container
RUN mkdir -p /home/user/Downloads && chown -R user:user /home/user
```

**Improved `Dockerfile.improved`:**
```dockerfile
# Line 68: Creates Downloads directory
RUN mkdir -p /home/containeruser/Downloads \
    && chown -R containeruser:containeruser /home/containeruser
```

### Run Script Mounts

**Both scripts mount:**
- Source: Your host `~/Downloads` directory
- Destination: Same path inside container
- Mode: Read-Write (`rw`)

---

## Edge Download Settings

Edge stores its download location preference in the config directory, which is also mounted:

```bash
# Config directory mount (preserves Edge settings)
-v ~/.config/microsoft-edge-docker:~/.config/microsoft-edge:rw
```

### Setting Default Download Location

1. **First Run:** Open Edge settings → Downloads
2. **Set location:** Choose `/home/user/Downloads` (or your home Downloads)
3. **This setting persists** because config is mounted

### Verification Command

Check where Edge will download:
```bash
# After running Edge once and setting download location
grep -r "download" ~/.config/microsoft-edge-docker/Default/Preferences 2>/dev/null | grep -i "directory"
```

---

## Potential Issues & Solutions

### Issue 1: Downloads Not Persisting

**Symptom:** Files disappear after container exits

**Diagnosis:**
```bash
# Check if mount is active while container runs
docker inspect edge-vpn-container | jq '.[0].Mounts[] | select(.Destination | contains("Downloads"))'
```

**Solution:** Verify the volume mount includes `:rw` flag (read-write)

### Issue 2: Permission Denied

**Symptom:** Cannot download files, permission errors

**Diagnosis:**
```bash
# Check Downloads directory ownership
ls -ld ~/Downloads

# Check container user ID
docker exec edge-vpn-container id
```

**Solution:** Ensure UIDs match:
```bash
# Should be same UID inside and outside
echo "Host UID: $(id -u)"
docker exec edge-vpn-container id -u  # Should match
```

### Issue 3: Wrong Download Location

**Symptom:** Files download to unexpected location

**Solution 1 - Check Edge settings:**
1. Open Edge → Settings → Downloads
2. Verify "Location" is set to your Downloads folder
3. Enable "Ask where to save each file before downloading" temporarily to verify

**Solution 2 - Check XDG settings:**
```bash
# Ensure XDG_DOWNLOAD_DIR points to correct location
echo "XDG_DOWNLOAD_DIR=${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"
```

---

## Best Practices

### 1. Use Absolute Paths

❌ **Don't:**
```bash
-v Downloads:Downloads  # Relative path - will fail
```

✅ **Do:**
```bash
-v "$HOME/Downloads:$HOME/Downloads"  # Absolute path - works
```

### 2. Verify Mount Before Use

Add to run script:
```bash
# Create Downloads directory if missing
mkdir -p "$HOME/Downloads"
echo "Downloads will be saved to: $HOME/Downloads"
```

### 3. Set Default Download Location in Edge

On first run:
1. Open Edge
2. Navigate to `edge://settings/downloads`
3. Click "Change" next to Location
4. Select your mounted Downloads folder
5. Disable "Ask where to save..." for automatic downloads

### 4. Test Before Important Downloads

```bash
# Create test file to verify mount
docker exec edge-vpn-container touch ~/Downloads/test-from-container.txt

# Check if visible on host
ls ~/Downloads/test-from-container.txt

# Clean up
rm ~/Downloads/test-from-container.txt
```

---

## Advanced Configuration

### Custom Download Location

If you want downloads elsewhere (e.g., separate drive):

**Edit `run-improved.sh`:**
```bash
# Change this line:
DOWNLOADS_DIR="${USER_HOME}/Downloads"

# To your custom location:
DOWNLOADS_DIR="/mnt/data/downloads"  # or wherever you want

# Ensure it exists:
mkdir -p "$DOWNLOADS_DIR"
```

### Multiple Download Directories

Mount multiple locations:
```bash
docker run ... \
  -v "$HOME/Downloads:$HOME/Downloads:rw" \
  -v "/mnt/data/work-downloads:/work:rw" \
  -v "/mnt/data/personal-downloads:/personal:rw" \
  edge-vpn
```

Then in Edge, choose which directory per download.

### Read-Only Host Protection

If you want Edge to download to container only (not recommended):
```bash
# Remove Downloads mount, use temporary container storage
# Downloads will be lost when container exits
docker run ... edge-vpn  # No -v for Downloads
```

---

## Verification Checklist

- [ ] Downloads directory exists on host: `ls -ld ~/Downloads`
- [ ] Volume mount is configured in run script
- [ ] Container has write permission: `docker exec edge-vpn-container touch ~/Downloads/test.txt`
- [ ] Test download persists after container exit
- [ ] Edge download location is set to mounted directory
- [ ] File ownership matches (same UID inside and out)

---

## Quick Test

Run this complete test:

```bash
# 1. Start container
./run-improved.sh &
CONTAINER_PID=$!

# 2. Wait for container to start
sleep 5

# 3. Create file from inside container
docker exec edge-vpn-container bash -c 'echo "Test from container" > ~/Downloads/container-test.txt'

# 4. Verify on host
if [ -f ~/Downloads/container-test.txt ]; then
    echo "✅ SUCCESS: Downloads persist to host"
    cat ~/Downloads/container-test.txt
    rm ~/Downloads/container-test.txt
else
    echo "❌ FAILED: Downloads not persisting"
fi

# 5. Stop container
docker stop edge-vpn-container
```

Expected output:
```
✅ SUCCESS: Downloads persist to host
Test from container
```

---

## Summary

**TL;DR:**
- ✅ Downloads **DO persist** after container exits
- ✅ Both current and improved scripts mount `~/Downloads` correctly
- ✅ Files written inside container → Saved on host
- ✅ Container exit does NOT delete downloads

**Your downloaded files are safe!**
