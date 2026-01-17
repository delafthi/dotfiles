---
allowed-tools: Task
description: Analyze the project and provide a concise onboarding introduction to help get started quickly.
---

Spawn the Explore agent (background) to analyze the project structure, tech stack, build system, VCS, and common commands.

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

Keep output minimal and concise (aim for \<30 lines). Focus on actionable information and highlight unusual or project-specific conventions. Tailor depth to project complexity.
