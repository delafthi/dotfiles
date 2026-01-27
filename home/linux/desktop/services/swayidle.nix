{ lib, pkgs, ... }:
{
  services.swayidle = {
    enable = true;
    events = {
      before-sleep = "${lib.getExe pkgs.swaylock} -fF";
      lock = "lock";
    };
  };
}
