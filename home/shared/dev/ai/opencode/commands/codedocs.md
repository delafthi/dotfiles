---
description: document code
agent: build
subtask: true
template: Add or update documentation to all functions, class, and modules in the provided files or current changes.
---

Add or update documentation to all functions, class, and modules in the files $ARGUMENTS or the current changes.

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
