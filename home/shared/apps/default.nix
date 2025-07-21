{ pkgs, ... }:
{
  imports = [
    ./coms
  ];
  home.packages = with pkgs; [
    blender
    qmk
    zotero
  ];
}
