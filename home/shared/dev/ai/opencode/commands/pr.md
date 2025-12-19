---
description: create pull request
agent: vcs
subtask: false
template: Create a pull request from the current branch.
---

Create a pull request from the current branch. $ARGUMENTS

**Note:** Backticks do not need to be escaped in PR descriptions or when using this template.

## Branch Analysis

First, verify the current bookmark and recent commits:
!`jj bookmark list`
!`jj log -l 10`

Check if there are any uncommitted changes:
!`jj status`

## Branch Creation

Before creating a PR, ensure you have a bookmark pointing to your changes.

Check if the current change has a bookmark:
!`jj log -r @`

If no bookmark exists, create one:

```bash
jj bookmark create <bookmark-name>
```

Bookmark naming conventions:

- Use descriptive names: `feat/add-auth`, `fix/memory-leak`, `docs/update-readme`
- Follow project conventions if established
- Use lowercase with hyphens or slashes
- Keep concise but meaningful

If you need to move an existing bookmark to the current change:

```bash
jj bookmark set <bookmark-name>
```

## Remote Status

Verify the bookmark is pushed to remote:
!`jj bookmark list | grep "@"`

If the bookmark is not pushed to remote, push with:

```bash
jj git push
```

## Existing PR Check

Check if a PR already exists for the current branch:
!`gh pr list --head $(jj bookmark list | grep '@$' | awk '{print $1}' | head -1)`

If a PR exists:

- Update the PR title and description to reflect current/recent changes
- Use `gh pr edit <number> --title "new title" --body "new description"`
- Analyze all commits since the PR was created to generate an accurate description
- Ensure the description captures the full scope of current changes

If no PR exists, proceed with creation below.

## PR Template Detection

Check for PR templates in common locations:
!`find .github -name "*pull_request_template*" -o -name "*PULL_REQUEST_TEMPLATE*" 2>/dev/null || echo "No PR template found"`

If a template exists, use it as the base for the PR description.

## PR Creation

Use GitHub CLI to create the PR:

- If PR template exists, incorporate its structure

- Generate a concise title based on the commits

- Write a clear description explaining the changes

- Description format:

  **Default (small to medium changes):**

  - Keep minimal and concise without headings
  - Brief paragraph explaining the changes and motivation
  - Example: "Refactors the authentication module to use async/await for better error handling and readability."

  **Large/complex changes only:**

  - Use headings and structured sections when changes are extensive
  - Include sections like "## Summary", "## Changes", "## Testing" only when necessary for clarity
  - Example criteria: multiple features, significant refactoring, breaking changes, or cross-cutting concerns

Create the PR with:

```bash
gh pr create --title "title" --body "description"
```

## Requirements

- Title: Concise, imperative mood, \<100 characters
- Description:
  - Default to minimal format without headings
  - Clear explanation of WHY (not just WHAT)
  - Only use headings/elaborate structure for big or complex changes
- Reference related issues if applicable
- Follow project's existing PR conventions if evident from recent PRs
- English only
