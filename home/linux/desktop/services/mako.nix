{ config, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      achor = "top-right";
      default-timeout = 5000;
      font = builtins.head config.fonts.fontconfig.defaultFonts.sansSerif;
    };
  };
}
