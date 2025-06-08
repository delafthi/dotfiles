{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ascii-draw
    krita
    obsidian
  ];
}
