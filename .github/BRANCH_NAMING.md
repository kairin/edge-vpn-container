# Branch Naming Convention

This project uses datetime-prefixed branch names for clear chronological tracking.

## Format

```
YYYY-MM-DD_HH-MM-SS-concise-feature-name
```

## Examples

### Good Branch Names

```bash
2025-11-05_14-00-00-gpu-hardware-acceleration
2025-11-05_17-30-00-modular-verification
2025-11-06_09-15-00-add-vpn-client
2025-11-06_14-22-30-fix-display-issue
```

### Why This Format?

1. **Chronological Sorting**: Branches naturally sort by creation time
2. **Precise Timestamps**: Down to the second for disambiguation
3. **Clear Purpose**: Concise feature name after timestamp
4. **Grep-friendly**: Easy to find branches from specific dates

## Creating New Branches

### Manual Creation

```bash
# Get current timestamp
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)

# Create branch with descriptive name
git checkout -b "${TIMESTAMP}-feature-description"
```

### Helper Function (Add to ~/.bashrc)

```bash
git-branch-new() {
    local feature_name="$1"
    if [ -z "$feature_name" ]; then
        echo "Usage: git-branch-new <feature-name>"
        return 1
    fi

    local timestamp=$(date +%Y-%m-%d_%H-%M-%S)
    local branch_name="${timestamp}-${feature_name}"

    git checkout -b "$branch_name"
    echo "Created branch: $branch_name"
}
```

**Usage:**
```bash
git-branch-new modular-verification
# Creates: 2025-11-05_17-30-00-modular-verification
```

## Branch Lifecycle

### 1. Create Feature Branch

```bash
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
git checkout -b "${TIMESTAMP}-add-new-feature"
```

### 2. Work on Feature

```bash
# Make changes
git add .
git commit -m "feat: Add new feature"
```

### 3. Push to Remote

```bash
git push upstream 2025-11-05_17-30-00-add-new-feature
```

### 4. Merge to Main

```bash
git checkout main
git merge 2025-11-05_17-30-00-add-new-feature
git push upstream main
```

### 5. Optional: Keep Branch or Delete

```bash
# Keep for history (recommended)
# Branch remains in repository

# Or delete if no longer needed
git branch -d 2025-11-05_17-30-00-add-new-feature
git push upstream --delete 2025-11-05_17-30-00-add-new-feature
```

## Finding Branches

### By Date

```bash
# Branches from November 5, 2025
git branch -a | grep 2025-11-05

# Branches from afternoon (14:00-18:00)
git branch -a | grep "2025-11-05_1[4-8]"
```

### By Feature

```bash
# All GPU-related branches
git branch -a | grep gpu

# All modular-related branches
git branch -a | grep modular
```

### Recent Branches

```bash
# Show all branches sorted by date (most recent first)
git branch -a | grep -E "[0-9]{4}-[0-9]{2}-[0-9]{2}" | sort -r
```

## Renaming Existing Branches

If you created a branch without the datetime prefix:

```bash
# Current branch
git branch -m old-branch-name 2025-11-05_17-30-00-old-branch-name

# Remote update
git push upstream 2025-11-05_17-30-00-old-branch-name
git push upstream --delete old-branch-name
```

## Migration from Old Naming

Old branches used numeric prefixes:
- `001-nvidia-runtime-verification`
- `002-gpu-hardware-acceleration`

These have been renamed to:
- `2025-11-04_12-00-00-nvidia-runtime-verification`
- `2025-11-05_14-00-00-gpu-hardware-acceleration`

## Git Aliases (Optional)

Add to `~/.gitconfig`:

```ini
[alias]
    # Create timestamped branch
    branch-new = "!f() { git checkout -b $(date +%Y-%m-%d_%H-%M-%S)-$1; }; f"

    # List branches by date
    branches-by-date = "!git branch -a | grep -E '[0-9]{4}-[0-9]{2}-[0-9]{2}' | sort -r"

    # List today's branches
    branches-today = "!git branch -a | grep $(date +%Y-%m-%d)"
```

**Usage:**
```bash
git branch-new add-feature      # Creates timestamped branch
git branches-by-date            # List all dated branches
git branches-today              # List today's branches
```

## Benefits

### For Teams
- **No Conflicts**: Timestamps ensure unique branch names
- **Context**: Immediately see when work started
- **Tracking**: Easy to audit what was worked on when

### For Solo Development
- **History**: Clear timeline of feature development
- **Organization**: Chronological sorting is intuitive
- **Search**: Find work from specific time periods

## Anti-Patterns (Avoid)

### Don't Use Short Dates
```bash
# Bad - ambiguous
2025-11-05-feature

# Good - precise timestamp
2025-11-05_17-30-00-feature
```

### Don't Omit Feature Name
```bash
# Bad - unclear purpose
2025-11-05_17-30-00

# Good - clear purpose
2025-11-05_17-30-00-fix-display-bug
```

### Don't Use Spaces
```bash
# Bad - problematic in shell
2025-11-05 17:30:00 feature name

# Good - hyphen-separated
2025-11-05_17-30-00-feature-name
```

## Summary

**Format:** `YYYY-MM-DD_HH-MM-SS-feature-name`

**Example:** `2025-11-05_17-30-00-modular-architecture`

**Create:** `git checkout -b $(date +%Y-%m-%d_%H-%M-%S)-feature-name`

**Find:** `git branch -a | grep 2025-11-05`

This convention provides clear, sortable, searchable branch names that make project history easy to navigate.
