{ lib, pkgs, ... }:
{
  services.openssh =
    {
      enable = true;
    }
    // lib.optionalAttrs pkgs.hostPlatform.isLinux {
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        X11Forwarding = true;
      };
    };
}
