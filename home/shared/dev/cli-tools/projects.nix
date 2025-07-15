{ pkgs, ... }:
{
  home.packages = with pkgs; [
    just
    svu
    tokei
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
