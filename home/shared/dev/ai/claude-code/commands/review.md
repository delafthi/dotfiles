---
allowed-tools: Read, Glob, Grep, Bash, Task
description: Provide a structured code review for the provided files or current changes.
---

Provide a structured code review for the files $ARGUMENTS or the current changes.

## Task Planning

Use the TodoWrite tool to track review steps:

1. Identify files to review
1. Understand project context and conventions
1. Analyze each file for issues
1. Generate structured review output
1. Provide actionable recommendations

Mark tasks as in_progress/completed as you work.

## Exploration Strategy

**Use Task tool with subagent_type=Explore for:**

- Finding similar files to understand patterns
- Understanding how reviewed code fits in the architecture
- Identifying all usage of reviewed code
- Understanding the broader context

**Use direct tools (Read, Grep, Glob) for:**

- Reading the specific files being reviewed
- Checking for linting/formatting configs
- Reading style guides or review guidelines

## Project Context

First, understand the project context:

- Review similar files to understand existing patterns and conventions
- Check for linting/formatting configs (e.g., `.eslintrc`, `pyproject.toml`, `rustfmt.toml`)
- Identify the project's tech stack and frameworks
- Check if there are existing code review guidelines or style guides

Consider using Task/Explore agent to understand the architectural context.

## Review Categories

Analyze in priority order:

1. **Security**: Vulnerabilities, exposed secrets, injection risks, unsafe operations
1. **Correctness**: Logic errors, edge cases, potential bugs, race conditions
1. **Performance**: Inefficient algorithms, memory leaks, unnecessary operations
1. **Maintainability**: Code complexity, readability, modularity, naming
1. **Best Practices**: Language idioms, framework patterns, error handling
1. **Testing**: Missing tests, inadequate coverage, test quality
1. **Documentation**: Missing/outdated docs, unclear APIs
1. **Style**: Consistency with project conventions (only if not caught by automated tools)

## Issue Structure

For each issue found, include:

1. **Severity**: CRITICAL | HIGH | MEDIUM | LOW | SUGGESTION
1. **Category**: From list above
1. **Location**: `file:line` or `file:startLine-endLine`
1. **Description**: Clear, specific explanation
1. **Impact**: Why this matters
1. **Fix**: Concrete, actionable suggestion with code example if applicable

## Output Format

```
## Summary
- Total issues: X (Critical: X, High: X, Medium: X, Low: X, Suggestions: X)
- Primary concerns: [brief overview]

## Issues

### [SEVERITY] [Category] - [Brief title]
**Location**: `path/to/file:line`
**Description**: [What's wrong]
**Impact**: [Why it matters]
**Suggested Fix**:
[Concrete suggestion with code example if needed]

---
```

## Version Control Context

If reviewing current changes, detect the VCS:

```bash
test -d .jj && echo "jujutsu" || (test -d .git && echo "git" || echo "none")
```

**Jujutsu:**
Check current changes:

```bash
jj status
jj diff
```

**Git:**
Check current changes:

```bash
git status
git diff
git diff --staged
```

## Guidelines

- Focus on actionable feedback
- Prioritize correctness and security over style
- Avoid nitpicking issues already handled by automated tools
- Be objective and constructive
- Provide context for suggestions
- Only flag style issues if they significantly impact readability or differ from project norms
- Keep review output minimal and concise
- Reference code locations as `file:line` format for easy navigation
- Don't over-engineer reviews with excessive detail
- Avoid comments on obvious or already well-handled aspects
