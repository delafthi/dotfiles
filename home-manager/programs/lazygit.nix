{
  programs.lazygit = {
    enable = true;
    settings = {
      gui.nerdFontsVersion = "3";
      git.paging = {
        externalDiffCommand = "difft --color=always --display=side-by-side-show-both";
      };
    };
  };
}
