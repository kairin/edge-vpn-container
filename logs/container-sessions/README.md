# Container Session Logs

This directory contains complete terminal session recordings from Docker container runs.

## Purpose

Automatically record everything that happens inside the container for:
- Debugging issues after they occur
- Documentation of what was tested
- Reproducibility of commands and results
- Audit trail of container activity

## Log Files

**Format:** Markdown (`.md`)
**Naming:** `session-YYYY-MM-DD_HH-MM-SS.md`
**Example:** `session-2025-11-05_16-02-04.md`

## What's Logged

Each session log captures:
- ✅ All commands typed inside the container
- ✅ All command outputs (stdout and stderr)
- ✅ Container startup messages (CUDA banner, etc.)
- ✅ Session start and end timestamps
- ✅ Container exit status

## Log Structure

```markdown
# Container Session Log

**Started:** Wed Nov  5 16:00:00 +08 2025
**Container:** cuda-container
**User:** kkk (1000:1000)
**Display:** :0

---

## Session Output

```
[All session content - commands and outputs]
```

---

**Ended:** Wed Nov  5 16:05:30 +08 2025
```

## Usage

```bash
# View most recent session
cat $(ls -t logs/container-sessions/*.md | head -1)

# View in markdown viewer
glow $(ls -t logs/container-sessions/*.md | head -1)

# Search for specific commands
grep "nvidia-smi" logs/container-sessions/session-*.md

# Search for errors
grep -i "error\|failed" logs/container-sessions/session-*.md

# Extract just commands (lines starting with ubuntu@)
grep "^ubuntu@" logs/container-sessions/session-*.md
```

## Use Cases

### 1. Debugging
Review what happened when something went wrong:
```bash
# Find when error occurred
grep -n "error" logs/container-sessions/session-2025-11-05_*.md
```

### 2. Reproducibility
See exactly what commands were run:
```bash
# Extract command history
grep "^ubuntu@" logs/container-sessions/session-2025-11-05_16-00-00.md
```

### 3. Documentation
Session logs automatically document your work:
- What was tested
- What results were obtained
- What commands were used

### 4. Troubleshooting
Share complete session logs when asking for help - provides full context without missing details.

## Cleanup

```bash
# Delete logs older than 7 days
find logs/container-sessions -name "*.md" -mtime +7 -delete

# Keep only the 10 most recent logs
ls -t logs/container-sessions/*.md | tail -n +11 | xargs rm -f
```

## Benefits

- 📝 **Complete audit trail** - Never lose track of what you did
- 🐛 **Debug after the fact** - Review issues without reproducing them
- 📚 **Automatic documentation** - No need to manually record commands
- 🔍 **Searchable history** - Find specific commands or outputs easily
- ✅ **Clean format** - Markdown with no ANSI escape codes

## Privacy Note

Session logs may contain:
- File paths from your home directory
- Command history
- Application outputs

Review logs before sharing if they might contain sensitive information.
