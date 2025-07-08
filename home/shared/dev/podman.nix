{ lib, pkgs, ... }:
{
  home.packages = [ pkgs.podman ];
  services = lib.optionalAttrs pkgs.hostPlatform.isLinux {
    podman.enable = true;
  };
}
