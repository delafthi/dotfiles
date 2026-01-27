{ config, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = config.system.gui.enable;
}
