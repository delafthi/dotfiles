{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dust
    procs
    watch
  ];
  programs.btop.enable = true;
}
