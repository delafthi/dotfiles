{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  programs.swaylock.enable = true;
}
