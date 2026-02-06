{ pkgs, ... }:
{
  home.packages = with pkgs; [
    svu
    tokei
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
