{ pkgs, ... }:
{
  imports = [
    ./browser.nix
    ./proton.nix
  ];
  home.packages = with pkgs; [
    ascii-draw
    krita
    mpv
    obsidian
    transmission_4-gtk
    virt-manager
  ];
}
