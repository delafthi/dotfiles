{
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wallpaper daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${pkgs.wallpaper}/share/wallpapers/wallpaper.jpg -m fill";
      Restart = "on-failure";
    };
  };
}
