---
description: review code
agent: review
subtask: false
template: Provide a structured code review for the provided files or current changes.
---

Provide a structured code review for the files $ARGUMENTS or the current changes.

## Project Context

First, understand the project context:

- Review similar files to understand existing patterns and conventions
- Check for linting/formatting configs (e.g., `.eslintrc`, `pyproject.toml`, `rustfmt.toml`)
- Identify the project's tech stack and frameworks
- Check if there are existing code review guidelines or style guides

## Review Categories

Analyze in priority order:

1. **Security**: Vulnerabilities, exposed secrets, injection risks, unsafe operations
2. **Correctness**: Logic errors, edge cases, potential bugs, race conditions
3. **Performance**: Inefficient algorithms, memory leaks, unnecessary operations
4. **Maintainability**: Code complexity, readability, modularity, naming
5. **Best Practices**: Language idioms, framework patterns, error handling
6. **Testing**: Missing tests, inadequate coverage, test quality
7. **Documentation**: Missing/outdated docs, unclear APIs
8. **Style**: Consistency with project conventions (only if not caught by automated tools)

## Issue Structure

For each issue found, include:

1. **Severity**: CRITICAL | HIGH | MEDIUM | LOW | SUGGESTION
2. **Category**: From list above
3. **Location**: `file:line` or `file:startLine-endLine`
4. **Description**: Clear, specific explanation
5. **Impact**: Why this matters
6. **Fix**: Concrete, actionable suggestion with code example if applicable

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

## Guidelines

- Focus on actionable feedback
- Prioritize correctness and security over style
- Avoid nitpicking issues already handled by automated tools
- Be objective and constructive
- Provide context for suggestions
- Only flag style issues if they significantly impact readability or differ from project norms
