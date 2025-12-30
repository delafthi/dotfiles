{
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    lib.optionals osConfig.system.gui.enable [
      ice-bar
      raycast
    ];
}
