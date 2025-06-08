{ pkgs, ... }:
{
  imports = [
    ./proton.nix
  ];
  home.packages = with pkgs; [
    ascii-draw
    element-desktop
    krita
    mpv
    obsidian
    transmission_4-gtk
    virt-manager
  ];
}
