# Docker Build Logs

This directory contains logs from Docker image build processes (`build.sh`).

## Purpose

Automatically record the entire Docker build process for:
- Debugging build failures
- Tracking what was installed in each image version
- Documentation of build steps and dependencies
- Audit trail of image creation

## Log Files

**Format:** Markdown (`.md`)
**Naming:** `build-YYYY-MM-DD_HH-MM-SS.md`
**Example:** `build-2025-11-05_16-30-00.md`

## What's Logged

Each build log captures:
- ✅ All Docker build steps and layer outputs
- ✅ Package installation messages
- ✅ Download progress for NVIDIA base image
- ✅ Microsoft Edge installation process
- ✅ Build start and end timestamps
- ✅ Final image size and build status

## Log Structure

```markdown
# Docker Build Log

**Started:** Wed Nov  5 16:30:00 +08 2025
**Image:** cuda-container
**Base:** nvcr.io/nvidia/cuda-dl-base:25.10-cuda13.0-runtime-ubuntu24.04

---

## Build Output

```
[All build output - docker layers, downloads, installations]
```

---

**Ended:** Wed Nov  5 16:35:00 +08 2025
```

## Usage

```bash
# Build image (generates new log)
./scripts/build.sh

# View most recent build log
cat $(ls -t logs/docker-builds/*.md | head -1)

# View in markdown viewer
glow $(ls -t logs/docker-builds/*.md | head -1)

# Search for errors in build logs
grep -i "error\|failed" logs/docker-builds/*.md

# Find what packages were installed
grep "Setting up" logs/docker-builds/build-*.md
```

## When to Build

Run `./scripts/build.sh`:
- **First time setup** - Create the initial image
- **After Dockerfile changes** - Rebuild with new configuration
- **After base image updates** - Get latest NVIDIA CUDA updates
- **To create new image version** - Document specific build

## Cleanup

```bash
# Delete logs older than 30 days
find logs/docker-builds -name "*.md" -mtime +30 -delete

# Keep only the 10 most recent build logs
ls -t logs/docker-builds/*.md | tail -n +11 | xargs rm -f
```

## Benefits

- 📊 **Complete build history** - Every image build documented
- 🐛 **Debug build failures** - See exactly where build broke
- 📦 **Track dependencies** - Know what's installed in each version
- 🔍 **Searchable records** - Find specific packages or versions
- ✅ **Clean format** - Markdown with no ANSI escape codes

## Build vs. Session Logs

- **Build logs** (this directory) - What happens when creating the image
- **Session logs** (`container-sessions/`) - What happens when running the container

Build once, run many times!
