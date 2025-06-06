{ pkgs, ... }:
{
  imports = [
    ./creative.nix
    ./proton.nix
  ];
  home.packages = with pkgs; [
    element-desktop
    mpv
    virt-manager
  ];
}
