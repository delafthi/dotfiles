pkgs: {
  opencode = pkgs.callPackage ./opencode { };
  tmux-gh-dash = pkgs.callPackage ./tmux-gh-dash { };
  tmux-scratch-terminal = pkgs.callPackage ./tmux-scratch-terminal { };
  tmux-sessionizer = pkgs.callPackage ./tmux-sessionizer { };
}
