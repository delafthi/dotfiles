{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  imports = [
    ./programs
    ./services
    ./sway.nix
  ];
}
