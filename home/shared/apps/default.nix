{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blender
    element-desktop
    qmk
    signal-desktop-bin
    vesktop
    zotero
  ];
}
