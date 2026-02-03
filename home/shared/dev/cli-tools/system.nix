{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dust
    procs
    usbutils
    watch
  ];
  programs.btop.enable = true;
}
