{ pkgs ? import <nixpkgs> { } }: {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    extraConfig = ''
      set -g copy-mode-current-match-style bg=brightblack,fg=white
      set -g copy-mode-current-match-style bg=blue,fg=white
      set -g copy-mode-mark-style bg=brightblack
      set -g display-panes-colour black
      set -g display-panes-active-colour blue
      set -g display-time 4000
      set -g focus-events on
      set -g message-style bg=brightblack,fg=white
      set -g message-command-style bg=black,fg=white
      set -g pane-border-style bg=default,fg=brightblack
      set -g pane-active-border-style bg=default,fg=blue
      set -g renumber-windows on
      set -g set-clipboard on
      set -g status-interval 5
      set -g status-keys emacs
      set -g status-left "#[fg=blue,bold]#S #[fg=default,nobold]#(starship module git_branch | $HOME/.config/tmux/ansi2tmux.pl)#[fg=default,nobold]#(starship module git_status | $HOME/.config/tmux/ansi2tmux.pl) "
      set -g status-left-length 70
      set -g status-position "top"
      set -g status-style bg=default,fg=white
      set -g set-titles on
      set -g set-titles-string "#T"
      set -g terminal-overrides ",xterm-kitty:RGB"
      set -g window-status-current-format "#[fg=brightblack,nobold,bg=default][#[fg=brightblack,nobold,bg=default]#I #[fg=magenta,nobold,bg=default]#F #[fg=blue,blue,bold,bg=default]#W#[fg=brightblack,nobold,bg=default]]"
      set -g window-status-format "#[fg=brightblack,nobold,bg=default][#[fg=brightblack,bg=default]#I #F #[fg=white,bg=default]#W#[fg=brightblack,nobold,bg=default]]"

      set-option -g detach-on-destroy off
    '';
    historyLimit = 50000;
    keyMode = "vi";
    mouse = true;
    secureSocket = true;
    shell = "\${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
  };
  xdg.configFile."tmux/ansi2tmux.pl" = {
    text = ''
      #!${pkgs.perl}/bin/perl -nw

      # This converts ANSI color escape sequences to TMUX color escape sequences,
      #   which can be used in the status line.
      # Example: "\x1b[31mERROR\x1b[0m" -> "#[fg=red,]ERROR#[default,]"

      #  By Simon Lammer

      # The following SGR codes are supported:
      # - 0
      # - 1
      # - 30 - 49
      # - 90 - 97
      # - 100 - 107

      use warnings;
      use strict;

      my @colors = ("black", "red", "green", "yellow", "blue", "magenta", "cyan", "white");
      while(/(.*?)(\x1b\[((\d+;?)+)m)/gc) {
        print "$1#[";
        my @sgr = split /;/, $3;
        for(my $i = 0; $i <= $#sgr; $i++) {
          if ($sgr[$i] eq "0") {
            print "default";
          } elsif ($sgr[$i] eq "1") {
            print "bright";
          } elsif ($sgr[$i] =~ /(3|4|9|10)(\d)/) {
            if ($1 eq "3") {
              print "fg=";
            } elsif ($1 eq "4") {
              print "bg=";
            } elsif ($1 eq "9") {
              print "fg=bright";
            } elsif ($1 eq "4") {
              print "bg=bright";
            }
            if ($2 eq "8") { # SGR 38 or 48
              $i++;
              if ($sgr[$i] eq "5") {
                $i++;
                print "colour" . $sgr[$i];
              } elsif ($sgr[$i] eq "2") {
                printf("#%02X%02X%02X", $sgr[$i + 1], $sgr[$i + 2], $sgr[$i + 3]);
                $i += 3;
              } else {
                die "Invalid SGR 38;" . $sgr[$i];
              }
            } elsif ($2 eq "9") {
              print "default";
            } else {
              print $colors[$2];
            }
          } else { # Unknown/ignored SGR code
            next;
          }
          print ",";
        }
        print "]";
      }
      /\G(.*)/gs;
      print "$1";
    '';
    executable = true;
  };
}
