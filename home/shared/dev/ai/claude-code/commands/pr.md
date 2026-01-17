---
allowed-tools: Task
description: Create a pull request from the current branch.
---

Create a pull request from the current branch. $ARGUMENTS

Spawn the VCS agent (blocking) to handle PR creation. The agent will:

1. Detect VCS (jujutsu or git)
1. Get branch/bookmark status and analyze ALL commits since base
1. Check for existing PR with gh pr list
1. Check contribution guidelines and PR templates
1. Ensure branch/bookmark is pushed to remote
1. Create or update PR with comprehensive description

## PR Requirements

**Title**: Concise, imperative mood, \<100 characters, reflecting overall goal of ALL commits

**Description**:

- Must summarize ALL commits in branch (not just recent changes)
- Default to minimal format without headings for small/medium changes
- Use structured format only for large/complex changes
- Explain WHY, not just WHAT
- Follow PR template if present

**If PR exists**: Update with gh pr edit, capturing complete scope from first to latest commit

**Error handling**: For GPG timeout, retry push (user must touch Yubikey)
