{ pkgs, ... }:
{
  home.packages = with pkgs; [
    curl
    sshs
  ];
}
