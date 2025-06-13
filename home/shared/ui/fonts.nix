{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  gtk.font = {
    package = pkgs.noto-fonts;
    name = "Noto Sans";
    size = 12;
  };
}
