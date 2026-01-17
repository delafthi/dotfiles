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

- **CLAUDE.md creation**: When using `init` command to create project-specific instructions:

  - Do NOT include a VCS section
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

## Custom Agent Usage

Use specialized custom agents for specific tasks to improve efficiency and reduce blocking:

### Code Agent

**Use for:**

- Writing new code and features
- Implementing bug fixes
- Creating test suites
- Modifying existing code

**When to spawn:**

- User requests code implementation or tests
- Multi-file code changes needed
- Run in **background** for non-blocking test creation

**Agent handles:**

- Language-specific patterns and conventions
- Security best practices (OWASP Top 10)
- Testing frameworks and patterns
- Build system integration

### Documentation Agent

**Use for:**

- Creating or updating README files
- Adding code documentation (docstrings, API docs)
- Writing user guides

**When to spawn:**

- User requests documentation creation/improvement
- README generation or enhancement
- Run in **background** for non-blocking documentation work

**Agent handles:**

- Build system detection and commands
- Documentation style by language
- README structure and content
- Spawns Explore agent for README creation (to understand project)

### Review Agent

**Use for:**

- Conducting structured code reviews
- Analyzing security and correctness
- Providing actionable feedback

**When to spawn:**

- User requests code review
- Reviewing specific files or current changes
- Keep **blocking** so review completes before user continues

**Agent handles:**

- Project context analysis via Explore agent
- Issue categorization and prioritization
- Language-specific security checks
- Structured review output format

### VCS Agent

**Use for:**

- Creating commits with proper messages
- Creating pull requests
- Managing branches
- Analyzing diffs and history

**When to spawn:**

- User requests commit or PR creation
- VCS operations needed
- Keep **blocking** for commits/PRs to ensure completion

**Agent handles:**

- VCS detection (jujutsu vs git)
- Commit message format (Conventional Commits)
- Contribution guidelines detection
- PR analysis and description generation

### Built-in Agents

**Explore agent** (`subagent_type=Explore`):

- Use for codebase exploration
- Understanding architecture and patterns
- Open-ended questions about code structure

**Direct tools** (Glob, Grep, Read):

- Use for specific file/class/function lookups
- Reading known file paths
- Exact string searches

**Examples:**

```
User: "Write tests for auth.py"
→ Spawn Code agent (background)

User: "Create a README for this project"
→ Spawn Documentation agent (background)

User: "Review my current changes"
→ Spawn Review agent (blocking)

User: "Commit these changes"
→ Spawn VCS agent (blocking)

User: "How does authentication work?"
→ Use Explore agent

User: "Read src/main.rs"
→ Use Read tool directly
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

**General principles:**

- Read files before modifying them (Claude Code requirement)
- Prefer editing existing files over creating new ones
- Keep solutions simple and focused
- Follow existing patterns in the codebase
- Avoid over-engineering and unnecessary abstractions
- Don't add features beyond what was asked
- Only document public APIs and non-obvious logic

**Security:**

- Watch for command injection, XSS, SQL injection, OWASP top 10
- If you write insecure code, immediately fix it
- Only validate at system boundaries (user input, external APIs)

**Tool usage:**

- Use Read/Edit/Write for file operations (not cat/sed/awk via Bash)
- Use Bash only for terminal operations (git, npm, docker, etc.)

**Note:** Custom agents (code, documentation, review) contain detailed quality guidelines for their domains.

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

- **VCS**: Strongly prefer jujutsu - I use jujutsu in almost all projects
  - **Always use jujutsu when `.jj/` directory is detected**
  - Never fall back to git when jujutsu is available in the project
  - Use detection command before any VCS operations
- **Build system**: Prefer Nix for reproducibility
- **Detection first**: Always verify tool availability before use
- **Output style**: Minimal, concise, no emojis unless requested
- **Documentation**: Avoid over-documentation; document only public APIs
- **Code style**: Follow existing patterns; avoid over-engineering
- **Communication**: Be objective, avoid superlatives and excessive praise
- **Planning**: Provide implementation steps, never time estimates
