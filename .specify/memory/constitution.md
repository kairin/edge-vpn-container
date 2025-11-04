# Edge VPN Container Project Constitution
<!--
================================================================================
SYNC IMPACT REPORT
================================================================================
Version Change: NONE → 1.0.0
Change Type: INITIAL - First constitution version created

Modified Principles: N/A (Initial creation)
Added Sections:
  - Core Principles (5 principles)
  - Docker & Container Standards
  - Development Workflow
  - Governance

Templates Status:
  ✅ agent-file-template.md - No updates needed (generic template)
  ✅ plan-template.md - Constitution Check section already present
  ✅ spec-template.md - Requirements aligned with principles
  ✅ tasks-template.md - Task categorization compatible
  ✅ checklist-template.md - No updates needed (generic template)

Files Requiring Updates: NONE

Follow-up TODOs: NONE

Notes:
  - This is the initial constitution based on existing AGENTS.md guidelines
  - User requirement: CLAUDE.md and GEMINI.md MUST be symlinks to AGENTS.md
  - All principles derived from existing project documentation and best practices
  - No backward compatibility concerns (initial version)
================================================================================
-->

## Core Principles

### I. Agent File Symlink Integrity (NON-NEGOTIABLE)

**Rule**: `CLAUDE.md` and `GEMINI.md` MUST always be symbolic links pointing to `AGENTS.md`. They MUST NOT be standalone files.

**Rationale**: This project supports multiple LLM agents (Claude, Gemini, and potentially others). To maintain consistency and eliminate documentation drift, all agent-specific instruction files must symlink to the single source of truth: `AGENTS.md`. This ensures:
- No conflicting instructions between different AI assistants
- Single point of update for agent guidelines
- Guaranteed consistency across all development sessions

**Validation**:
```bash
# Must return true for both:
test -L CLAUDE.md && readlink CLAUDE.md | grep -q "AGENTS.md"
test -L GEMINI.md && readlink GEMINI.md | grep -q "AGENTS.md"
```

**Enforcement**: Any commit that breaks symlinks or converts them to regular files MUST be rejected in code review.

---

### II. Root Directory Cleanliness

**Rule**: The repository root folder MUST contain ONLY the following files:
- `AGENTS.md` (primary agent instructions)
- `CLAUDE.md` (symlink → AGENTS.md)
- `GEMINI.md` (symlink → AGENTS.md)
- `README.md` (user-facing documentation)
- `Dockerfile` (container image definition)
- `run.sh` (container launcher script)
- Standard repository files (`.git/`, `.gitignore`, `LICENSE`, etc.)

**Rationale**: A clean root directory ensures:
- Easy navigation for developers and AI agents
- Clear separation between operational files and documentation
- Reduced cognitive load when exploring the project
- Professional appearance and maintainability

**File Organization**:
- Documentation and backups → `docs/`
- Utility scripts → `scripts/`
- Test files → `tests/` (if needed)
- Configuration examples → `examples/` (if needed)
- Specification artifacts → `.specify/`

**Enforcement**: Pull requests that add files to root (except the allowed list) MUST move them to appropriate subdirectories before merge.

---

### III. Security-First Container Design (NON-NEGOTIABLE)

**Rule**: All Docker containers MUST follow security best practices established in Phase 2 (documented in `docs/02-security-hardening-improvements-2025-11-04.md`):

**REQUIRED Security Measures**:
- ✅ Default seccomp profile MUST be enabled (NO `--security-opt seccomp=unconfined`)
- ✅ Principle of least privilege: NO `--privileged`, NO `SYS_ADMIN` capability (unless explicitly justified in writing)
- ✅ Resource limits MUST be defined: `--memory`, `--cpus`, `--shm-size`
- ✅ IPC namespace MUST be isolated (NO `--ipc=host` unless documented exception)
- ✅ `--security-opt no-new-privileges` MUST be set
- ✅ Containers MUST run as non-root user with matching host UID/GID
- ✅ Read-only mounts for volumes that don't require write access

