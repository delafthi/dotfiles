{
  lib,
  config,
  ...
}:
lib.mkIf config.system.gui.enable {
  services.displayManager.cosmic-greeter.enable = true;
}
