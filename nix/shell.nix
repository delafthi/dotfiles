{ config, pkgs }:
{
  default = pkgs.mkShell {
    name = "dotfiles";
    inputsFrom = [ config.treefmt.build.devShell ];
    packages = with pkgs; [
      age
      age-plugin-yubikey
      just
      nixd
      pam_u2f
      pamtester
      sops
    ];
  };
}
