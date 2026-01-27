{ config, ... }:
{
  programs.dconf.enable = config.system.gui.enable;
}
