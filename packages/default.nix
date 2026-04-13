{ pkgs }:
{
  tmux-gh-dash = pkgs.callPackage ./tmux-gh-dash/package.nix { };
  tmux-scratch-terminal = pkgs.callPackage ./tmux-scratch-terminal/package.nix { };
}
