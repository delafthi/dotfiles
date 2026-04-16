{
  lib,
  config,
  ...
}:
lib.mkIf config.system.gui.enable {
  services.udisks2.enable = true;
}
