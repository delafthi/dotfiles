---
allowed-tools: Read, Glob, Grep, Edit
description: Add or update documentation to all functions, class, and modules in the provided files or current changes.
---

Add or update documentation to all functions, class, and modules in the files $ARGUMENTS or the current changes.

## Task Planning

Use the TodoWrite tool to track documentation steps:

1. Identify files to document
1. Analyze existing documentation patterns
1. Document each public API in each file
1. Verify documentation completeness

Mark tasks as in_progress/completed as you work.

**Important:** Always use Read tool before Edit tool (Claude Code requirement).

## Analysis

First, analyze existing documentation patterns in the project:

- Examine similar files for documentation style and conventions
- Check for documentation style guides or linting configs (e.g., `.pydocstyle`, JSDoc config)

## Documentation Styles

Follow the project's existing documentation style if clearly established.
If no clear pattern exists, use language-specific conventions:

- Python: Google style (preferred) or NumPy style
- JavaScript/TypeScript: JSDoc
- Rust: Rustdoc
- Go: Godoc
- Java: Javadoc
- Other languages: language-specific best practices

## Requirements

- Document all public APIs (functions, classes, modules, methods)
- Include: purpose, parameters, return values, exceptions/errors, examples (if complex)
- Add inline comments ONLY for non-obvious logic or complex algorithms
- Avoid redundant comments that simply restate the code
- Preserve original code structure and formatting
- Use clear, concise language
- Keep documentation up-to-date with code changes
- Keep documentation minimal and concise

## Exclusions

Do NOT document:

- Self-explanatory private helper functions
- Trivial getters/setters
- Auto-generated code
