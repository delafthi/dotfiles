pkgs: {
  codex-rs = pkgs.callPackage ./codex-rs.nix { };
  tmux-gh-dash = pkgs.callPackage ./tmux-gh-dash { };
  tmux-scratch-terminal = pkgs.callPackage ./tmux-scratch-terminal { };
  tmux-sessionizer = pkgs.callPackage ./tmux-sessionizer { };
}
