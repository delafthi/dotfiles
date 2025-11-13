# Agent Guidelines for delafthi's Dotfiles

## Build/Lint/Test Commands

- **Format code**: `just fmt` or `nix fmt`
- **Check flake validity**: `just check` or `nix flake check`
- **Update dependencies**: `just update` or `nix flake update`
- **Apply system config**: `just apply` (auto-detects platform/hostname)
- **Single test**: No specific test framework; use `just check` for validation

## Code Style Guidelines

### Formatting

- **Indentation**: 2 spaces (except Makefiles/Justfiles: tabs)
- **Line endings**: LF (Unix)
- **Encoding**: UTF-8
- **Final newline**: Required
- **Trim trailing whitespace**: Yes

### Nix-Specific

- **Formatter**: nixfmt-rfc-style (via treefmt)
- **Import sorting**: keep-sorted for attributes and imports (use `# keep-sorted start/end` comments)

<!-- keep-sorted end -->

- **Keep-sorted**: Automatically maintains sorted lists; wrap sections with `# keep-sorted start` and `# keep-sorted end`

<!-- keep-sorted end -->

- **Dead code detection**: deadnix enabled
- **Static analysis**: statix enabled
- **Modular structure**: Separate platform-specific (`darwin/`, `linux/`) and `shared/` configs
- **Attribute order**: `enable`, `package`, config options, then `extraPackages`/`extraConfig`
- **Function parameters**: Use destructured sets, avoid `with pkgs;` in function signatures

### File Organization

- `hosts/` - Host-specific configurations
- `home/` - Home-manager modules (darwin/linux/shared)
- `modules/` - Custom Nix modules
- `overlays/` - Package overlays
- `pkgs/` - Custom packages
- `system/` - System-level configurations

### Additional Formatters

- **Shell scripts**: shellcheck + shfmt
- **Fish**: fish_indent
- **GitHub Actions**: actionlint
- **JSON/TypeScript**: biome (indentStyle: space)
- **YAML**: yamlfmt
- **Markdown**: mdformat
- **Justfiles**: just
- **EditorConfig**: editorconfig-checker (priority: 9)

### Best Practices

- Use flake-parts for modular flake organization
- Follow NixOS wiki conventions for `stateVersion`
- Keep flake inputs sorted with keep-sorted comments
- Use descriptive variable names (e.g., `host`, `user`, `ssh-keys`)
- Prefer `imports = [ ]` pattern for modular organization
- Use `mkDerivation` with explicit `meta.mainProgram` for custom packages
- Test configurations on target systems before committing
- NEVER add comments to code unless explicitly requested

## Version Control System

**This repository uses Jujutsu (`.jj/` present).**

### Detection Method

Check for VCS-specific directories in the repository root:

- **Jujutsu**: `.jj/` directory present → use `jj` commands
- **Git**: `.git/` directory present → use `git` commands (default)

### Usage Rules

- If `.jj/` is detected, use jujutsu commands for ALL version control operations:
  - Status: `jj status` (not `git status`)
  - Diff: `jj diff` (not `git diff`)
  - Create change: `jj new` (not `git commit`)
  - Describe change: `jj describe -m "message"` (not `git commit -m`)
  - Branches: `jj branch` (not `git branch`)
  - Log: `jj log` (not `git log`)
- If only `.git/` is present, use standard git commands
- NEVER mix git and jujutsu commands in the same repository
- When in doubt, check for `.jj/` first: `test -d .jj && echo "jujutsu" || echo "git"`

## Build System Detection

Detect the build system and tooling used by the project before running build, format, or check operations.

### Detection Method

Check for build system files in the repository root (in priority order):

1. **Nix Flakes**: `flake.nix` present
1. **Just**: `justfile` or `Justfile` present
1. **Language-specific**: `package.json`, `Cargo.toml`, `pyproject.toml`, `go.mod`, `Makefile`, etc.

### Priority Rules

When multiple build systems are detected, use the following priority:

1. **Nix takes precedence**: If `flake.nix` exists, prefer Nix commands:

- Format: `nix fmt` (not `just fmt`)
- Check/Lint: `nix flake check` (not `just check`)
- Build: `nix build` (not `just build`)
- Update: `nix flake update` (not `just update`)

2. **Just as secondary**: If `justfile` exists but no `flake.nix`:

- Use `just <command>` for available tasks
- Check available tasks: `just --list`

3. **Language-specific tools**: If neither Nix nor Just are present:

- Use project-specific tools (npm, cargo, go, make, etc.)
- Always check project documentation for preferred commands

### Detection Command

```bash
if [ -f flake.nix ]; then
  echo "nix"
elif [ -f justfile ] || [ -f Justfile ]; then
  echo "just"
else
  echo "language-specific"
fi
```

### Best Practices

- Always detect build system before running operations
- Respect the project's chosen tooling hierarchy
- When `flake.nix` and `justfile` coexist, use Nix commands but be aware that `just` commands may wrap Nix for convenience
- Never assume a build system without verification
