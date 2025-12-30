{
  lib,
  osConfig,
  zen-browser,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  home.packages = [ zen-browser.default ];
}
