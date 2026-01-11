---
allowed-tools: Bash, Read, Glob, Grep
description: Commit the current changes.
---

Commit the current changes. $ARGUMENTS

## Version Control Detection

First, detect the version control system:

```bash
test -d .jj && echo "jujutsu" || (test -d .git && echo "git" || echo "none")
```

**Note:** Jujutsu is preferred and will be the primary VCS in most cases.

## Task Planning

Use the TodoWrite tool to track commit steps:

1. VCS detection
1. Check existing description (jujutsu) or staged changes (git)
1. Analyze commit history for conventions
1. Review current changes
1. Check contribution guidelines
1. Create/update commit message
1. Verify commit success

Mark tasks as in_progress/completed as you work through them.

## Existing Description Check (Jujutsu)

For jujutsu repositories, check if the current change already has a description:

```bash
jj status
```

If the working copy shows an existing description (not "(no description set)"):

- Update the existing description to reflect current/recent changes
- Use `jj describe -m "updated message"` to modify the description
- Analyze all changes since the description was first set
- Ensure the updated description captures the full scope of current changes

If no description exists, proceed with creating one below.

## Contribution Guidelines Check

Check for contribution guidelines before creating the commit:

```bash
for file in CONTRIBUTING.md CONTRIBUTING .github/CONTRIBUTING.md docs/CONTRIBUTING.md CONTRIBUTE.md; do
  test -f "$file" && echo "Found: $file" && cat "$file" && break
done
```

Follow any commit message formats and conventions found in the contribution guidelines.

## Analysis

First, analyze recent commits to understand the project's commit style:

**Jujutsu:**

```bash
jj log --limit 20
```

**Git:**

```bash
git log --oneline -20
```

Follow the project's existing commit conventions if they are clearly established.
If no clear pattern exists or the project uses varied styles, default to the
Conventional Commits Specification (preferred).

Check current changes:

**Jujutsu:**

```bash
jj diff
```

**Git:**

```bash
git diff
git diff --staged
```

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
- Backticks must be escaped (\`) when used on the command line in jujutsu describe commands
- Keep commit messages minimal and concise

## Committing

**Jujutsu:**

For new description:

```bash
jj describe -m "$(cat <<'EOF'
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
EOF
)"
```

For updating existing description:

```bash
jj describe -m "$(cat <<'EOF'
<updated message>
EOF
)"
```

**Git:**

Stage changes if needed:

```bash
git add <files>
```

Create commit:

```bash
git commit -m "$(cat <<'EOF'
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
EOF
)"
```

## Verification

After committing, verify success:

**Jujutsu:**

```bash
jj status
jj log -r @ --limit 1
```

**Git:**

```bash
git status
git log -1
```

## Error Handling

If commands fail:

1. Verify VCS detection was correct
1. Check for syntax errors in commit message
1. Ensure backticks are properly escaped in command line
1. For jujutsu, verify there are changes to describe
1. For git, ensure files are staged
1. Ask user for clarification if errors persist
