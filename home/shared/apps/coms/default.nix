{ pkgs, ... }:
{
  imports = [
    ./iamb.nix
  ];
  home.packages = with pkgs; [
    discord
    signal-desktop-bin
  ];
}
