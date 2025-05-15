{ pkgs, ... }:
{
  services.udev.packages = [ pkgs.zsa-udev-rules ];
}
