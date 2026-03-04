{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  targets.darwin.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
    };
  };
}
