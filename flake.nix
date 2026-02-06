{
  description = "delafthi's dotfiles";

  inputs = {
    # keep-sorted start
    catppuccin.url = "github:catppuccin/nix";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:LnL7/nix-darwin";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    # keep-sorted end
  };

  outputs =
    inputs@{
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      toplevel@{ config, lib, ... }:
      {
        imports = [ inputs.treefmt-nix.flakeModule ];
        flake = {
          darwinConfigurations = import ./hosts/darwin { inherit config inputs lib; };
          nixosConfigurations = import ./hosts/nixos { inherit config inputs lib; };
          homeModules = import ./modules/home;
          nixosModules = import ./modules/nixos;
          overlays = import ./overlays;
        };
        systems = [
          "aarch64-linux"
          "x86_64-linux"
          "aarch64-darwin"
        ];
        perSystem =
          {
            config,
            lib,
            pkgs,
            system,
            ...
          }:
          {
            _module.args.pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = lib.attrValues toplevel.config.flake.overlays;
            };
            apps = {
              apply = import ./nix/apps/apply.nix { inherit pkgs; };
              setup-yubico-pam = import ./nix/apps/setup-yubico-pam.nix { inherit pkgs; };
              test-yubico-pam = import ./nix/apps/test-yubico-pam.nix { inherit pkgs; };
              default = config.apps.apply;
            };
            packages = import ./pkgs { inherit pkgs; };
            devShells = import ./nix/shell.nix { inherit config pkgs; };
            treefmt = import ./nix/treefmt.nix;
          };
      }
    );
}
