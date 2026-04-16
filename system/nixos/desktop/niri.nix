{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.system.gui.enable {
  programs.niri.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = "*";
      niri."org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = { };
  environment.systemPackages = with pkgs; [
    brightnessctl
    wl-clipboard-rs
    wlrctl
  ];
}
