{
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = blur-my-shell; }
      { package = caffeine; }
      { package = dash-to-dock; }
      { package = gnome-40-ui-improvements; }
      { package = move-clock; }
      { package = notification-banner-position; }
      { package = search-light; }
      { package = tray-icons-reloaded; }
      { package = wiggle; }
    ];
  };
}
