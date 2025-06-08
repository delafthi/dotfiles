{ pkgs, ... }:
{
  home.packages = with pkgs; [
    asciinema
    charm-freeze
    hyperfine
    vhs
  ];
}
