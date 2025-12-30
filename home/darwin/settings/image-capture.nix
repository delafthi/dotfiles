{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  targets.darwin.defaults."com.apple.ImageCapture" = {
    disableHotPlug = true;
  };
}
