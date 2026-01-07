{
  config,
  lib,
  pkgs,
  sops,
  ...
}:
{
  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yml;
    package = sops.sops-install-secrets.overrideAttrs (
      _: prev: {
        nativeBuildInputs = prev.nativeBuildInputs ++ [ pkgs.makeBinaryWrapper ];
        postFixup = ''
          wrapProgram $out/bin/sops-install-secrets \
            --prefix PATH : ${lib.makeBinPath [ pkgs.age-plugin-yubikey ]}
        '';
      }
    );
    secrets = {
      "api-keys/context7" = { };
      "api-keys/openrouter" = { };
      "atuin/key" = { };
      "atuin/session" = { };
      "ssh/deaa/private" = {
        path = "${config.home.homeDirectory}/.ssh/id_deaa";
      };
      "ssh/deaa/public" = {
        path = "${config.home.homeDirectory}/.ssh/id_deaa.pub";
      };
      "ssh/github.com/private" = {
        path = "${config.home.homeDirectory}/.ssh/id_github.com";
      };
      "ssh/github.com/public" = {
        path = "${config.home.homeDirectory}/.ssh/id_github.com.pub";
      };
      "ssh/github.zhaw.ch/private" = {
        path = "${config.home.homeDirectory}/.ssh/id_github.zhaw.ch";
      };
      "ssh/github.zhaw.ch/public" = {
        path = "${config.home.homeDirectory}/.ssh/id_github.zhaw.ch.pub";
      };
      "zhaw/clt-dsk-t-6006/private" = {
        path = "${config.home.homeDirectory}/.ssh/id_clt-dsk-t-6006";
      };
      "zhaw/clt-dsk-t-6006/public" = {
        path = "${config.home.homeDirectory}/.ssh/id_clt-dsk-t-6006.pub";
      };
    };
  };
  systemd.user.services.sops-nix = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    Service = {
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };
  launchd.agents.sops-nix = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    config.KeepAlive = lib.mkForce {
      Crashed = true;
      SuccessfulExit = false;
    };
  };
}
