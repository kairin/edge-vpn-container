# Docker Build Logs

Timestamped markdown files containing complete Docker image build outputs.

## Structure

One log file per build:

```
logs/docker-builds/
└── build-2025-11-05_16-30-00.md      # Complete build output
```

## What's Logged

Each build log contains:
- Build start timestamp
- Base image pull progress
- All Docker build steps and layer outputs
- Package installation messages (base dependencies, GPU libs, Edge)
- Success/failure status
- Build completion timestamp

## Format

```markdown
# Docker Build Log

**Started:** Wed Nov 5 16:30:00 +08 2025
**Image:** cuda-container
**Base:** nvcr.io/nvidia/cuda-dl-base:25.10-cuda13.0-runtime-ubuntu24.04

---

## Build Output

```
[All docker build output]
```

---

**Ended:** Wed Nov 5 16:35:00 +08 2025
```

## Common Commands

```bash
# View latest build
cat $(ls -t logs/docker-builds/*.md | head -1)

# Find build errors
grep -i "error\|failed" logs/docker-builds/*.md

# Find what packages were installed
grep "Setting up" logs/docker-builds/build-*.md

# Count total builds
ls logs/docker-builds/build-*.md | wc -l
```

## When Generated

Created by `./scripts/build.sh` when building the Docker image. Typically run:
- First time setup
- After Dockerfile changes
- To update to latest packages

## Cleanup

```bash
# Delete logs older than 30 days
find logs/docker-builds -name "build-*.md" -mtime +30 -delete

# Keep only 10 most recent builds
ls -t logs/docker-builds/build-*.md | tail -n +11 | xargs rm -f
```
