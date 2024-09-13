{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      buf.symbol = " ";
      c.symbol = " ";
      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
        vimcmd_symbol = "[<](bold green)";
        vimcmd_replace_one_symbol = "[<](bold green)";
        vimcmd_replace_symbol = "[<](bold purple)";
        vimcmd_visual_symbol = "[<](bold blue)";
      };
      directory = {
        truncation_length = 1;
        truncate_to_repo = false;
        read_only = " 󰌾";
        style = "bold blue";
        fish_style_pwd_dir_length = 3;
      };
      docker_context.symbol = " ";
      git_branch.symbol = " ";
      git_status = {
        format = "([\\[ $all_status$ahead_behind\\]]($style) )";
        style = "bold red";
        conflicted = "[ ](bold red)";
        ahead = "[\${count} ](bold purple)";
        behind = "[\${count} ](bold purple)";
        diverged = "[\${ahead_count}\${behind_count} ](bold purple)";
        untracked = "[ \${count} ](bold yellow)";
        stashed = "[ \${count} ](bold cyan)";
        modified = "[ \${count} ](bold red)";
        staged = "[ \${count} ](bold blue)";
        renamed = "[ \${count} ](bold red)";
        deleted = "[ \${count} ](bold red)";
      };
      golang.symbol = " ";
      haskell.symbol = " ";
      hostname.ssh_symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      package.symbol = "󰏗 ";
      python.symbol = " ";
      right_format = "$cmd_duration";
      rlang.symbol = "󰟔 ";
      rust.symbol = " ";
      scala.symbol = " ";
    };
  };
}
