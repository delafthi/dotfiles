{ pkgs, ... }:
{
  imports = [
    ./ux.nix
  ];
  home.packages = with pkgs; [
    alcove
    aldente
    iina
    lunar
    meetingbar
    monodraw
    shottr
    utm
  ];
}
