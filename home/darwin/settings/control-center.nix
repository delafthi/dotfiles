{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  targets.darwin.currentHostDefaults."com.apple.controlcenter".BatteryShowPercentage = true;
}
