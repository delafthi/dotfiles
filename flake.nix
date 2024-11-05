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
    zjstatus.url = "github:dj95/zjstatus";
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , darwin
    , home-manager
    , zjstatus
    , ...
    }:
    let
      inherit (self) outputs;
      system = "aarch64-darwin";
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      darwinConfigurations = {
        "Thierrys-MacBook-Air" = darwin.lib.darwinSystem {
          inherit system;
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              (final: prev: {
                zjstatus = zjstatus.packages.${prev.system}.default;
              })
            ];
          };
          specialArgs = { inherit inputs; };
          modules = [
            ./modules/darwin/configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.delafthi = import ./modules/home-manager/home.nix;
              };
              users.users.delafthi.home = "/Users/delafthi";
            }
          ];
        };
      };
    };
}
