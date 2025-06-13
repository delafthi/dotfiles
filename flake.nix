{
  description = "delafthi's dotfiles";

  inputs = {
    # keep-sorted start
    catppuccin.url = "github:catppuccin/nix";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:LnL7/nix-darwin";
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
      { config, lib, ... }:
      {
        imports = [ inputs.treefmt-nix.flakeModule ];
        flake =
          let
            mergeAttrSets = sets: builtins.foldl' (acc: set: acc // set) { } sets;
          in
          {
            darwinConfigurations = mergeAttrSets [
              (
                let
                  host = "Thierrys-MacBook-Air";
                  ssh-keys = [
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIED0iUQ9rApXnM61UGv7Jm4bZx0xCaV+wEPlIShkoy8P openpgp:0x71B978AF"
                  ];
                  system = "aarch64-darwin";
                  user = "delafthi";
                in
                {
                  "${host}" = inputs.darwin.lib.darwinSystem {
                    inherit system;
                    specialArgs = { inherit host ssh-keys user; };
                    modules = [
                      {
                        nixpkgs.overlays = lib.attrValues config.flake.overlays;
                      }
                      inputs.home-manager.darwinModules.home-manager
                      {
                        home-manager = {
                          extraSpecialArgs = { inherit user; };
                          useGlobalPkgs = true;
                          useUserPackages = true;
                          users.${user} = {
                            imports = [
                              inputs.catppuccin.homeModules.catppuccin
                              inputs.sops-nix.homeManagerModules.sops
                              inputs.zen-browser.homeModules.beta
                              config.flake.homeModules
                              ./hosts/darwin/macbookair/home.nix
                            ];
                          };
                        };
                      }
                      ./hosts/darwin/macbookair/configuration.nix
                    ];
                  };
                }
              )
            ];
            nixosConfigurations = mergeAttrSets [
              (
                let
                  host = "Thierrys-MacBook-Air-VM";
                  ssh-keys = [
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIED0iUQ9rApXnM61UGv7Jm4bZx0xCaV+wEPlIShkoy8P openpgp:0x71B978AF"
                  ];
                  system = "aarch64-linux";
                  user = "delafthi";
                in
                {
                  "${host}" = inputs.nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit host ssh-keys user; };
                    inherit system;
                    modules = [
                      {
                        nixpkgs.overlays = lib.attrValues config.flake.overlays;
                      }
                      inputs.catppuccin.nixosModules.catppuccin
                      inputs.home-manager.nixosModules.home-manager
                      {
                        home-manager = {
                          extraSpecialArgs = { inherit user; };
                          useGlobalPkgs = true;
                          useUserPackages = true;
                          users.${user} = {
                            imports = [
                              inputs.catppuccin.homeModules.catppuccin
                              inputs.sops-nix.homeManagerModules.sops
                              inputs.zen-browser.homeModules.beta
                              config.flake.homeModules
                              ./hosts/nixos/vm/home.nix
                            ];
                          };
                        };
                      }
                      ./hosts/nixos/vm/configuration.nix
                    ];
                  };
                }
              )
            ];
            homeModules = import ./modules/home;
            overlays = import ./overlays;
          };
        systems = [
          "aarch64-linux"
          "x86_64-linux"
          "aarch64-darwin"
        ];
        perSystem =
          {
            lib,
            pkgs,
            system,
            ...
          }:
          {
            _module.args.pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = lib.attrValues config.flake.overlays;
            };
            packages = import ./pkgs pkgs;
            devShells = {
              default = pkgs.mkShell {
                name = "dotfiles";
                packages = with pkgs; [
                  just
                  nixd
                ];
              };
            };
            treefmt = {
              projectRootFile = "flake.nix";
              programs = {
                actionlint.enable = true;
                deadnix.enable = true;
                fish_indent.enable = true;
                keep-sorted.enable = true;
                nixfmt.enable = true;
                prettier.enable = true;
                shellcheck.enable = true;
                shfmt.enable = true;
                statix.enable = true;
              };
              settings = {
                editorconfig-checker = {
                  command = pkgs.editorconfig-checker;
                  includes = [ "*" ];
                  priority = 9; # last
                };
              };
            };
          };
      }
    );
}