**Rationale**: The project underwent a comprehensive security audit (Nov 4, 2025) that identified critical vulnerabilities. These hardening measures prevent:
- Container escapes through syscall exploitation
- Privilege escalation attacks
- Resource exhaustion (DoS)
- Host IPC namespace pollution
- Excessive capabilities abuse

**Enforcement**:
- Security exceptions MUST be documented in `docs/` with:
  - Specific vulnerability being accepted
  - Business justification for the exception
  - Mitigation measures in place
  - Approval date and reviewer
- Any PR that weakens security MUST include updated security documentation

---

### IV. Documentation Preservation & History

**Rule**: Historical documentation MUST be preserved with date-stamped filenames in the `docs/` folder.

**Naming Convention**: `[NN]-[descriptive-name]-YYYY-MM-DD.md`

**Examples**:
- `docs/01-initial-security-audit-2025-11-04.md`
- `docs/02-security-hardening-improvements-2025-11-04.md`
- `docs/03-downloads-volume-mounting-guide.md`
- `docs/04-session-summary-2025-11-04.md`

**Rationale**: This project evolved through multiple phases with significant architectural decisions:
- Phase 1: Initial Ubuntu 24.04 setup with hardcoded paths
- Phase 2: Security hardening and portability improvements
- Phase 3: Migration to NVIDIA CUDA base image
- Phase 4: Repository organization

Each phase's decision context is valuable for:
- Understanding why current architecture exists
- Avoiding regression to previously-rejected approaches
- Onboarding new team members
- Future AI agent sessions that need project context

