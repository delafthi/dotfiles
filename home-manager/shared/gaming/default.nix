{ pkgs, ... }:
{
  home.packages = [ (pkgs.lgogdownloader.override { enableGui = false; }) ];
}
