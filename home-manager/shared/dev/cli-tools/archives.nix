{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnutar
    p7zip
    unrar
    unzip
    zip
  ];
}
