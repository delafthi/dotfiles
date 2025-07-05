{ pkgs, ... }:
{
  imports = [
    ./ux.nix
  ];
  home.packages = with pkgs; [
    iina
    shottr
    utm
  ];
}
