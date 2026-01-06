{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.sops ];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    gnupg.home = "${config.home.homeDirectory}/.gnupg";
    secrets = {
      atuin-key = { };
      atuin-session = { };
      context7-api-key = { };
      openrouter-api-key = { };
    };
  };
  systemd.user.services.sops-nix = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    Service = {
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
