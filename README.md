# delafthi's dotfiles

Personal configuration files for managing Linux and macOS (Darwin) environments using Nix and home-manager.

## Features

- Cross-platform configuration (macOS and Linux/NixOS)
- Modular organization for easy maintenance
- Declarative application and system settings management
- Secrets management with sops-nix and age
- Consistent theming with Catppuccin
- Automated code formatting and linting with treefmt
- Custom packages and overlays
- GitHub Actions for automated checks and updates

## Installation

### Prerequisites

- Nix with flakes enabled ([installation guide](https://nixos.org/download.html))
- **macOS only**: nix-darwin ([installation guide](https://github.com/LnL7/nix-darwin#install))
- age key for secrets management (optional, required for sops-encrypted secrets)

### Quick Start

1. **Clone the repository**

```bash
git clone https://github.com/delafthi/dotfiles.git
cd dotfiles
```

2. **Apply the configuration**

The system auto-detects your platform and hostname:

```bash
nix shell nixpkgs#just
just apply
```

Or use Nix directly:

```bash
# macOS
sudo darwin-rebuild switch --flake .#$(hostname)

# NixOS
sudo nixos-rebuild switch --flake .#$(hostname)
```

3. **Log out and back in** to apply all settings

### Adding a New Host

1. Create a new directory under `hosts/darwin/` or `hosts/nixos/`
1. Add `configuration.nix` and `home.nix` files
1. Reference the new host in `flake.nix`
1. Update the hostname and SSH keys in the flake configuration

## Development

### Available Commands

```bash
# Format all files
nix fmt

# Check flake validity and run linters
nix flake check

# Update flake dependencies
nix flake update

# List all available commands
just --list
```

### Development Shell

The repository includes direnv integration for automatic shell activation. With direnv and nix-direnv installed, the development shell loads automatically when entering the directory.

**Manual activation:**

```bash
nix develop
```

This provides `just`, `nixd` (Nix language server), and `sops` automatically.

**Automatic activation with direnv:**

1. Install direnv and nix-direnv (included in this configuration)
1. Run `direnv allow` in the repository root
1. The development shell will activate automatically when you `cd` into the directory

## Secrets Management

Secrets are managed using [sops-nix](https://github.com/Mic92/sops-nix) with age encryption.

### Setup

1. Generate or import your age key:

```bash
# Generate a new age key
age-keygen -o ~/.config/sops/age/keys.txt

# Or use age-plugin-yubikey
age-plugin-yubikey --generate
```

2. Update `.sops.yaml` with your age key

1. Create or edit secrets:

```bash
sops secrets.yaml
```

### Structure

- `.sops.yaml` - SOPS configuration with age keys
- `secrets.yaml` - Encrypted secrets file
- Secrets are referenced in Nix configurations using `config.sops.secrets.*`

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
