{
  config,
  inputs,
  lib,
}:
let
  host = "Thierrys-MacBook-Air-VM";
  ssh-keys = [ ];
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
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          extraSpecialArgs = {
            inherit user;
            sops = inputs.sops-nix.packages.${system};
            zen-browser = inputs.zen-browser.packages.${system};
          };
          useGlobalPkgs = true;
          users.${user} = {
            imports = [
              inputs.catppuccin.homeModules.catppuccin
              inputs.sops-nix.homeModules.sops
              config.flake.homeModules.default
              ./home.nix
            ];
          };
        };
      }
      config.flake.nixosModules.default
      ./configuration.nix
    ];
  };
}
