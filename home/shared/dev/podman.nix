{ pkgs, ... }:
{
  services = {
    podman = {
      enable = if pkgs.stdenv.hostPlatform.isLinux then true else false;
      autoUpdate.enable = true;
    };
    podman-darwin = {
      enable = if pkgs.stdenv.hostPlatform.isDarwin then true else false;
    };
  };
}
