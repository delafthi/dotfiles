{
  programs.zathura = {
    enable = true;
    mappings = {
      "<C-j>" = "zoom out";
      "<C-k>" = "zoom in";
    };
    options = {
      adjust-open = "best-fit";
      completion-bg = "#22262d";
      completion-fg = "#abb2bf";
      completion-highlight-bg = "#22262d";
      completion-highlight-fg = "#61afef";
      completion-group-bg = "#22262d";
      completion-group-fg = "#c8cdd5";
      default-fg = "#abb2bf";
      default-bg = "#282c34";
      font = "Fira Code Nerd Font 12";
      highlight-color = "#e5c07b";
      highlight-fg = "#282c34";
      highlight-active-color = "#c678dd";
      index-bg = "#22262d";
      index-fg = "#abb2bf";
      index-active-bg = "#22262d";
      index-active-fg = "#61afef";
      inputbar-bg = "#22262d";
      inputbar-fg = "#abb2bf";
      notification-bg = "#22262d";
      notification-fg = "#abb2bf";
      notification-error-bg = "#e06c75";
      notification-error-fg = "#282c34";
      notification-warning-bg = "#e5c07b";
      notification-warning-fg = "#282c34";
      render-loading-bg = "#282c34";
      render-loading-fg = "#abb2bf";
      statusbar-bg = "#22262d";
      statusbar-fg = "#abb2bf";
      recolor = "false";
      recolor-keephue = "true";
      sandbox = "none";
    };
  };
}