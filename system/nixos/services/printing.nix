{ lib, config, ... }:
lib.mkIf config.system.gui.enable {
  services.printing.enable = true;
}
