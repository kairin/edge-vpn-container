# Container Session Logs

Timestamped markdown files recording complete terminal sessions inside the container.

## Structure

One log file per container session:

```
logs/container-sessions/
└── session-2025-11-05_16-35-00.md    # Complete session recording
```

## What's Logged

Each session log captures everything from container start to exit:
- Container startup messages
- All commands typed
- All command outputs (stdout and stderr)
- Session start and end timestamps
- Container exit status

## Format

```markdown
# Container Session Log

**Started:** Wed Nov 5 16:35:00 +08 2025
**Container:** cuda-container
**User:** kkk (1000:1000)
**Display:** :0

---

## Session Output

```
[All session content - commands and outputs]
```

---

**Ended:** Wed Nov 5 16:40:30 +08 2025
```

## Common Commands

```bash
# View latest session
cat $(ls -t logs/container-sessions/*.md | head -1)

# Find sessions with errors
grep -i "error\|failed" logs/container-sessions/*.md

# Extract commands only (lines starting with ubuntu@)
grep "^ubuntu@" logs/container-sessions/session-*.md

# Count total sessions
ls logs/container-sessions/session-*.md | wc -l
```

## When Generated

Created by `./scripts/run.sh` every time the container is launched. Records from container start until you type `exit`.

## Use Cases

- **Debugging** - Review what happened when something went wrong
- **Reproducibility** - See exact commands that were run
- **Documentation** - Automatic record of testing/usage
- **Troubleshooting** - Share complete context when asking for help

## Cleanup

```bash
# Delete logs older than 7 days
find logs/container-sessions -name "session-*.md" -mtime +7 -delete

# Keep only 10 most recent sessions
ls -t logs/container-sessions/session-*.md | tail -n +11 | xargs rm -f
```

## Privacy Note

Session logs contain everything typed in the container including:
- Command history
- File paths
- Application outputs

Review logs before sharing if they might contain sensitive information.
