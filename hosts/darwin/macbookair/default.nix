{
  config,
  inputs,
  lib,
}:
let
  host = "Thierrys-MacBook-Air";
  ssh-keys = [ ];
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
      ../../../modules/nix-darwin
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager = {
          extraSpecialArgs = {
            inherit user;
            llm-agents = inputs.llm-agents.packages.${system};
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
      ./configuration.nix
    ];
  };
}
