{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  targets.darwin.defaults.screencapture = {
    location = "~/Library/Mobile Documents/com~apple~CloudDocs/00-inbox/screenshots";
    type = "png";
  };
}
