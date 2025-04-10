{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tokyonight = {
      url = "github:folke/tokyonight.nvim";
      flake = false;
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {
    nixpkgs,
    darwin,
    flake-utils,
    home-manager,
    tokyonight,
    treefmt-nix,
    zen-browser,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = (import nixpkgs) {inherit system;};
      inherit (pkgs.lib) optionalAttrs;
      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      user = "delafthi";
    in {
      formatter = treefmtEval.config.build.wrapper;
      packages = {
        darwinConfigurations = optionalAttrs pkgs.hostPlatform.isDarwin {
          "Thierrys-MacBook-Air" = darwin.lib.darwinSystem {
            inherit system;
            modules = [
              ./modules/darwin/configuration.nix
              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  extraSpecialArgs = {inherit tokyonight;};
                  useUserPackages = true;
                  users.${user} = import ./modules/home-manager/darwin/home.nix;
                };
              }
            ];
          };
        };
        nixosConfigurations = optionalAttrs pkgs.hostPlatform.isLinux {
          "Thierrys-MacBook-Air" = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./modules/nixos/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  extraSpecialArgs = {
                    inherit tokyonight;
                    zen-browser = zen-browser.packages.${system};
                  };
                  useUserPackages = true;
                  users.${user} = import ./modules/home-manager/linux/home.nix;
                };
              }
            ];
          };
        };
      };
    });
}
