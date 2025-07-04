{ pkgs, ... }:
{
  services =
    if pkgs.hostPlatform.isDarwin then { podman-darwin.enable = true; } else { podman.enable = true; };
}
