{ pkgs, ... }:
{
  imports = [
    ./browser.nix
  ];
  home.packages = with pkgs; [
    vesktop
    zotero
  ];
}
