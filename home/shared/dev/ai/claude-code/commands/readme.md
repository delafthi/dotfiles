---
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
description: Generate or improve the project's README.md.
---

Generate or improve the project's README.md.

## Task Planning

Use the TodoWrite tool to track README steps:

1. Check if README exists
1. Detect build system and VCS
1. Analyze project structure
1. Determine what needs to be added/improved
1. Generate or update README
1. Verify accuracy of commands

Mark tasks as in_progress/completed as you work.

## Analysis

First, analyze the project:

- Check if a README.md already exists:

```bash
test -f README.md && echo "exists" || echo "not found"
```

- Detect VCS:

```bash
test -d .jj && echo "jujutsu" || (test -d .git && echo "git" || echo "none")
```

- Detect build system:

```bash
if [ -f flake.nix ]; then
  echo "nix"
elif [ -f justfile ] || [ -f Justfile ]; then
  echo "just"
else
  echo "language-specific"
fi
```

- Examine the codebase structure and entry points
- Check `package.json`, `pyproject.toml`, `Cargo.toml`, or similar for project metadata
- Review existing documentation files
- Identify the target audience (developers, end-users, contributors)
- Identify the project's tech stack and dependencies

## Approach

### If README exists:

- Preserve the existing structure and tone that works well
- Identify and fix issues:
  - Outdated information
  - Broken links or commands
  - Missing critical sections
  - Unclear or incomplete instructions
  - Inaccurate examples
- Enhance weak sections with better examples, clarity, or detail
- Add missing sections that are relevant to the project
- Remove obsolete content
- Maintain consistency with the project's current state

### If README does not exist:

- Create a comprehensive README following the structure below

## README Structure

Use clear sections with descriptive headings. Include only applicable sections:

### Required Sections

1. **Project Title & Description**

- Clear, concise project name
- Brief overview (1-3 sentences)
- Key features/highlights (bullet points)
- Project status/maturity (optional: badges for build, version, license)

2. **Installation**

- Prerequisites (OS, runtime versions, dependencies)
- Step-by-step installation commands
- Platform-specific instructions if needed
- Verification steps

3. **Usage**

- Basic usage examples with code snippets
- Common use cases
- CLI commands or API examples
- Screenshots/demos if applicable

### Optional Sections (include if relevant)

4. **Getting Started** (for complex projects)

- Quick start guide
- Minimal working example

5. **Configuration**

- Environment variables
- Config file formats
- Available options

6. **Development**

- Setting up development environment
- Build instructions
- Running tests
- Code style/linting

7. **Contributing**

- How to contribute
- Code of conduct reference
- Development workflow
- Pull request process

8. **Documentation**

- Link to full documentation
- API reference
- Architecture overview

9. **License**

- License type
- Link to LICENSE file

10. **Credits/Acknowledgments**

- Authors/maintainers
- Contributors
  - Third-party resources

11. **Support/Contact**
    - Issue tracker
    - Discussion forums
    - Contact information

## Style Guidelines

- Use clear, concise language
- Write for your target audience
- Use code blocks with language tags for syntax highlighting
- Keep line length reasonable (wrap at ~80-100 chars for readability)
- Use relative links for internal documentation
- Include a table of contents for long READMEs (>500 lines)
- Use consistent heading levels (# for title, ## for main sections, ### for subsections)
- Keep README content minimal and concise

## Quality Requirements

- Ensure all commands are tested and accurate
- Use realistic, working examples
- Keep installation steps minimal and clear
- Avoid marketing language; be factual
- Update outdated information if improving existing README
- Include troubleshooting section if common issues exist
- Use the detected build system in command examples (prefer Nix over Just)
- Use the detected VCS in contribution examples (prefer jujutsu)

## Exclusions

Do NOT include:

- Overly promotional language
- Placeholder text (e.g., "Coming soon", "TODO")
- Irrelevant badges or excessive badge clutter
- Installation steps for common tools (e.g., don't explain how to install git)
- Personal opinions or biases
