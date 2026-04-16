{
  config,
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "${builtins.head config.fonts.fontconfig.defaultFonts.sansSerif}:size=14";
        width = 40;
        lines = 12;
        terminal = "ghostty -e";
      };
    };
  };
}
