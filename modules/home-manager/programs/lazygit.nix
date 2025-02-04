{
  home = {
    shellAliases = {
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
}
