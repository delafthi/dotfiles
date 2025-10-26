{ lib, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$localip"
        "$shlvl"
        "$singularity"
        "$kubernetes"
        "$directory"
        "$vcsh"
        "$fossil_branch"
        "$fossil_metrics"
        "\${custom.git_branch}"
        "\${custom.git_commit}"
        "$git_state"
        "$git_metrics"
        "\${custom.git_status}"
        "\${custom.jj_bookmark}"
        "\${custom.jj_change}"
        "\${custom.jj_status}"
        "$all"
      ];
      add_newline = true;
      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
      };
      custom = {
        git_branch = {
          when = "! jj --ignore-working-copy root";
          command = "starship module git_branch";
          description = "Only show git_branch if we're not in a jj repo";
        };
        git_commit = {
          when = "! jj --ignore-working-copy root";
          command = "starship module git_commit";
          description = "Only show git_commit if we're not in a jj repo";
        };
        git_status = {
          when = "! jj --ignore-working-copy root";
          command = "starship module git_status";
          description = "Only show git_status if we're not in a jj repo";
        };
        jj_bookmark = {
          when = "jj --ignore-working-copy root";
          command = lib.concatStringsSep " " [
            "jj log"
            "--revisions @"
            "--no-graph"
            "--ignore-working-copy"
            "--limit 1"
            "--template 'if(bookmarks.len() != 0, bookmarks, \"-\")'"
          ];
          description = "The current jj bookmark";
          detect_folders = [ ".jj" ];
          format = "[$symbol$output]($style) ";
          ignore_timeout = true;
          symbol = " ";
          style = "bold purple";
        };
        jj_change = {
          when = "jj --ignore-working-copy root";
          command = lib.concatStringsSep " " [
            "jj log"
            "--revisions @"
            "--no-graph"
            "--ignore-working-copy"
            "--limit 1"
            "--template 'change_id.shortest(7)'"
          ];
          description = "The current jj change id";
          detect_folders = [ ".jj" ];
          format = "[\\($output\\)]($style) ";
          ignore_timeout = true;
          style = "bold green";
        };
        jj_status = {
          when = "jj --ignore-working-copy root";
          command = lib.concatStringsSep " " [
            "jj log"
            "--revisions @"
            "--no-graph"
            "--ignore-working-copy"
            "--limit 1"
            "--template 'concat( if(conflict, \"=\"), if(divergent, \"⇕\"), if(hidden, \"-\"), if(immutable, \"!\"))'"
          ];
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
      git_branch.disabled = true;
      git_commit.disabled = true;
      git_status.disabled = true;
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
