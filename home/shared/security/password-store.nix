{ pkgs, ... }:
{
  home.packages = [ pkgs.proton-pass-cli ];
  programs.password-store.enable = true;
}
