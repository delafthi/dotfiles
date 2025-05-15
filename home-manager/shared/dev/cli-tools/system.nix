{ pkgs, ... }:
{
  home.packages = with pkgs; [
    du-dust
    htop
    procs
  ];
}
