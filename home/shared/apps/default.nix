{ pkgs, ... }:
{
  imports = [
    ./coms
  ];
  home.packages = with pkgs; [
    # blender
    # kicad
    qmk
  ];
}
