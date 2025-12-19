{ pkgs, ... }:
{
  imports = [
    ./coms
    ./browser.nix
    ./obsidian.nix
    ./yubikey.nix
  ];
  home.packages = with pkgs; [
    # blender
    # kicad
    qmk
  ];
}
