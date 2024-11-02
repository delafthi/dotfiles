{
  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d";
    defaultCommand = "fd --type f";
    fileWidgetCommand = "fd --type f";
    tmux = {
      enableShellIntegration = true;
    };
  };

}
