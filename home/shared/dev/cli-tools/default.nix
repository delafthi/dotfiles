{ pkgs, ... }:
{
  imports = [
    ./archives.nix
    ./files.nix
    ./find-and-navigate.nix
    ./networking.nix
    ./projects.nix
    ./system.nix
  ];
  home.packages = with pkgs; [
    asciinema
    charm-freeze
    glow
    gum
    hyperfine
    vhs
  ];
}
