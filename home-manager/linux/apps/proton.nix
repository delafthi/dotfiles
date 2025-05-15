{ pkgs, ... }:
{
  home.packages = with pkgs; [
    proton-pass
    protonmail-desktop
    protonvpn-gui
  ];
}
