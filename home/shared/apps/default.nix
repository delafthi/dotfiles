{ pkgs, ... }:
{
  imports = [
    ./browser.nix
  ];
  home.packages = with pkgs; [
    blender
    element-desktop
    signal-desktop-bin
    vesktop
    zotero
  ];
}
