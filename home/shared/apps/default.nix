{ pkgs, ... }:
{
  imports = [
    ./coms
    ./obsidian.nix
  ];
  home.packages = with pkgs; [
    # blender
    # kicad
    qmk
  ];
}
