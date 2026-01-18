{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    dust
    procs
    watch
  ];
}
