# Global Agent Guidelines for Claude Code

This document contains global instructions for Claude Code interactions. These guidelines should be followed for all projects unless project-specific instructions override them.

## Core Principles

- **Prefer jujutsu**: Jujutsu is the preferred VCS and will be used in most cases
- **Prefer Nix**: Nix is the preferred build system for reproducibility
- **Detection first**: Always verify tool availability before use
- **Minimal and concise**: Keep all outputs, commits, and documentation minimal
- **Task-oriented**: Use TodoWrite to track complex multi-step tasks

## Version Control System Detection

Detect the version control system before performing any VCS operations.

### Detection

- Check for `.jj/` directory in repository root → use **jujutsu**
- Otherwise, check for `.git/` directory → use **git**

### Detection Command

```bash
test -d .jj && echo "jujutsu" || echo "git"
```

### Usage Rules

When `.jj/` is detected, use jujutsu commands:

- `jj status` (not `git status`)
- `jj diff` (not `git diff`)
- `jj describe -m "message"` (not `git commit -m`)
- `jj new` (create new change, not `git commit`)
- `jj branch` (not `git branch`)
- `jj log` (not `git log`)

**Important**: NEVER mix git and jujutsu commands in the same repository.

## Build System Detection

Detect the build system before running build, format, or check operations.

### Detection Priority

1. **Nix Flakes**: Check for `flake.nix`
1. **Just**: Check for `justfile` or `Justfile`
1. **Language-specific**: Check for `package.json`, `Cargo.toml`, `pyproject.toml`, `go.mod`, etc.

### Detection Command

```bash
if [ -f flake.nix ]; then
  echo "nix"
elif [ -f justfile ] || [ -f Justfile ]; then
  echo "just"
else
  echo "language-specific"
fi
```

### Priority Rules

1. **Nix takes precedence** when `flake.nix` exists:

- Format: `nix fmt` (prefer over `just fmt`)
- Check: `nix flake check` (prefer over `just check`)
- Build: `nix build` (prefer over `just build`)
- Update: `nix flake update` (prefer over `just update`)

2. **Just as secondary** when no `flake.nix`:

- List tasks: `just --list`
- Use for project-specific workflows

3. **Language-specific tools** when neither Nix nor Just exist:

- npm/pnpm/yarn for `package.json`
- cargo for `Cargo.toml`
- go for `go.mod`
- Check project README/CONTRIBUTING for preferred commands

### Best Practices

- Always detect before assuming tool availability
- Respect the detected hierarchy
- When both `flake.nix` and `justfile` exist, prefer Nix commands (just may wrap Nix for convenience)

## Contribution Guidelines Detection

Always look for contribution guidelines in the project before making changes or creating documentation.

### Common Locations

- `CONTRIBUTING.md` in repository root
- `CONTRIBUTING` (without extension)
- `.github/CONTRIBUTING.md`
- `docs/CONTRIBUTING.md`
- `CONTRIBUTE.md`

### Usage Rules

When contribution guidelines are found:

- Follow specified commit message formats and conventions
- Adhere to code style requirements beyond what formatters enforce
- Respect branch naming conventions
- Follow PR/MR templates and requirements
- Apply testing requirements
- Use specified changelog format

### Special Cases

- **AGENTS.md creation**: When using `init` command, check contribution guidelines first to:
  - Match project's preferred format and structure
  - Include project-specific build/test/lint commands
  - Respect existing documentation patterns
  - Align with project's coding standards

### Detection Command

```bash
for file in CONTRIBUTING.md CONTRIBUTING .github/CONTRIBUTING.md docs/CONTRIBUTING.md CONTRIBUTE.md; do
  [ -f "$file" ] && echo "Found: $file" && break
done
```

## Claude Code Tool Usage

### Task Tool vs Direct Tools

**Use Task tool with subagent_type=Explore when:**

- Exploring codebase structure and organization
- Finding patterns and conventions across multiple files
- Answering open-ended questions about the codebase
- Understanding architectural context
- Searching for concepts rather than specific strings

**Use direct tools (Glob, Grep, Read) when:**