**Enforcement**: When making significant changes:
1. Create a dated document in `docs/` explaining what changed and why
2. Keep original documentation (don't overwrite)
3. Update `docs/README.md` with summary of new document

---

### V. Portability & Dynamic Configuration

**Rule**: Container scripts MUST NOT contain hardcoded paths or user-specific values. All configuration MUST use environment variables and dynamic detection.

**REQUIRED Dynamic Values**:
- User paths: `$HOME` (NOT `/home/user`)
- User identity: `$(id -u)` and `$(id -g)` (NOT hardcoded UIDs)
- Display server: Auto-detect Wayland vs X11 via `$WAYLAND_DISPLAY` / `$DISPLAY`
- GPU availability: Runtime detection of `/dev/dri/` devices

**Rationale**: Original implementation had hardcoded `/home/user` paths that failed on different systems. Portability ensures:
- Works on any Linux distribution
- Works for any username
- Works with different display server configurations
- Graceful degradation when GPU unavailable

**Example (from `run.sh`)**:
```bash
# ✅ CORRECT: Dynamic detection
USER_HOME="${HOME}"
USER_UID="$(id -u)"
USER_GID="$(id -g)"

# ❌ INCORRECT: Hardcoded values
USER_HOME="/home/user"
USER_UID="1000"
USER_GID="1000"
```

**Enforcement**: Code review MUST reject any hardcoded paths, UIDs, or system-specific assumptions.

---

## Docker & Container Standards

### Image Versioning

**Tag Format**: `edge-cuda<CUDA_VERSION>-ubuntu<UBUNTU_VERSION>`

**Examples**:
- `kairin/bases:edge-cuda13.0-ubuntu24.04` (current)
- `kairin/bases:edge-cuda13.1-ubuntu24.04` (future)

**Publishing**:
- Docker Hub repository: `kairin/bases`
- Document version changes in `docs/` with dated filename
- Update README.md if new version becomes current

### Resource Limits

**Default Limits** (adjust per use case):
- Memory: 4GB (`--memory=4g`)
- CPU: 4 cores (`--cpus=4`)
- Shared Memory: 2GB (`--shm-size=2gb`)

**Justification for Changes**: Document in `docs/` if defaults are insufficient, including:
- Workload requiring more resources
- Performance testing results
- Resource monitoring data

### Base Image Selection

**Current Base**: `nvcr.io/nvidia/cuda-dl-base:25.10-cuda13.0-runtime-ubuntu24.04`

**Rationale**: GPU acceleration required for Microsoft Edge performance in containerized environment.

**Base Image Change Criteria**:
- Must maintain or improve GPU acceleration
- Must maintain security posture
- Must document migration in `docs/` with testing results
- Must update Dockerfile and README.md

---

## Development Workflow

### File Structure

**Root Level** (operational files only):
```
edge-vpn-container/
├── AGENTS.md          # Source of truth for LLM agents
├── CLAUDE.md          # Symlink → AGENTS.md
├── GEMINI.md          # Symlink → AGENTS.md
├── README.md          # User-facing documentation
├── Dockerfile         # Container definition
├── run.sh             # Launch script
├── .gitignore
├── .specify/          # SpecKit configuration
├── docs/              # Documentation archive
└── scripts/           # Utility scripts
```

**Documentation Hierarchy**:
```
docs/
├── README.md                                    # Index of documentation
├── NN-descriptive-name-YYYY-MM-DD.md          # Dated documentation
├── *-backup                                    # Historical file backups
└── session-summary-YYYY-MM-DD.md              # Development session notes
```

### Adding New Features

**Process**:
1. Create feature branch: `git checkout -b feature/description`
2. If significant, create dated documentation in `docs/`
3. Update README.md if user-facing changes
4. Update AGENTS.md if workflow/structure changes (symlinks propagate automatically)
5. Test with `run.sh` and verify security posture
6. Commit with descriptive messages
7. Merge to main after review

### Security Changes

**CRITICAL**: Any changes affecting security MUST:
1. Document in `docs/NN-security-[description]-YYYY-MM-DD.md`
2. Reference original security audit (`docs/01-initial-security-audit-2025-11-04.md`)
3. Explain why change maintains or improves security
4. Include test results demonstrating security posture
5. Get explicit approval before merge

---

## Governance

### Constitution Authority

This constitution supersedes all other development practices. In case of conflict between this document and other documentation, the constitution takes precedence.

**Exception**: Security-related conflicts MUST be resolved in favor of the more secure option, regardless of what the constitution says. Update constitution afterward to reflect security decision.

### Amendment Process

**Version Numbering** (Semantic Versioning):
- **MAJOR** (X.0.0): Breaking changes to core principles, removal of principles, fundamental governance changes
- **MINOR** (0.X.0): New principles added, material expansions to existing principles, new sections
- **PATCH** (0.0.X): Clarifications, wording improvements, typo fixes, non-semantic refinements

**Amendment Steps**:
1. Propose amendment with rationale in issue or PR
2. Document impact on existing practices
3. Update constitution with version bump
4. Update dependent templates in `.specify/templates/`
5. Create migration guide in `docs/` if needed
6. Update AGENTS.md if relevant to LLM agent workflows
7. Commit with message: `docs: amend constitution to vX.Y.Z (brief description)`

### Compliance Review

**Frequency**: Every significant PR should include constitutional compliance check

**Review Checklist**:
- [ ] Symlinks intact (Principle I)
- [ ] Root directory clean (Principle II)
- [ ] Security posture maintained (Principle III)
- [ ] Documentation preserved (Principle IV)
- [ ] Portability maintained (Principle V)
- [ ] Docker standards followed
- [ ] Development workflow followed

**Enforcement**: CI/CD pipeline SHOULD include automated checks for Principles I and II (symlink integrity, root directory cleanliness).

### Runtime Development Guidance

For detailed development instructions, AI agents and developers MUST refer to:
- **AGENTS.md** - LLM agent-specific workflows and repository structure rules
- **README.md** - User-facing quick start and operational guide
- **docs/** folder - Historical context and detailed technical documentation

---

**Version**: 1.0.0 | **Ratified**: 2025-11-04 | **Last Amended**: 2025-11-04
