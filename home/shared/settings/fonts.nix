{ pkgs, ... }:
{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [
        "IosevkaTermSlab Nerd Font Mono"
        "Noto Sans Mono"
      ];
      sansSerif = [
        "IosevkaAile"
        "Noto Sans"
      ];
      serif = [
        "IosevkaEtoile"
        "Noto Serif"
      ];
    };
  };
  gtk.font = {
    package = pkgs.noto-fonts;
    name = "Noto Sans";
    size = 12;
  };
}
