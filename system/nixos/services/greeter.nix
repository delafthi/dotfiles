{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} --asterisks --no-xsession-wrapper --remember --remember-user-session --cmd ${
          if config.system.gui.enable then "sway" else config.users.users.${user}.shell
        }";
        user = "greeter";
      };
    };
  };
  security.pam.services.greetd = {
    enableGnomeKeyring = true;
    gnupg.enable = true;
  };
}
