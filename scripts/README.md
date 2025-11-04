# Utility Scripts

This folder contains diagnostic and testing scripts that are not required for normal container operation.

## Scripts

### quick-verify.sh
**Purpose:** Diagnostic tool to verify NVIDIA GPU setup
**Usage:** `./scripts/quick-verify.sh`
**When to use:** Before running the container to check if prerequisites are met
**Checks:**
- Docker image exists
- NVIDIA GPU detected
- NVIDIA libraries present
- Display server available
- Video group access
- Config/Downloads directories

### start.sh
**Purpose:** Old Edge browser startup script (legacy)
**Status:** Not currently used - Dockerfile drops to bash instead
**Note:** Kept for reference in case Edge needs to auto-launch later

### test-container.sh
**Purpose:** Testing tool for container functionality
**Status:** Not needed for normal operation
**Note:** Used during development for debugging

## Current Container Operation

The current setup (`run.sh` + `Dockerfile`) doesn't use any of these scripts:
- Container drops to bash shell
- No auto-launch of Edge browser
- NVIDIA runtime handles GPU automatically

These scripts are archived here for:
1. Diagnostic purposes (quick-verify.sh)
2. Future enhancements (start.sh)
3. Historical reference (test-container.sh)
