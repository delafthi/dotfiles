---
allowed-tools: Read, Bash, Glob, Grep, Task
description: Analyze the project and provide a concise onboarding introduction to help get started quickly.
---

Analyze the project and provide a concise onboarding introduction to help get started quickly.

## Task Planning

Use the TodoWrite tool to track onboarding steps:

1. VCS and build system detection
1. Project structure analysis
1. Tech stack identification
1. Documentation review
1. Command discovery
1. Generate onboarding summary

Mark tasks as in_progress/completed as you work.

## Exploration Strategy

**Use Task tool with subagent_type=Explore for:**

- Understanding overall codebase structure
- Finding entry points and key files across the project
- Identifying architectural patterns and conventions
- Understanding how different components interact

**Use direct tools (Read, Glob, Grep, Bash) for:**

- Reading specific known files (README.md, package.json, etc.)
- Checking for specific file existence (flake.nix, .jj/, etc.)
- Running specific detection commands

## Analysis Steps

Examine the project systematically:

1. **Version control detection**:

First, detect the VCS:

```bash
test -d .jj && echo "jujutsu" || (test -d .git && echo "git" || echo "none")
```

**Note:** Jujutsu is preferred and will usually be detected.

2. **Build system detection**:

Check in priority order:

```bash
if [ -f flake.nix ]; then
  echo "nix"
elif [ -f justfile ] || [ -f Justfile ]; then
  echo "just"
else
  echo "language-specific"
fi
```

Also check for: `package.json`, `Cargo.toml`, `pyproject.toml`, `go.mod`, `Makefile`

**Priority:** Nix > Just > Language-specific

When both Nix and Just exist, prefer Nix commands (Just may wrap Nix for convenience).

3. **Project structure**:

- List top-level directories
- Identify entry points (`main.*`, `src/`, `lib/`, etc.)
- Check for `README.md`, `CONTRIBUTING.md`, `LICENSE`

Consider using Task/Explore agent to understand the overall structure.

4. **Tech stack**:

- Language(s) and frameworks
- Runtime/interpreter versions
- Key dependencies

5. **Common commands**:

Discover commands based on detected build system:

**Nix:**

- Build: `nix build`
- Format: `nix fmt`
- Check: `nix flake check`
- Update: `nix flake update`
- Run: Check flake outputs with `nix flake show`

**Just:**

- List tasks: `just --list`
- Follow task naming conventions

**Language-specific:**

- npm/pnpm/yarn: `npm install`, `npm test`, `npm run dev`
- cargo: `cargo build`, `cargo test`, `cargo run`
- go: `go build`, `go test`, `go run`
- Check README/CONTRIBUTING for preferred commands

6. **Documentation**:

- Check for existing documentation locations
- Look for quick start sections
- Check CONTRIBUTING.md for development workflows

## Output Format

Provide a structured overview:

```md
# Project: [Name]

## Overview
[2-3 sentence description of what the project does]

## Tech Stack
- **Language(s)**: [primary languages]
- **Build System**: [nix/just/npm/cargo/etc.]
- **VCS**: [jujutsu/git]
- **Key Technologies**: [frameworks, major dependencies]

## Project Structure
[tree-like structure of main directories]

## Getting Started

### Prerequisites
[Required tools/versions]

### Setup
[installation/setup commands in code blocks]

### Common Commands

Based on detected build system, provide relevant commands:

**Nix:**
- `nix build` - Build the project
- `nix fmt` - Format code
- `nix flake check` - Run checks and tests

**Just:**
- `just --list` - List all available tasks
- `just [task]` - Run specific task

**Language-specific:**
- [Appropriate commands for the detected language/framework]

## Key Entry Points
- [main files or modules to start reading]

## Documentation
- [links to README, docs, or other resources]

## Next Steps
[2-3 actionable suggestions for what to do next]
```

## Guidelines

- Keep output minimal and concise (aim for \<30 lines)
- Focus on actionable information
- Prioritize what someone needs to start contributing
- Skip obvious/standard information
- Highlight unusual or project-specific conventions
- Tailor depth to project complexity (simple projects get simpler onboarding)
- Use the detected VCS and build system in examples
- Prefer jujutsu commands over git when detected
- Prefer Nix commands over Just when both exist
