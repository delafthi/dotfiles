{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wallpaper daemon";
      After = [ config.wayland.systemd.target ];
      PartOf = [ config.wayland.systemd.target ];
      ConditionEnvironment = "WAYLAND_DISPLAY";
      StartLimitBurst = 5;
      StartLimitIntervalSec = 10;
    };
    Install.WantedBy = [ config.wayland.systemd.target ];
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${pkgs.wallpaper}/share/wallpapers/wallpaper.jpg -m fill";
      Restart = "on-failure";
    };
  };
}
