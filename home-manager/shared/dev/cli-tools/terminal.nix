{ pkgs, ... }:
{
  home.packages = with pkgs; [
    asciinema
    charm-freeze
    glow
    gum
    hyperfine
    vhs
  ];
}
