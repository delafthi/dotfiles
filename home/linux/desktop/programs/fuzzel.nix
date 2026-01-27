{
  config,
  ...
}:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      font = builtins.head config.fonts.fontconfig.defaultFonts.sansSerif;
      terminal = "ghostty --command";
    };
  };
}
