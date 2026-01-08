{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.system.gui.enable {
  environment.systemPackages = [ pkgs.wl-clipboard-rs ];
  services.desktopManager.cosmic.enable = true;
}
