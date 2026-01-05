{ pkgs, ... }:
{
  home.packages = with pkgs; [
    curl
    jq
  ];
}
