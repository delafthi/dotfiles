{ pkgs }:
{
  tmux-gh-dash = pkgs.callPackage ./tmux-gh-dash { };
  tmux-scratch-terminal = pkgs.callPackage ./tmux-scratch-terminal { };
}
