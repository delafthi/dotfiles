---
allowed-tools: Bash, Read, Glob, Grep
description: Create a pull request from the current branch.
---

Create a pull request from the current branch. $ARGUMENTS

**Note:** Backticks do not need to be escaped in PR descriptions or when using this template.

## Version Control Detection

First, detect the version control system:

```bash
test -d .jj && echo "jujutsu" || (test -d .git && echo "git" || echo "none")
```

Use the appropriate commands based on the detected VCS throughout this process.

## Branch Analysis

**CRITICAL**: Analyze ALL commits in the branch since it diverged from the base branch. The PR description must reflect the complete scope of changes, not just the most recent commit.

### For Jujutsu:

Verify the current bookmark and recent commits:

```bash
jj bookmark list
```

Show all commits in the current bookmark since it diverged from main:

```bash
jj log -r 'main..' --limit 50
```

If the above fails or main doesn't exist, try:

```bash
jj log --limit 20
```

For stacked PRs, find the base bookmark and show commits since that point:

```bash
jj log -r '<base-bookmark>..' --limit 50
```

### For Git:

Verify the current branch:

```bash
git branch --show-current
```

Show all commits since diverging from main:

```bash
git log main..HEAD --oneline -50
```

For stacked branches, use the parent branch as base:

```bash
git log <parent-branch>..HEAD --oneline -50
```

Get detailed information about all commits:

```bash
git log main..HEAD --pretty=format:"%h %s%n%b" -50
```

Check for uncommitted changes:

```bash
git status
```

## Branch Creation

### For Jujutsu:

Before creating a PR, ensure you have a bookmark pointing to your changes.

Check if the current change has a bookmark:

```bash
jj log -r @ --limit 1
```

If no bookmark exists, create one:

```bash
jj bookmark create <bookmark-name>
```

Bookmark naming conventions:

- Use descriptive names: `feature/add-auth`, `fix/memory-leak`, `docs/update-readme`
- Follow project conventions if established
- Use lowercase with hyphens or slashes
- Keep concise but meaningful

If you need to move an existing bookmark to the current change:

```bash
jj bookmark set <bookmark-name>
```

### For Git:

Check the current branch:

```bash
git branch --show-current
```

If you need to create a new branch:

```bash
git checkout -b <branch-name>
```

Follow the same naming conventions as described above.

## Remote Status

### For Jujutsu:

Verify the bookmark is pushed to remote:

```bash
jj bookmark list
```

Look for bookmarks with `@origin` suffix indicating they're tracked remotely.

If the bookmark is not pushed to remote, push with:

```bash
jj git push
```

### For Git:

Check if the branch is pushed:

```bash
git status
```

If not pushed, push with:

```bash
git push -u origin <branch-name>
```

## Existing PR Check

Get the current branch/bookmark name based on VCS:

**Jujutsu:**

```bash
jj bookmark list | grep -E '^\S+:.*@'
```

**Git:**

```bash
git branch --show-current
```

Then check if a PR already exists for the current branch:

```bash
gh pr list --head <branch-or-bookmark-name>
```

If a PR exists:

- Analyze ALL commits in the branch (not just commits since PR creation)
- Update the PR title and description to reflect the complete scope of changes
- Use `gh pr edit <number> --title "new title" --body "new description"`
- The updated description must capture ALL changes in the branch, from the first commit to the most recent
- Don't just describe what changed recently - describe what the entire PR accomplishes

If no PR exists, proceed with creation below.

## Contribution Guidelines Check

Check for contribution guidelines before creating the PR:

```bash
for file in CONTRIBUTING.md CONTRIBUTING .github/CONTRIBUTING.md docs/CONTRIBUTING.md CONTRIBUTE.md; do
  test -f "$file" && echo "Found: $file" && cat "$file" && break
done
```

Follow any PR conventions, templates, or requirements found in the contribution guidelines.

## PR Template Detection

Check for PR templates in common locations:

```bash
find .github -name "*pull_request_template*" -o -name "*PULL_REQUEST_TEMPLATE*" 2>/dev/null || echo "No PR template found"
```

If a template exists, use it as the base for the PR description.

## Task Planning

Use the TodoWrite tool to track PR creation steps:

1. VCS detection
1. Branch/bookmark status checks
1. Full commit history analysis (ALL commits since base branch)
1. PR template detection
1. PR creation or update with comprehensive description
1. Verification

Mark tasks as in_progress/completed as you work through them.

## PR Creation

**Before writing the PR description:**

1. Review ALL commits in the branch from the Branch Analysis section above
1. Read the full commit messages and bodies (not just summaries)
1. Understand the complete scope of changes across all commits
1. Ensure the description captures the cumulative effect of all changes

**Creating the PR:**

Use GitHub CLI to create the PR:

- If PR template exists, incorporate its structure
- Generate a concise title that reflects the overall goal of ALL commits
- Write a clear description that summarizes ALL changes in the branch, not just the most recent commit

Description format:

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

For jujutsu, ensure you specify the correct bookmark:

```bash
gh pr create --head <bookmark-name> --title "title" --body "description"
```

## Requirements

- Title: Concise, imperative mood, \<100 characters, reflecting the overall goal of ALL commits
- Description:
  - **Must summarize ALL commits in the branch**, not just the most recent changes
  - Default to minimal format without headings for small/medium changes
  - Clear explanation of WHY (not just WHAT) across all changes
  - Only use headings/elaborate structure for big or complex changes
  - Should capture the cumulative effect and complete scope of the branch
- Reference related issues if applicable
- Follow project's existing PR conventions if evident from recent PRs
- English only

## Error Handling

If commands fail:

1. Verify VCS detection was correct
1. Check that gh CLI is installed and authenticated
1. Ensure bookmark/branch exists and is pushed to remote
1. For jujutsu, verify bookmark name doesn't contain invalid characters
1. If GPG signing fails with timeout error, simply retry the push command (user needs to touch Yubikey for signing)
1. Ask user for clarification if errors persist
