{ pkgs, ... }:
{
  home.packages = if pkgs.hostPlatform.isDarwin then [ pkgs.podman ] else [ ];
  services = if pkgs.hostPlatform.isLinux then { podman.enable = true; } else { };
}
