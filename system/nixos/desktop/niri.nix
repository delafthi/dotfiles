{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.system.gui.enable {
  programs.niri.enable = true;
  security.pam.services.swaylock = { };
  environment.systemPackages = with pkgs; [
    brightnessctl
    wl-clipboard-rs
    wlrctl
  ];
}
