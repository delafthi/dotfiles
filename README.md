# delafthi's dotfiles

This repository contains my personal configuration files and setup scripts for managing Linux and macOS (Darwin) environments using Nix and home-manager.

The configuration is organized using a modular approach with shared components between platforms and platform-specific settings.

## Features

- Cross-platform configuration (macOS and Linux)
- Modular organization for easy maintenance
- Managed applications, development tools, and system settings
- Secrets management with sops-nix
- Consistent theming with Catppuccin
- Automated formatting with treefmt

## Installation

To set up your environment using these dotfiles, follow the steps below:

### Prerequisites

- Ensure Nix is installed on your system. You can find installation instructions [here](https://nixos.org/download.html).
- Follow [these](https://nixos.wiki/wiki/Flakes) instructions to enable flakes.
- Install `just` with:

  ```bash
  nix shell nixpkgs#just
  ```

### Setup

1. **Clone the Repository**

```bash
git clone https://github.com/delafthi/dotfiles.git
cd dotfiles
```

2. **Apply Configurations**

For macOS:

```bash
just apply
```

For Linux:

```bash
just apply-linux
```

Note: The system will automatically detect your hostname and apply the appropriate configuration.

## Development

This repository provides several helpful commands for development:

```bash
# Format all nix files
just fmt

# Check flake validity
just check

# Update flake inputs
just update
```

## Structure

- `hosts/` - Host-specific configurations
- `home/` - Home-manager configurations
  - `darwin/` - macOS-specific settings
  - `linux/` - Linux-specific settings
  - `shared/` - Shared configurations between platforms
- `modules/` - Custom Nix modules
- `overlays/` - Package overlays
- `pkgs/` - Custom packages
