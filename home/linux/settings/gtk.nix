{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };
  gtk = {
    enable = true;
    colorScheme = "dark";
    font = {
      name = builtins.head config.fonts.fontconfig.defaultFonts.sansSerif;
      size = 12;
    };
    gtk4.theme = null;
  };
}
