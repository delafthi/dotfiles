{ lib, pkgs, ... }:
{
  security.pam.u2f.settings = {
    authfile = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin "/etc/Yubico/u2f_keys";
    cue = true;
  };
}
