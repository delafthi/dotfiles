{ pkgs, ... }:
{
  home.packages = [ pkgs.smartcat ];
  services.ollama.enable = true;
}
