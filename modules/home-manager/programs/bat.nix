{tokyonight, ...}: {
  home = {
    sessionVariables = {
      MANPAGER = "sh -c 'sed -u -e \\\"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\\\" | bat -p -lman'";
      PAGER = "bat -p";
    };
  };
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
