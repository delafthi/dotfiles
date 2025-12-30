{ lib, ... }:
{
  options.system.gui.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable GUI";
  };
}
