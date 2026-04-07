{ pkgs }:
{
  tmux-gh-dash = pkgs.callPackage ./tmux-gh-dash { };
  tmux-change-session-dir = pkgs.callPackage ./tmux-change-session-dir { };
  tmux-scratch-terminal = pkgs.callPackage ./tmux-scratch-terminal { };
}
