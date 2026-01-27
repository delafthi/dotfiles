{ config, ... }:
{
  programs.swaylock = {
    enable = true;
    settings = {
      daemonize = true;
      image = "${config.home.homeDirectory}/Pictures/background.jpg";
      scaling = "fill";
    };
  };
}
