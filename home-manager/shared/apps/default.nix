{ pkgs, ... }:
{
  imports = [
    ./browser.nix
  ];
  home.packages = with pkgs; [
    blender
    vesktop
    zotero
  ];
}
