{ osConfig, ... }:
{
  programs.imv = {
    inherit (osConfig.system.gui) enable;
    settings.options.overlay_font = "IosevkaTermSlab Nerd Font Mono";
  };
}
