{ pkgs, ... }:
{
  imports = [
    ./coms
    ./browser.nix
  ];
  home.packages = with pkgs; [
    # blender
    # kicad
    qmk
  ];
}
