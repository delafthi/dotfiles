---
description: create commit
agent: vcs
subtask: false
template: Commit the current changes.
---

Commit the current changes. $ARGUMENTS

## Analysis

First, analyze recent commits to understand the project's commit style:
!`jj log -l 20`

Follow the project's existing commit conventions if they are clearly established.
If no clear pattern exists or the project uses varied styles, default to the
Conventional Commits Specification (preferred).

Check current changes:
!`jj diff`

## Format

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

## Subject Line Requirements

- Format: `<type>[optional (<scope>)]: <description>`
- Imperative mood, lowercase, no period
- Maximum 100 characters
- English only

## Body Requirements

- Bullet points with "-"
- Maximum 100 characters per line
- Explain WHY changes were made, not WHAT changed
- Be objective
- English only

## Footer Requirements

- Format: `<token>: <value>`
- Maximum 100 characters per line
- Use GitHub CLI to fetch issue information if needed
- Only reference issues if directly related
- Types: `BREAKING CHANGE:`, `Fixes #`, `Closes #`, `Resolves #`, `Related to #`

## General Requirements

- Wrap all paths, commands, or environment variables in backticks
- Output only the commit message with no formatting markers or explanations
