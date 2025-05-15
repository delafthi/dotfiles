{ pkgs, ... }:
{
  home.packages = with pkgs; [
    just
    tokei
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
