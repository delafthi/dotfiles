{ config, lib, pkgs, ... }:
{
  nix = {
    extraOptions = ''
      connect-timeout = 10
      keep-derivations = true
      keep-going = true
      keep-outputs = true
    '';
    gc = {
      automatic = true;
      interval = [
        {
          Hour = 3;
          Minute = 15;
          Weekday = 1;
        }
      ];
    };
    optimise = {
      automatic = true;
      interval = lib.lists.forEach config.nix.gc.interval (e: {
        inherit (e) Minute Weekday;
        Hour = e.Hour + 1;
      });
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      sandbox = true;
      trusted-users = if pkgs.hostPlatform.isDarwin then [ "@admin" ] else [ "@wheel" ];
    };
  };
}
