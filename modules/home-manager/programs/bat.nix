{ tokyonight }: {
  programs.bat = {
    enable = true;
    config = {
      theme = "tokyonight_night";
      italic-text = "always";
    };
    themes = {
      tokyonight_night = {
        src = "${tokyonight}/extras/sublime";
        file = "tokyonight_night.tmTheme";
      };
    };
  };
}
