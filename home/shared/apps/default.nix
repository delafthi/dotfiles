{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blender
    element-desktop
    signal-desktop-bin
    vesktop
    zotero
  ];
}
