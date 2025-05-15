{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mpv
    virt-manager
  ];
}
