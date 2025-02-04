{ pkgs ? import <nixpkgs> { } }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -g display-time 4000
      set -s escape-time 0
      set -g renumber-windows on
      set -g set-clipboard on
      set -g set-titles on
      set -g set-titles-string "#T"
      set -g status-keys "emacs"

      # keybindings
      bind -N "Change to the next window" C-n next-window
      bind -N "Change to the previous window" C-p previous-window
      bind -N "Source the tmux config file" R run-shell "\
        tmux source-file ~/.config/tmux/tmux.conf > /dev/null; \
        tmux display-message 'Sourced ~/.config/tmux/tmux.conf'"
      bind -N "Open file browser" f popup -h 90% -w 90% "${pkgs.yazi}/bin/yazi"
      bind -N "Open lazygit" g popup -h 90% -w 90% -E "${pkgs.lazygit}/bin/lazygit"
      bind -N "Open tmux-sessionizer" p popup -h 60% -w 60% -E "~/.local/bin/tmux-sessionizer"
      bind -N "Open scratch terminal" t popup -h 90% -w 90% ""


      # statusbar
      set -g status-interval 5
      set -g status-left "#[fg=blue,bold]#S #[fg=default,nobold]#(starship module git_branch | $HOME/.config/tmux/ansi2tmux.pl)#[fg=default,nobold]#(starship module git_status | $HOME/.config/tmux/ansi2tmux.pl) "
      set -g status-left-length 70
      set -g status-right "%a %b %e %H:%M"
      set -g status-position "top"
      set -g status-style bg=default,fg=white
      set -g window-status-current-format "#[fg=brightblack,nobold,bg=default][#[fg=brightblack,nobold,bg=default]#I #[fg=magenta,nobold,bg=default]#F #[fg=blue,blue,bold,bg=default]#W#[fg=brightblack,nobold,bg=default]]"
      set -g window-status-format "#[fg=brightblack,nobold,bg=default][#[fg=brightblack,bg=default]#I #F #[fg=white,bg=default]#W#[fg=brightblack,nobold,bg=default]]"

      # theme
      set -g copy-mode-current-match-style bg=brightblack,fg=white
      set -g copy-mode-current-match-style bg=blue,fg=white
      set -g copy-mode-mark-style bg=brightblack
      set -g display-panes-colour black
      set -g display-panes-active-colour blue
      set -g message-style bg=magenta,fg=black
      set -g message-command-style bg=black,fg=white
      set -g pane-border-style bg=default,fg=brightblack
      set -g pane-active-border-style bg=default,fg=blue
    '';
    focusEvents = true;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    plugins = with pkgs; [
      tmuxPlugins.resurrect
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
    reverseSplit = true;
    secureSocket = true;
    shortcut = "a";
  };
  xdg.configFile."tmux/ansi2tmux.pl" = {
    source = ./ansi2tmux.pl;
    executable = true;
  };
}
