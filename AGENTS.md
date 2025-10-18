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
- **JSON/YAML**: prettier
- **EditorConfig**: editorconfig-checker

### Best Practices

- Use flake-parts for modular flake organization
- Follow NixOS wiki conventions for `stateVersion`
- Keep flake inputs sorted with keep-sorted comments
- Use descriptive variable names (e.g., `host`, `user`, `ssh-keys`)
- Prefer `imports = [ ]` pattern for modular organization
- Use `mkDerivation` with explicit `meta.mainProgram` for custom packages
- Test configurations on target systems before committing
- NEVER add comments to code unless explicitly requested
