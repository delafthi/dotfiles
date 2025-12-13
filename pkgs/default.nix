{ pkgs }:
{
  proton-pass-cli = pkgs.callPackage ./proton-pass-cli { };
  tmux-gh-dash = pkgs.callPackage ./tmux-gh-dash { };
  tmux-scratch-terminal = pkgs.callPackage ./tmux-scratch-terminal { };
  tmux-sessionizer = pkgs.callPackage ./tmux-sessionizer { };
}
