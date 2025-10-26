{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
      };
      custom = {
        jj_change = {
          when = "jj --ignore-working-copy root";
          command = ''
            jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 \
              --template 'separate(" ", change_id.shortest(4), bookmarks)'
          '';
          description = "The current jj change";
          detect_folders = [ ".jj" ];
          format = "[$symbol]($style)$output ";
          ignore_timeout = true;
          symbol = " ";
        };
        jj_status = {
          when = "jj --ignore-working-copy root";
          command = ''
            jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 \
              --template 'concat( if(conflict, "="), if(divergent, "⇕"), if(hidden, "-"), if(immutable, "!"))'
          '';
          description = "The current jj status";
          detect_folders = [ ".jj" ];
          format = "([\\[ $output \\]]($style) )";
          ignore_timeout = true;
          style = "bold red";
        };
      };
      directory = {
        truncation_length = 1;
        truncate_to_repo = false;
        fish_style_pwd_dir_length = 3;
      };
      right_format = "$command_duration";
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
    };
  };
}
