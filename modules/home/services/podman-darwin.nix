{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.services.podman-darwin;
in
{
  options = {
    services.podman-darwin = {
      enable = lib.mkEnableOption "Podman, a daemonless container engine";

      package = lib.mkPackageOption pkgs "podman" { };
    };
  };

  config = {
    home.packages = [ cfg.package ];

    launchd.agents.podman = {
      enable = true;
      config = {
        ProgramArguments = [
          (lib.getExe cfg.package)
          "machine"
          "start"
        ];
        ProcessType = "Interactive";
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        RunAtLoad = true;
      };
    };
  };
}
