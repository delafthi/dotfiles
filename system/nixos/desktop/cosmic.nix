{
  lib,
  config,
  ...
}:
lib.mkIf config.system.gui.enable {
  services.desktopManager.cosmic.enable = true;
}
