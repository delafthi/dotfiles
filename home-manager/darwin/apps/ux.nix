{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ice-bar
    raycast
  ];
}
