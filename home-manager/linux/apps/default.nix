{ pkgs, ... }:
{
  imports = [
    ./creative.nix
    ./proton.nix
  ];
  home.packages = with pkgs; [
    element-desktop
    mpv
    transmission_4-gtk
    virt-manager
  ];
}
