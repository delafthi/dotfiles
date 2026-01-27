{
  config,
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  gtk = {
    enable = true;
    colorScheme = "dark";
    font = {
      name = builtins.head config.fonts.fontconfig.defaultFonts.sansSerif;
      size = 12;
    };
  };
}
