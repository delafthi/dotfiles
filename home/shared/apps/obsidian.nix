{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  programs.obsidian.enable = true;
}
