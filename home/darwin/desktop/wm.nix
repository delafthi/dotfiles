{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  targets.darwin.defaults = {
    "com.apple.desktopservices" = {
      DSDontDriveNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
    "com.apple.WindowManager" = {
      EnableStandardClickToShowDesktop = false;
      EnableTilingByEdgeDrag = true;
      EnableTopTilingByEdgeDrag = true;
      EnableTilingOptionAccelerator = true;
    };
  };
}
