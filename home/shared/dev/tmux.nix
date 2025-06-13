{
  config,
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      tmux-gh-dash
      tmux-scratch-terminal
      tmux-sessionizer
    ];
    shellAliases = {
      cdp = "tmux-sessionizer";
    };
  };
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    extraConfig = ''
      # Settings
      set -g allow-passthrough on
      set -g display-time 4000
      set -g escape-time 0
      set -g renumber-windows on
      set -g set-clipboard on
      set -g set-titles on
      set -g set-titles-string "#T"
      set -g status-keys emacs # because here emacs keys are still better
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      # Keybindings
      unbind -T copy-mode-vi MouseDragEnd1Pane # Disable auto copy when selecting with the mouse
      bind -N "Change to the next window" C-n next-window
      bind -N "Change to the next window" n next-window
      bind -N "Change to the previous window" C-p previous-window
      bind -N "Change to the previous window" p previous-window
      bind -N "Open file browser" e popup -h 90% -w 90% -E "yazi"
      bind -N "Toggle maximize window" f resize-pane -Z
      bind -N "Toggle GitHub Dash" g run-shell "tmux-gh-dash"
      bind -N "Leave the copy-mode" -T copy-mode-vi i send -X cancel
      bind -N "Open projects" k run-shell "tmux-sessionizer"
      bind -N "Select a new session for the attached client interactively" S choose-session -Z
      bind -N "Source the tmux config file" r run-shell " \
        tmux source-file ~/.config/tmux/tmux.conf > /dev/null; \
        tmux display-message 'Sourced ~/.config/tmux/tmux.conf'"
      bind -N "Open scratch terminal" t run-shell "tmux-scratch-terminal" 
      bind -N "Enter copy-mode to copy text or view the history" V copy-mode
      bind -N "Select text in copy mode" -T copy-mode-vi v send -X begin-selection
      bind -N "Copy text in copy mode" -T copy-mode-vi y send -X copy-selection
      bind -N "Copy text in copy mode" -T copy-mode-vi M-c send -X copy-selection
      bind -N "Copy text in copy mode" -T copy-mode-vi C-S-c send -X copy-selection

      # Statusbar
      set -g status-interval 5
      set -g status-left-length 60
      set -g status-position "top"
      set -g status-right "%a %b %e %H:%M"
      set -g status-right-length 60
    '';
    focusEvents = true;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g status-left "#{E:@catppuccin_status_session} "
          set -g @catppuccin_flavor "${config.catppuccin.flavor}"
          set -g @catppuccin_status_background "none"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_status_left_separator "█"
          set -g @catppuccin_status_right_separator "█"
          set -g @catppuccin_window_default_text " #W"
          set -g @catppuccin_window_current_text " #W#{?window_zoomed_flag,[],}"
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore "on"
        '';
      }
      { plugin = open; }
      { plugin = resurrect; }
      { plugin = tmux-thumbs; }
      { plugin = yank; }
    ];
    prefix = "C-Space";
    reverseSplit = true;
    secureSocket = true;
    terminal = "tmux-256color";
  };
}
