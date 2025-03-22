{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # nix-darwin
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # tokyonight ressources
    tokyonight = {
      url = "github:folke/tokyonight.nvim";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    darwin,
    home-manager,
    tokyonight,
    ...
  }: let
    darwinSystems = ["aarch64-darwin" "x86_64-darwin"];
    linuxSystems = ["aarch64-linux" "x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs (darwinSystems ++ linuxSystems);
    forDarwinSystems = nixpkgs.lib.genAttrs darwinSystems;
    forLinuxSystems = nixpkgs.lib.genAttrs linuxSystems;
    pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});
    user = "delafthi";
  in {
    formatter = forAllSystems (system: pkgs.${system}.alejandra);
    packages =
      forDarwinSystems
      (system: {
        darwinConfigurations = {
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
      })
      // forLinuxSystems (system: {
        nixosConfigurations = {
          "Thierrys-MacBook-Air" = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./modules/nixos/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  extraSpecialArgs = {inherit tokyonight;};
                  useUserPackages = true;
                  users.${user} = import ./modules/home-manager/linux/home.nix;
                };
              }
            ];
          };
        };
      });
  };
}
