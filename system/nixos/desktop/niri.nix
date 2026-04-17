{
  lib,
  config,
  ...
}:
lib.mkIf config.system.gui.enable {
  programs.niri.enable = true;
  security.pam.services.swaylock = { };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
