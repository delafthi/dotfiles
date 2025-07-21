{ pkgs, ... }:
{
  imports = [
    ./coms
  ];
  home.packages = with pkgs; [
    blender
    qmk
    signal-desktop-bin
    # vesktop
    zotero
  ];
}
