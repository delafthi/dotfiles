{ config, ... }:
{
  security.polkit.enable = config.system.gui.enable;
}
