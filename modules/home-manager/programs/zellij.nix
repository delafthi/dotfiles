{ pkgs ? import <nixpkgs> { } }: {
  home.shellAliases = {
    zel = "zellij";
  };
  programs.zellij = {
    enable = true;
    settings = {
      copy-on-select = false;
      pane_frames = false;
      theme = "tokyo-night";
    };
  };
  xdg.configFile."zellij/layouts/default.kdl".text = ''
    layout {
      default_tab_template {
        pane size=1 borderless=true {
          plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
            format_left   "{mode} {command_git_branch}"
            format_center "{tabs}"
            format_right  "{datetime}"
            format_space  ""

            border_enabled  "false"

            command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
            command_git_branch_format      "#[fg=white] {stdout} "
            command_git_branch_interval    "10"
            command_git_branch_rendermode  "static"

            hide_frame_for_single_pane "false"

            mode_normal        "#[bg=blue,fg=black,bold] NORMAL "
            mode_locked        "#[bg=red,fg=black,bold] LOCKED "
            mode_resize        "#[bg=cyan,fg=black,bold] RESIZE "
            mode_pane          "#[bg=magenta,fg=black,bold] PANE "
            mode_tab           "#[bg=green,fg=black,bold] TAB "
            mode_scroll        "#[bg=cyan,fg=black,bold] SCROLL "
            mode_enter_search  "#[bg=yellow,fg=black,bold] ENT-SEARCH "
            mode_search        "#[bg=yellow,fg=black,bold] SEARCH "
            mode_rename_tab    "#[bg=green,fg=black,bold] RENAME TAB"
            mode_rename_pane   "#[bg=magenta,fg=black,bold] RENAME PANE"
            mode_session       "#[bg=white,fg=black,bold] SESSION "
            mode_move          "#[bg=cyan,fg=black,bold] MOVE "
            mode_prompt        "#[bg=magenta,fg=black,bold] PROMPT "
            mode_tmux          "#[bg=#ff9e64,fg=black,bold] TMUX "

            mode_default_to_mode "normal"

            tab_normal   "#[fg=#565f89] [{name}] "
            tab_active   "#[fg=blue,bold] [{name}] "

            datetime          "#[fg=white,bold] {format} "
            datetime_format   "%A, %d %b %Y %H:%M"
            datetime_timezone "Europe/Zurich"
          }
        }
        children
      }
    }
  '';
}
