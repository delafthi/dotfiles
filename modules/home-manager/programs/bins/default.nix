{
  home = {
    file.".local/bin/tmux-sessionizer" = {
      source = ./tmux-sessionizer;
      executable = true;
    };
    sessionPath = ["$HOME/.local/bin"];
    shellAliases = {
      tms = "tmux-sessionizer";
      cdp = "tmux-sessionizer";
    };
  };
}
