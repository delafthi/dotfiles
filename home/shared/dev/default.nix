{ pkgs, ... }:
{
  imports = [
    ./cli-tools
    ./lang
    ./shells
    ./vcs
    ./ai
    ./editorconfig.nix
    ./ghostty.nix
    ./helix.nix
    ./podman.nix
    ./tmux.nix
    ./yazi.nix
  ];
  home.packages = with pkgs; [
    man-pages
    man-pages-posix
  ];
}
