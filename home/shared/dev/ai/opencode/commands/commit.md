---
description: create commit
agent: vcs
subtask: false
template: Commit the current changes.
---

Commit the current changes. $ARGUMENTS

## Existing Description Check

Check if the current change already has a description:
!`jj status`

If the working copy shows an existing description (not "(no description set)"):

- Update the existing description to reflect current/recent changes
- Use `jj describe -m "updated message"` to modify the description
- Analyze all changes since the description was first set
- Ensure the updated description captures the full scope of current changes

If no description exists, proceed with creating one below.

## Analysis

First, analyze recent commits to understand the project's commit style:
!`jj log --limit 20`

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

- For multiple/complex changes: use bullet points with "-"
- For single/simple changes: use prose to describe why the change was necessary
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
