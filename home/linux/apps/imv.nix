{ config, osConfig, ... }:
{
  programs.imv = {
    inherit (osConfig.system.gui) enable;
    settings.options.overlay_font = builtins.head config.fonts.fontconfig.defaultFonts.sansSerif;
  };
}
