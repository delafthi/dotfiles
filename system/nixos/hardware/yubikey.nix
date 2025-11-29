{ pkgs, ... }:
{
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
  services = {
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
  };
}
