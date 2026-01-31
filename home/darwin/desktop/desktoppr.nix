{ pkgs, ... }:
{
  programs.desktoppr = {
    enable = true;
    settings.picture = pkgs.wallpaper;
  };
}
