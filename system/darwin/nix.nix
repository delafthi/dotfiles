{ config, lib, ... }:
{
  nix = {
    gc.interval = [
      {
        Hour = 3;
        Minute = 15;
        Weekday = 1;
      }
    ];
    optimise.interval = lib.lists.forEach config.nix.gc.interval (e: {
      inherit (e) Minute Weekday;
      Hour = e.Hour + 1;
    });
  };
}
