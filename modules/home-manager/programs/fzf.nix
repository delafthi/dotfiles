{ pkgs }: {
  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd --type d --hidden --strip-cwd-prefix --exclude .git";
    changeDirWidgetOptions = [
      "--preview= '${pkgs.eza}/bin/eza --tree --color=always {} | head -200'"
    ];
    # TODO: Load the colors from folke/tokyonight.nvim
    colors = {
      "bg+" = "#283457";
      bg = "#16161e";
      border = "#27a1b9";
      fg = "#c0caf5";
      gutter = "#16161e";
      header = "#ff9e64";
      "hl+" = "#2ac3de";
      hl = "#2ac3de";
      info = "#545c7e";
      marker = "#ff007c";
      pointer = "#ff007c";
      prompt = "#2ac3de";
      query = "#c0caf5";
      scrollbar = "#27a1b9";
      separator = "#ff9e64";
      spinner = "#ff007c";
    };
    defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
    defaultOptions = [
      "--ansi"
      "--border=none"
      "--highlight-line"
      "--info=inline-right"
      "--layout=reverse"
    ];
    fileWidgetCommand = "fd --type f --hidden --strip-cwd-prefix --exclude .git";
    fileWidgetOptions = [
      "--preview 'bat -n --color=always --line-range :500 {}'"
    ];
  };

}
