{
  config,
  lib,
  ...
}:
lib.mkIf config.system.gui.enable {
  system.defaults.screensaver = {
    askForPassword = true;
    askForPasswordDelay = 0;
  };
}
