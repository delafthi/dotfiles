{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
  };
}
