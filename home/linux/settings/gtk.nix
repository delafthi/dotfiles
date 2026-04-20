{
  config,
  lib,
  osConfig,
  pkgs,
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
    gtk4.theme = null;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
}
