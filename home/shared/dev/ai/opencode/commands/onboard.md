---
description: onboard to a project
agent: investigate
subtask: false
template: Analyze the project and provide a concise onboarding introduction to help get started quickly.
---

Analyze the project and provide a concise onboarding introduction to help get started quickly.

## Analysis Steps

Examine the project systematically:

1. **Build system detection**:

- Check for `flake.nix`, `justfile`, `package.json`, `Cargo.toml`, `pyproject.toml`, `go.mod`, `Makefile`
- Identify primary and secondary build tools

2. **Version control**:

- Check for `.jj/` (jujutsu) or `.git/` (git)

3. **Project structure**:

- List top-level directories
- Identify entry points (`main.*`, `src/`, `lib/`, etc.)
- Check for `README.md`, `CONTRIBUTING.md`, `AGENTS.md`, `LICENSE`

4. **Tech stack**:

- Language(s) and frameworks
- Runtime/interpreter versions
- Key dependencies

5. **Common commands**:

- Build/compile
- Run/serve
- Test
- Format/lint
- Install/setup

6. **Documentation**:

- Existing docs locations
- Quick start sections

## Output Format

Provide a structured overview:

```
# Project: [Name]

## Overview
[2-3 sentence description of what the project does]

## Tech Stack
- **Language(s)**: [primary languages]
- **Build System**: [nix/just/npm/cargo/etc.]
- **VCS**: [jujutsu/git]
- **Key Technologies**: [frameworks, major dependencies]

## Project Structure
```

[tree-like structure of main directories]

````

## Getting Started

### Prerequisites
[Required tools/versions]

### Setup
```bash
[installation/setup commands]
````

### Common Commands

```bash
[build command]     # Build the project
[test command]      # Run tests
[format command]    # Format code
[run command]       # Run/serve (if applicable)
```

## Key Entry Points

- [main files or modules to start reading]

## Documentation

- [links to README, docs, or other resources]

## Next Steps

[2-3 actionable suggestions for what to do next]

```

## Guidelines
- Keep it concise (aim for <30 lines of output)
- Focus on actionable information
- Prioritize what someone needs to start contributing
- Skip obvious/standard information
- Highlight unusual or project-specific conventions
- If `AGENTS.md` exists, incorporate its guidelines
- Tailor depth to project complexity (simple projects get simpler onboarding)
```
