{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.system.gui.enable {
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --asterisks --remember --remember-user-session --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --time --user-menu";
      user = "greeter";
    };
  };
  security.pam.services.greetd = {
    enableGnomeKeyring = true;
    u2fAuth = true;
  };
}