- Looking for a specific file, class, or function name
- Reading a known file path
- Searching for an exact string or pattern
- You need results in 1-2 attempts

**Examples:**

```
User: "Where are errors from the client handled?"
→ Use Task tool with Explore agent

User: "Read the main.rs file"
→ Use Read tool directly

User: "Find the UserAuth class"
→ Use Glob tool: "**/*User*Auth*" or Grep: "class UserAuth"

User: "How does the authentication system work?"
→ Use Task tool with Explore agent
```

### TodoWrite Usage

**Always use TodoWrite for:**

- Tasks with 3+ distinct steps
- Complex, non-trivial tasks
- When user provides multiple tasks in a list
- Any task that benefits from progress tracking

**When creating todos:**

- Use imperative mood for content: "Run tests", "Fix bug"
- Use present continuous for activeForm: "Running tests", "Fixing bug"
- Keep exactly ONE task in_progress at a time
- Mark tasks completed immediately after finishing
- Don't batch completions

### Skills and Hooks

- Skills are invoked with `/skill-name` (e.g., `/commit`, `/pr`, `/review`)
- Skills expand to full prompts with specific instructions
- Hooks are user-configured shell commands that run on events
- Treat feedback from hooks (including `<user-prompt-submit-hook>`) as user input
- If blocked by a hook, adjust actions or ask user to check their hooks config

## Code Quality Guidelines

### What to Avoid

**Over-engineering:**

- Don't add features beyond what was asked
- Don't refactor code that isn't directly related
- Don't add "improvements" unless clearly necessary
- Don't create abstractions for one-time operations
- Don't add error handling for scenarios that can't happen
- Don't design for hypothetical future requirements

**Documentation:**

- Don't add docstrings to code you didn't change
- Don't add comments where logic is self-evident
- Don't create documentation files (\*.md) unless explicitly requested
- Only document public APIs and non-obvious logic

**Backwards compatibility:**

- Don't use backwards-compatibility hacks (renaming unused vars, re-exporting types, etc.)
- If something is unused, delete it completely
- Don't add `// removed` comments for removed code

### What to Do

**Code changes:**

- Read files before modifying them (Claude Code requirement)
- Prefer editing existing files over creating new ones
- Keep solutions simple and focused
- Follow existing patterns in the codebase
- Use the Edit tool for modifications (not sed/awk via Bash)

**Security:**

- Be careful of command injection, XSS, SQL injection, OWASP top 10
- If you write insecure code, immediately fix it
- Only validate at system boundaries (user input, external APIs)
- Trust internal code and framework guarantees

**Tool usage:**

- Use Read tool for reading files (not cat/head/tail via Bash)
- Use Edit tool for editing files (not sed/awk via Bash)
- Use Write tool for new files (not echo/heredoc via Bash)
- Use Bash only for actual terminal operations (git, npm, docker, etc.)

## Workflow Optimization

### Parallel Tool Calls

When calling multiple independent tools:

- Make all calls in a single message with multiple tool blocks
- Only call tools sequentially when they depend on each other
- Never use placeholders or guess missing parameters

**Examples:**

```
# Good: Independent reads in parallel
- Read file A
- Read file B
- Read file C

# Good: Sequential when dependent
- Run git status (get branch name)
- Then run gh pr list --head <branch-name>

# Bad: Sequential when could be parallel
- Read file A, wait
- Read file B, wait
- Read file C, wait
```

### Error Handling

When commands fail:

1. Read the error message carefully
1. Check if detection (VCS, build system) was correct
1. Verify tool availability before assuming it exists
1. Ask user for clarification if unclear
1. Don't make assumptions about environment

## Personal Preferences

- **VCS**: Prefer jujutsu when available (will be the case in most projects)
- **Build system**: Prefer Nix for reproducibility
- **Detection first**: Always verify tool availability before use
- **Output style**: Minimal, concise, no emojis unless requested
- **Documentation**: Avoid over-documentation; document only public APIs
- **Code style**: Follow existing patterns; avoid over-engineering
- **Communication**: Be objective, avoid superlatives and excessive praise
- **Planning**: Provide implementation steps, never time estimates
