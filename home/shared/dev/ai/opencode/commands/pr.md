---
description: create pull request
agent: vcs
subtask: false
template: Create a pull request from the current branch.
---

Create a pull request from the current branch. $ARGUMENTS

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

- Use the format:

  ```
  [Brief overview of changes]

  [Additional sections from template if present]
  ```

Create the PR with:

```bash
gh pr create --title "title" --body "description"
```

## Requirements

- Title: Concise, imperative mood, \<100 characters
- Description: Clear explanation of WHY (not just WHAT)
- Reference related issues if applicable
- Follow project's existing PR conventions if evident from recent PRs
- English only
- Keep PR description minimal and concise
