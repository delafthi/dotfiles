{ pkgs, ... }:
{
  home.packages = with pkgs; [
    asciinema
    hyperfine
  ];
}
