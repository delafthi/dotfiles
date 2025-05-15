{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ascii-draw
    blender
    krita
    obsidian
  ];
}
