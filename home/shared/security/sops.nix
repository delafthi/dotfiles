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
    };
  };
  systemd.user.services.sops-nix = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    Service = {
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };
  launchd.agents.sops-nix = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    config = {
      EnvironmentVariables.PATH = pkgs.lib.mkForce "/usr/bin:/bin:/usr/sbin:/sbin";
      KeepAlive = lib.mkForce {
        Crashed = true;
        SuccessfulExit = false;
      };
    };
  };
}
