{tokyonight}: {
  home = {
    shellAliases = {
      lazygit = "lazygit --use-config-file=$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/theme.yml";
      g = "lazygit";
    };
  };
  programs.lazygit = {
    enable = true;
    settings = {
      git.paging = {
        externalDiffCommand = "difft --color=always --display=side-by-side-show-both";
      };
      gui.nerdFontsVersion = "3";
    };
  };
  xdg = {
    configFile."lazygit/theme.yml".source = "${tokyonight}/extras/lazygit/tokyonight_night.yml";
  };
}
