{ pkgs, ... }:
{
  environment.shells = with pkgs; [
    bashInteractive
    fish
  ];
  programs = {
    bash.completion.enable = true;
    fish = {
      enable = true;
      useBabelfish = true;
    };
  };
}
