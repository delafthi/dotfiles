{
  config,
  lib,
  ...
}:
lib.mkIf config.system.gui.enable {
  system.defaults.CustomSystemPreferences."com.apple.Safari".AutoOpenSafeDownloads = false;
}
