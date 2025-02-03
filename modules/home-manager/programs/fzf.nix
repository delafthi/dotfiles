{
  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d";
    colors = {
      fg = "#c0caf5";
      bg = "#1a1b26";
      hl = "#bb9af7";
      "fg+" = "#c0caf5";
      "bg+" = "#1a1b26";
      "hl+" = "#7dcfff";
      info = "#7aa2f7";
      prompt = "#7dcfff";
      pointer = "#7dcfff";
      marker = "#9ece6a";
      spinner = "#9ece6a";
      header = "#9ece6a";
    };
    defaultCommand = "fd --type f";
    defaultOptions = [
      "--reverse"
    ];
    fileWidgetCommand = "fd --type f";
  };

}
