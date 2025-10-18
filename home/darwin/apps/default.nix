{ pkgs, ... }:
{
  imports = [
    ./ux.nix
  ];
  home.packages = with pkgs; [
    aldente
    iina
    shottr
    utm
  ];
}
