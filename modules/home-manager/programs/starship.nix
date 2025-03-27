{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      aws.symbol = "  ";
      buf.symbol = " ";
      c.symbol = " ";
      cmake.symbol = " ";
      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
        vimcmd_symbol = "[<](bold green)";
        vimcmd_replace_one_symbol = "[<](bold green)";
        vimcmd_replace_symbol = "[<](bold purple)";
        vimcmd_visual_symbol = "[<](bold blue)";
      };
      conda.symbol = " ";
      crystal.symbol = " ";
      custom = {
        jj_change = {
          command = ''
            jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 \
              --template 'separate(" ", change_id.shortest(4), bookmarks)'
          '';
          description = "The current jj change";
          detect_folders = [".jj"];
          format = "[$symbol]($style)$output ";
          ignore_timeout = true;
          style = "bold purple";
          symbol = " ";
        };
        jj_status = {
          command = ''
            jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 \
              --template 'concat( if(conflict, " "), if(divergent, " "), if(hidden, " "), if(immutable, " "))'
          '';
          description = "The current jj status";
          detect_folders = [".jj"];
          format = "([\\[ $output \\]]($style) )";
          ignore_timeout = true;
          style = "bold red";
        };
      };
      dart.symbol = " ";
      directory = {
        truncation_length = 1;
        truncate_to_repo = false;
        read_only = " 󰌾";
        style = "bold blue";
        fish_style_pwd_dir_length = 3;
      };
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      fennel.symbol = " ";
      fossil_branch.symbol = " ";
      git_branch.symbol = " ";
      git_commit.tag_symbol = "  ";
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
      guix_shell.symbol = " ";
      haskell.symbol = " ";
      haxe.symbol = " ";
      hg_branch.symbol = " ";
      hostname.ssh_symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      kotlin.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      meson.symbol = "󰔷 ";
      nim.symbol = "󰆥 ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      ocaml.symbol = " ";
      package.symbol = "󰏗 ";
      perl.symbol = " ";
      php.symbol = " ";
      pijul_channel.symbol = " ";
      python.symbol = " ";
      right_format = "$cmd_duration";
      rlang.symbol = "󰟔 ";
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";
      shell = {
        disabled = false;
        bash_indicator = "\\[bsh\\]";
        fish_indicator = "";
        zsh_indicator = "\\[zsh\\]";
        ion_indicator = "\\[ion\\]";
        elvish_indicator = "\\[esh\\]";
        tcsh_indicator = "\\[tsh\\]";
        xonsh_indicator = "\\[xsh\\]";
        nu_indicator = "\\[nu\\]";
        unknown_indicator = "\\[?\\]";
        style = "#292e42";
      };
      swift.symbol = " ";
      zig.symbol = " ";
      gradle.symbol = " ";
    };
  };
}
