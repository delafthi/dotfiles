# delafthi's dotfiles

This repository contains my personal configuration files and setup scripts for managing Linux and macOS (Darwin) environments using Nix.

## Installation

To set up your environment using these dotfiles, follow the steps below:

### Prerequisites

- Ensure Nix is installed on your system. You can find installation instructions [here](https://nixos.org/download.html).
- Follow [these](https://nixos.wiki/wiki/Flakes) instructions to enable flakes.
- Install `just` with

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

   ```bash
   just apply
   ```
