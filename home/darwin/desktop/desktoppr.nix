{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  programs.desktoppr = {
    enable = true;
    settings = {
      picture = "${pkgs.wallpaper}/share/wallpapers/wallpaper.jpg";
    };
  };
}
