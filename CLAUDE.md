# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

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

- `hosts/` - Host-specific configurations (darwin/nixos subdirectories)
- `home/` - Home-manager modules organized by platform (darwin/linux/shared)
- `modules/` - Custom Nix modules (nix-darwin, nixos, home)
- `overlays/` - Package overlays
- `pkgs/` - Custom packages
- `system/` - System-level configurations
- `nix/` - Build system configuration (treefmt.nix)

### Home-Manager Module Structure

The `home/` directory uses a three-tier architecture:

1. **Platform-specific**: `home/darwin/` and `home/linux/` for platform-specific configurations
1. **Shared**: `home/shared/` for cross-platform configurations
1. **Category-based organization**: Each tier is organized by category:

- `apps/` - Application configurations (e.g., `apps/coms/` for communication apps)
- `dev/` - Development tools (shells, VCS, languages, CLI tools, AI tools)
- `security/` - Security-related configurations (gpg, ssh, sops, password-store)
- `ui/` - UI/UX configurations (fonts, theming)
- `settings/` - Platform-specific system settings (macOS defaults, Linux systemd services)

Host configurations import the appropriate platform and shared modules:

```nix
imports = [
  ../../../home/darwin
  ../../../home/shared
];
```

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

## Architecture and Special Patterns

### Flake Structure

The flake uses flake-parts for modular organization with the following key components:

- **Inputs**: All flake inputs use `nixpkgs.follows` to ensure consistent versions (catppuccin, darwin, home-manager, sops-nix, iamb, llm-agents, zen-browser)
- **Overlays**: Custom overlays are defined in `overlays/` and applied to both system and per-system nixpkgs
- **Special args**: Configurations receive `user`, `host`, and `ssh-keys` as special args throughout the module system
- **perSystem**: Used for per-system outputs (packages, devShells, treefmt configuration)
- **Supported systems**: aarch64-linux, x86_64-linux, aarch64-darwin

### Adding a New Host

When adding a new host configuration:

1. Create directory under `hosts/darwin/` or `hosts/nixos/`
1. Add `configuration.nix` (system config) and `home.nix` (home-manager config)
1. In `flake.nix`, define the host with required special args:

- `host` - hostname (e.g., "Thierrys-MacBook-Air")
- `user` - username (e.g., "delafthi")
- `ssh-keys` - list of authorized SSH keys
- `system` - platform (e.g., "aarch64-darwin")

4. Add to `darwinConfigurations` or `nixosConfigurations` using the mergeAttrSets pattern

### Secrets Management

This repository uses sops-nix with age encryption:

- **Age keys**: Configured in `.sops.yaml` (currently uses Yubikey and a standard age key)
- **Secrets file**: `secrets.yaml` (encrypted)
- **Access in configs**: Reference via `config.sops.secrets.*`
- **Development**: Use `sops secrets.yaml` to edit encrypted files
- **Key location**: Age keys stored in `~/.config/sops/age/keys.txt` or via age-plugin-yubikey

### Development Environment

The repository includes a development shell with direnv integration:

- **Automatic activation**: When direnv is installed, the shell loads automatically on `cd`
- **Manual activation**: `nix develop`
- **Available tools**: just, nixd (Nix LSP), sops, age, age-plugin-yubikey, pam_u2f, pamtester
- **Formatters**: All treefmt formatters are available in the dev shell
