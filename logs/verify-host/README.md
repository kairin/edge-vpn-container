# Host Verification Logs

Timestamped directories containing results from `./scripts/verify-host.sh` runs.

## Structure

Each verification run creates one timestamped directory:

```
logs/verify-host/
└── 2025-11-05_15-54-47/              # One directory per run
    ├── 01-check-display.md            # DISPLAY variable check
    ├── 02-check-x11.md                # X11 socket accessibility
    ├── 03-check-xhost.md              # xhost access control
    ├── 04-check-docker.md             # Docker installation & permissions
    ├── 05-check-nvidia-gpu.md         # GPU detection & capabilities
    ├── 06-check-nvidia-runtime.md     # NVIDIA Docker runtime
    ├── 07-enable-persistence-mode.md  # Persistence mode setup
    └── summary.md                     # Combined summary with links
```

## What's Logged

Each check creates individual markdown log containing:
- Check name and purpose
- Timestamp
- Detailed results with status indicators (✓/✗/⚠)
- Resolution steps if failed

**summary.md** provides:
- Overall status (pass/warnings/errors)
- Links to all individual check logs
- Quick navigation

## Common Commands

```bash
# View latest verification
cat $(ls -t logs/verify-host/*/summary.md | head -1)

# View specific check from latest run
cat $(find logs/verify-host -name "05-check-nvidia-gpu.md" | sort | tail -1)

# Find all failed checks
grep -r "✗" logs/verify-host/*/0*.md
```

## When Generated

Created by `./scripts/verify-host.sh` which runs before building the image or when troubleshooting system configuration.

## Cleanup

```bash
# Delete runs older than 30 days
find logs/verify-host -type d -name "20*" -mtime +30 -exec rm -rf {} +

# Keep only 20 most recent runs
ls -t logs/verify-host/ -d | tail -n +21 | xargs rm -rf
```
