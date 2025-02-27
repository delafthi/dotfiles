{
  pkgs,
  tokyonight,
}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    extraConfig =
      (builtins.readFile "${tokyonight}/extras/tmux/tokyonight_night.tmux")
      + ''
        # Settings
        set -g allow-passthrough on
        set -g default-terminal "tmux-256color"
        set -g display-time 4000
        set -s escape-time 0
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
        bind -N "Change to the previous window" C-p previous-window
        bind -N "Toggle maximize window" f resize-pane -Z
        bind -N "Open lazygit" g popup -h 90% -w 90% -E "${pkgs.lazygit}/bin/lazygit  --use-config-file=$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/theme.yml"
        bind -N "Leave the copy-mode" -T copy-mode-vi i send -X cancel
        bind -N "Open tmux-sessionizer" p popup -h 60% -w 60% -E "~/.local/bin/tmux-sessionizer"
        bind -N "Source the tmux config file" r run-shell "\
          tmux source-file ~/.config/tmux/tmux.conf > /dev/null; \
          tmux display-message 'Sourced ~/.config/tmux/tmux.conf'"
        bind -N "Select a new session for the attached client interactively" S choose-session -Z
        bind -N "Open scratch terminal" t popup -h 90% -w 90% ""
        bind -N "Open file browser" e popup -h 90% -w 90% -E "${pkgs.yazi}/bin/yazi"
        bind -N "Enter copy-mode to copy text or view the history" V copy-mode
        bind -N "Select text in copy mode" -T copy-mode-vi v send -X begin-selection
        bind -N "Select text in copy mode" -T copy-mode-vi y send -X copy-selection

        # Statusbar
        set -g status-interval 5
        set -g status-left "#[fg=blue,bold]#S #[fg=default,nobold]#(starship module git_branch | $HOME/.config/tmux/ansi2tmux.pl)#[fg=default,nobold]#(starship module git_status | $HOME/.config/tmux/ansi2tmux.pl) "
        set -g status-left-length 70
        set -g status-right "%a %b %e %H:%M"
        set -g status-position "top"
        set -g status-style bg=default,fg=white
        set -g window-status-current-format "#[fg=brightblack,nobold,bg=default][#[fg=brightblack,nobold,bg=default]#I #[fg=magenta,nobold,bg=default]#F #[fg=blue,blue,bold,bg=default]#W#[fg=brightblack,nobold,bg=default]]"
        set -g window-status-format "#[fg=brightblack,nobold,bg=default][#[fg=brightblack,bg=default]#I #F #[fg=white,bg=default]#W#[fg=brightblack,nobold,bg=default]]"
      '';
    focusEvents = true;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    reverseSplit = true;
    secureSocket = true;
    shortcut = "a";
  };
  xdg.configFile."tmux/ansi2tmux.pl" = {
    source = ./ansi2tmux.pl;
    executable = true;
  };
}
