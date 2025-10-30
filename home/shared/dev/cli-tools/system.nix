{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dust
    htop
    procs
    watch
  ];
}
