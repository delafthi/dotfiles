{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  services.swayosd.enable = true;
}
