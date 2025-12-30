{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  gtk = {
    enable = true;
    colorScheme = "dark";
  };
}
