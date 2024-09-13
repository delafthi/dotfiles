{
  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d";
    colors = {
      fg = "#abb2bf";
      "fg+" = "#c8cdd5";
      bg = "#282c34";
      "bg+" = "#22262d";
      hl = "#e5c07b";
      "hl+" = "#e5c07b";
      border = "#3e4451";
      header = "#e06c75";
      info = "#98c379";
      marker = "#d19a66";
      pointer = "#be5046";
      prompt = "#c678dd";
      spinner = "#c678dd";
    };
    defaultCommand = "fd --type f";
    fileWidgetCommand = "fd --type f";
    tmux = {
      enableShellIntegration = true;
    };
  };

}
