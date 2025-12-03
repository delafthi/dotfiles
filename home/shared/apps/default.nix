{ pkgs, ... }:
{
  imports = [
    ./coms
    ./browser.nix
    ./obsidian.nix
  ];
  home.packages = with pkgs; [
    # blender
    # kicad
    qmk
  ];
}
